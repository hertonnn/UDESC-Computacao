--------------------------------------------------------------------------------
-- 1)      Recupere o CPF e o nome dos mecânicos que trabalham nos setores maiores que 100 e menores que 200.

-- Comando usado:
explain analyse select m.nome, m.cpf, cods from mecanico m where m.cods between 100 and 200

-- consulta usando indice de tabela hash:
create index idx_mec_cods on mecanico using hash(cods)
drop index idx_mec_cods

-- consulta usando indice de arvore B:
create index idx_mec_cods on mecanico using btree(cods)
drop index idx_mec_cods

--------------------------------------------------------------------------------
-- 2)      Recupere o CPF e nome dos mecânicos que atenderam no dia 13/06/2018.

-- comando usado:
explain analyse select m.cpf, m.nome, c.data from mecanico m join conserto c using(codm) where c.data = '13/06/2018'

-- index com tabela hash:
drop idx_con_D
create index idx_con_data on conserto using hash(data)


--------------------------------------------------------------------------------
-- 3)      Recupere o nome do mecânico, o nome do cliente e a hora do conserto para os consertos realizados de 12/06/2018 à 25/09/2018.

explain analyse select m.nome, c.nome, con.data, con.hora from mecanico m join conserto con using (codm) 
	join veiculo v using (codv) 
	join cliente c using (codc)
where con.data between '12/06/2018' and '25/09/2018'

drop index idx_cli_codc
create index idx_cli_codc on conserto using hash(codc)

-- Conclusão: Sem index é melhor!

--------------------------------------------------------------------------------
-- 4)      Recupere o nome e a função de todos os mecânicos, e o número e o nome dos setores para os mecânicos que tenham essa informação.

explain analyse select m.nome, m.funcao, s.nome from mecanico as m left join setor as s using(cods)

drop index idx_setor_cods
create index idx_setor_cods on setor using hash(cods)


--------------------------------------------------------------------------------
-- 5)      Recupere o nome de todos os mecânicos, e as datas dos consertos para os mecânicos que têm consertos feitos (deve aparecer apenas um registro de nome de mecânico para cada data de conserto).

explain analyse Select m.nome
from mecanico as m 
where exists (select 1 from conserto as con where m.codm = con.codm)

create index idx_mec_codm on mecanico using hash(codm)

drop index idx_mec_nome


--------------------------------------------------------------------------------
-- 6)      Recupere a média da quilometragem de todos os veículos de cada cliente, ordenando da maior KM para o menor.

explain analyse select c.nome, avg(v.quilometragem) as media_km from cliente c join veiculo v using(codc) group by c.nome order by media_km desc;

create index idx_veiculo_codc on veiculo using hash(codc);
drop index idx_veiculo_codc
--------------------------------------------------------------------------------
-- 7)      Recupere a soma da quilometragem dos veículos de cada cidade onde residem seus proprietários.

explain analyse select c.cidade, sum(quilometragem )
from veiculo as v join cliente as c using (codc)
group by c.cidade

--------------------------------------------------------------------------------
-- 8)      Recupere a quantidade de consertos feitos por cada mecânico durante o período de 12/06/2018 até 19/010/2018

explain analyse select m.nome, count(co.codv) as total_consertos from mecanico m 
	join conserto co on m.codm = co.codm where co.data between '12/06/2018' and '19/10/2018' 
	group by m.nome order by total_consertos desc;

create index idx_conserto_data on conserto using btree(data);
drop index idx_conserto_data

create index idx_conserto_data on conserto using hash(data);
drop index idx_conserto_data

create index idx_mec_nome on mecanico using hash(nome);
drop index idx_mec_nome

-- Conclusão: ganho infimo para todos os index!

--------------------------------------------------------------------------------
-- 9)   Recupere a quantidade de consertos feitos agrupada pela marca do veículo.

explain analyse select v.marca, count(*) as quantidade_consertos from
    conserto co join veiculo v on co.codv = v.codv group by v.marca
	order by quantidade_consertos desc;


drop index idx_conserto_codv
create index idx_conserto_codv on conserto using hash(codv);

drop index idx_veiculo_marca
create index idx_veiculo_marca on veiculo using hash(marca);

-- Conslusão: ganhos infimos para varios testes

--------------------------------------------------------------------------------
-- 10)   Recupere o modelo, a marca e o ano dos veículos que têm quilometragem maior que a média de quilometragem de todos os veículos.

explain analyse select modelo, marca, ano from veiculo where quilometragem > (select avg(quilometragem) from veiculo);

drop index idx_veiculo_km
create index idx_veiculo_km on veiculo using hash(quilometragem);

--------------------------------------------------------------------------------
-- 11)   Recupere o nome dos mecânicos que têm mais de um conserto marcado para o mesmo dia.

explain analyse select distinct m.nome
from mecanico m join conserto co on m.codm = co.codm group by m.nome, co.data having count(*) > 1;


drop index idx_conserto_codm
create index idx_conserto_codm on conserto using hash(codm);

drop index idx_conserto_data
create index idx_conserto_data on conserto using hash(data);

--------------------------------------------------------------------------------
-- 12) retorne os nomes distintos dos mecanicos que tem consertos agendados
explain analyse select m.nome
from mecanico m join conserto co on m.codm = co.codm;


explain analyse select m.nome
from mecanico m where exists (select 1 from conserto co where co.codm = m.codm);

drop index idx_conserto_codm
create index idx_conserto_codm on conserto using hash(codm);
