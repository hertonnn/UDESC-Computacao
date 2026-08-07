-- 1) Gatilho para impedir a inserção ou atualização de Clientes com o mesmo CPF.
	-- Onde: Cliente
	-- Quando: Before
	-- Operações: Inserção ou atualização
	-- Nível: Row level

		CREATE OR REPLACE FUNCTION verifica_cpf() RETURNS TRIGGER AS 
		$$ 
		BEGIN
			IF(TG_OP = 'INSERT') THEN
				IF(SELECT 1 FROM cliente WHERE cpf = new.cpf) THEN
					RAISE EXCEPTION 'Cpf já existe.';
				END IF;
			ELSIF(TG_OP = 'UPDATE') THEN
				IF(SELECT COUNT(*) FROM cliente WHERE cpf = new.cpf) > 0 AND
				old. cpf <> new.cpf THEN
					RAISE EXCEPTION 'Cpf já existe.';
				END IF;
			END IF;
			RETURN NEW;
		END;
		$$
		LANGUAGE plpgsql;

		CREATE TRIGGER verifica_cpf BEFORE INSERT OR UPDATE
			ON cliente FOR EACH ROW EXECUTE PROCEDURE verifica_cpf();

-- 2) Gatilho para impedir a inserção ou atualização de Mecânicos com idade menor que 20 anos.
	-- Onde: Mecanico
	-- Quando: before
	-- Operações: Insert or Update
	-- Nível: row level
	
		CREATE OR REPLACE FUNCTION verifica_idade() RETURNS TRIGGER AS 
		$$
		BEGIN
			IF(new.idade < 20) THEN
				RAISE EXCEPTION 'Mecanico não pode ter menos de 20 anos.';
			END IF;
			RETURN NEW;
		END;
		$$
		LANGUAGE plpgsql;

		CREATE TRIGGER verifica_idade BEFORE INSERT OR UPDATE
			ON mecanico FOR EACH ROW EXECUTE PROCEDURE verifica_idade();

-- 3) Gatilho para atribuir um cods (sequencial) para um novo setor inserido.
	-- Onde: setor
	-- Quando: Before
	-- Operação: Insert
	-- Nível: row level


		CREATE SEQUENCE seq_cods START 5;

		CREATE OR REPLACE FUNCTION new_cods() RETURNS TRIGGER AS 
		$$
		BEGIN
			new.cods := nextval('seq_cods');
			RETURN NEW
		END;
		$$
		LANGUAGE plpgsql;

		CREATE TRIGGER new_cods BEFORE INSERT ON setor
			FOR EACH ROW EXECUTE PROCEDURE seq_cods();

-- 4) Gatilho para impedir a inserção de um mecânico ou cliente com CPF inválido.
	-- Onde: mecanico e cliente
	-- Quando: before
	-- Operação: insert or update
	-- Nível: row level

		CREATE OR REPLACE FUNCTION cpf_valido(cpf_input CHAR(11)) RETURNS BOOLEAN AS
				$$
				DECLARE
    				soma INT;
    				resto INT;
    				dv1 INT;
    				dv2 INT;
				BEGIN
    				soma := 0;
    				FOR i IN 1..9 LOOP
       					soma := soma + (CAST(SUBSTRING(cpf_input, i, 1) AS INT) * (11 - i));
    				END LOOP;

    				resto := soma % 11;
    				IF resto < 2 THEN
        				dv1 := 0;
    				ELSE
        				dv1 := 11 - resto;
    				END IF;
					
    				soma := 0;
    				FOR i IN 1..9 LOOP
        				soma := soma + (CAST(SUBSTRING(cpf_input, i, 1) AS INT) * (12 - i));
    				END LOOP;
					
    				soma := soma + dv1 * 2;	
    				resto := soma % 11;
					
    				IF resto < 2 THEN
      					dv2 := 0;
    				ELSE
        				dv2 := 11 - resto;
    				END IF;

    				IF dv1 = CAST(SUBSTRING(cpf_input, 10, 1) AS INT) AND
      					dv2 = CAST(SUBSTRING(cpf_input, 11, 1) AS INT) THEN
       					RETURN TRUE;
    				ELSE
        				RETURN FALSE;
    				END IF;
				END;
				$$
				LANGUAGE plpgsql;
		
		CREATE OR REPLACE FUNCTION valida_cpf() RETURNS TRIGGER AS 
		BEGIN
			IF(NOT cpf_valido(new.cpf)) THEN
				RAISE EXCEPTION 'cpf inválido ';
			END IF;
			RETURN NEW;
		END;
		$$
		LANGUAGE plpgsql;

		CREATE TRIGGER valida_cpf_mecanico BEFORE INSERT OR UPDATE
			ON mecanico FOR EACH ROW EXECUTE PROCEDURE valida_cpf();

		
-- 5) Gatilho para impedir que um mecânico seja removido caso não exista outro mecânico com a mesma função.
	-- Onde: mecanico
	-- Quando: before
	-- Operação: delete
	-- Nível: row level
	
		CREATE OR REPLACE FUNCTION remove_mecanico() RETURNS TRIGGER AS
		$$
		BEGIN
			IF(SELECT COUNT(*) FROM mecanico WHERE funcao ILIKE old.funcao) <=1 THEN
				RAISE EXCEPTION 'único mecanico com essa função';
			END IF;
			RETURN OLD;
		END;
		$$
		LANGUAGE plpgsql;

		CREATE TRIGGER remove_mec BEFORE DELETE ON mecanico
			FOR EACH EXECUTE PROCEDURE remove_mecanico();

-- 6) Gatilho que ao inserir, atualizar ou remover um mecânico, reflita as mesmas modificações na tabela de Cliente. 
-- Em caso de atualização, se o mecânico ainda não existir na tabela de Cliente, deve ser inserido.
	-- Tabela : mecanico
	-- Operações: insert, update, delete
	-- Quando: after
	-- Nível: row level
		
		CREATE SEQUENCE seq_codc START 10;

		CREATE OR REPLACE FUNCTION atualiza_cliente() RETURNS TRIGGER AS
		$$
		BEGIN
    		IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        		IF (SELECT COUNT(*) FROM cliente WHERE cpf = NEW.cpf) > 0 THEN
            		UPDATE cliente 
            		SET nome = NEW.nome,
                		idade = NEW.idade,
                		endereco = NEW.endereco,
                		cidade = NEW.cidade
           		 	WHERE cpf = NEW.cpf;
        			ELSE
           		 	INSERT INTO cliente (codc, cpf, nome, idade, endereco, cidade)
            				VALUES (NEXTVAL('seq_codc'), NEW.cpf, NEW.nome, NEW.idade, NEW.endereco, NEW.cidade);
        			END IF;
    
    		ELSIF (TG_OP = 'DELETE') THEN
        		DELETE FROM cliente WHERE cpf = OLD.cpf;
    		END IF;

    		RETURN NULL; -- AFTER triggers retornam null
		END;
		$$
		LANGUAGE plpgsql;


		CREATE TRIGGER atualiza_cliente AFTER INSERT OR UPDATE OR DELETE ON mecanico
			FOR EACH ROW EXECUTE FUNCTION atualiza_cliente();

-- 7) Gatilho para impedir que um conserto seja inserido na tabela Conserto se o mecânico já realizou mais de 20 horas extras no mês.--
	-- Tabela: conserto
	-- Operação: insert, update
	-- Quando: before 
	-- Nível: row level

		CREATE OR REPLACE FUNCTION calcula_hora_extra(pcodm INT, pmes INT, pano INT) RETURNS INT AS
		$$
		DECLARE
   		 	total_horas INT;
    		horas_extras INT;
		BEGIN
    		SELECT COALESCE(SUM(horas), 0) INTO total_horas
    		FROM conserto
    		WHERE codm = pcodm
      		AND EXTRACT(MONTH FROM data) = pmes
      		AND EXTRACT(YEAR FROM data) = pano;

    		IF total_horas > 160 THEN
        		horas_extras := total_horas - 160;
    		ELSE
        		horas_extras := 0;
    		END IF;

    		RETURN horas_extras;
		END;
		$$
		LANGUAGE plpgsql;

	CREATE OR REPLACE FUNCTION calcula_alocacao() RETURNS TRIGGER AS
		$$
		BEGIN
    		IF (TG_OP = 'INSERT') THEN
        		IF calcula_hora_extra(NEW.codm, EXTRACT(MONTH FROM NEW.data), EXTRACT(YEAR FROM NEW.data)) > 20 THEN
            		RAISE EXCEPTION 'Mecânico excedeu horas extras';
        		END IF;
    		ELSIF (TG_OP = 'UPDATE') THEN
        		IF calcula_hora_extra(NEW.codm, EXTRACT(MONTH FROM NEW.data), EXTRACT(YEAR FROM NEW.data)) > 20 THEN
            		RAISE EXCEPTION 'Mecânico excedeu horas extras';
        		END IF;
    		END IF;
    		RETURN NEW;
		END;
		$$
		LANGUAGE plpgsql;

		CREATE TRIGGER calcula_alocacao BEFORE INSERT OR UPDATE ON conserto
			FOR EACH ROW EXECUTE FUNCTION calcula_alocacao();

-- 8) Gatilho para impedir que mais de 1 conserto seja agendado no mesmo setor na mesma hora. 
	-- Tabela: conserto
	-- Operação: insert, update
	-- Quando: before 
	-- Nível: row level
		
		CREATE OR REPLACE FUNCTION verifica_agendamento() RETURNS TRIGGER AS
		$$
		DECLARE
    		qtd INT;
		BEGIN
 			SELECT COUNT(*) INTO qtd FROM conserto WHERE setor = NEW.setor AND data = NEW.data AND hora = NEW.hora 
			 AND (TG_OP = 'INSERT' OR id <> NEW.id);

    		IF qtd > 0 THEN
        		RAISE EXCEPTION 'Já existe um conserto agendado para este setor na mesma data e hora';
    		END IF;

    		RETURN NEW;
		END;
		$$
		LANGUAGE plpgsql;

		CREATE TRIGGER verifica_agendamento BEFORE INSERT OR UPDATE ON conserto
		FOR EACH ROW EXECUTE FUNCTION verifica_agendamento();










	


