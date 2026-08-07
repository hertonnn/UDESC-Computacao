-- 1) Crie um índice para cada uma das chaves estrangeiras presentes do esquema de dados.
	-- conserto
		-- codm 
		-- codv

		CREATE INDEX idx_con_codm ON conserto USING hash(codm);
		CREATE INDEX ins_con_codv ON conserto USING hash(codv);
		
	-- mecanico
		-- cods

		CREATE INDEX idx_me_cods ON mecanico USING hash(cods);
		
	-- veiculo
		-- codc

		CREATE INDEX idx_ve_codc ON veiculo USING hash(codc);

-- 2) Crie um índice para acelerar a busca dos mecânicos pela função.

	CREATE INDEX idx_mec_funcao ON mecanico USING hash(substr(funcao, 1, 10));

-- 3) Crie um índice para acelerar a ordenação dos consertos pela data e hora.

	CREATE INDEX idx_com_data_hora ON conserto USING btree(data, hora);

-- 4) Crie um índice para acelerar a busca de clientes pelo cpf.

	CREATE INDEX idx_cli_cpf ON cliente USING btree(cpf);

-- 5) Crie um índice para acelerar a busca pelas primeiras 5 letras do nome dos clientes.

	CREATE INDEX idx_cli_nome ON cliente USING btree(substr(nome, 1, 5));

-- 6) Crie um índice para acelerar a busca dos clientes com CPF com final XXXXXXXXX55.

	CREATE INDEX idx_cli_cpf_2 ON cliente USING btree(cpf)
		WHERE CPF ILIKE '%55';
