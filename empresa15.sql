USE DATABASE empresa15;

CREATE TABLE empregados (
	cpf bigint,
	enome varchar(60),
	salario float,
	cpf_supervisor bigint,
	dnumero integer,
	PRIMARY KEY (cpf)
);
CREATE TABLE departamentos(
	dnumero integer,
	dnome varchar(60),
	cpf_gerente bigint,
	PRIMARY KEY (dnumero),
	CONSTRAINT fk_cpf FOREIGN KEY(cpf_gerente) REFERENCES empregados(cpf)
);
CREATE TABLE trabalha(
	cpf_emp bigint,
	pnumero integer,
	horas integer,
	CONSTRAINT fk_cpfemp FOREIGN KEY(cpf_emp) REFERENCES empregados(cpf)
);
CREATE TABLE projetos(
	pnumero integer,
	pnome varchar(45),
	dnumero integer,
	PRIMARY KEY(pnumero),
	CONSTRAINT fk_dnum FOREIGN KEY(dnumero) REFERENCES departamentos(dnumero)
);
Insert Into empregados

values (049382234322,'João Silva', 2350, 2434332222, 1010);

Insert Into empregados(cpf, enome, salario, cpf_supervisor, dnumero)

values (586733922290,'Mario Silveira', 3500, 2434332222, 1010);

Insert Into empregados

values (2434332222,'Aline Barros', 2350, NULL, 1010);

Insert Into departamentos (dnumero, dnome, cpf_gerente)

values (1010, 'Pesquisa', 049382234322);

Insert Into departamentos

values (1020, 'Ensino', 2434332222);

Insert Into trabalha (cpf_emp, pnumero,horas)

values (049382234322, 2010, 10);

Insert Into trabalha (cpf_emp, pnumero,horas)

values (586733922290, 2020,30);

Insert Into trabalha (cpf_emp, pnumero, horas)

values (049382234322, 2020, 10);

Insert Into projetos (pnumero, pnome, dnumero)

values (2010,'Alpha', 1010);

Insert Into projetos (pnumero, pnome, dnumero)

values (2020,'Beta', 1020);

ALTER TABLE empregados ADD CONSTRAINT fk_dnum FOREIGN KEY(dnumero)

REFERENCES departamentos(dnumero);

ALTER TABLE trabalha ADD CONSTRAINT fk_pnum FOREIGN KEY(pnumero)

REFERENCES projetos(pnumero);


/*Questao 1*/
SELECT * FROM empregados e, departamentos d 
WHERE e.dnumero = d.dnumero AND d.dnome like 'Pesquisa' AND e.salario > 2000;

/*Questao 2*/
SELECT e1.nome FROM empregados e1, empregados e2
WHERE e1.cpf = e2.cpf_supervisor AND e2.salario > 2000;

/*Questao 3*/
SELECT e2.enome,e2.salario FROM empregados e1, empregados e2
WHERE e1.cpf = e2.cpf_supervisor AND e2.salario > e1.salario;

/*Questao 4*/
SELECT e.enome FROM empregados e, departamentos d, projetos p
WHERE p.dnumero = d.dnumero AND d.cpf_gerente = e.cpf;

/*Questao 5*/
SELECT p.pnome FROM projetos p
WHERE p.pnumero IN(SELECT pnumero FROM empregados e, trabalha t
		           WHERE t.cpf_emp = e.cpf AND e.enome = 'João Silva')
OR p.pnumero IN(SELECT pnumero FROM empregados e, projetos p, departamentos d
                   WHERE p.dnumero = d.dnumero AND d.cpf_gerente = e.cpf AND e.enome = 'João Silva');
/*Questao 6*/
SELECT e.cpf FROM empregados e
WHERE NOT EXISTS (SELECT e.cpf FROM trabalha t
		          WHERE t.cpf_emp = e.cpf);