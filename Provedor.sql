-- Banco do provedor de internet
CREATE DATABASE provedor_left;
USE provedor_left;
 
-- Planos oferecidos
CREATE TABLE plano (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(30) NOT NULL UNIQUE,
  velocidade_mbps INT NOT NULL,
  mensalidade DECIMAL(6,2) NOT NULL
);
 
-- Assinantes: plano_id aponta para plano(id)
CREATE TABLE assinante (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  bairro VARCHAR(40) NOT NULL,
  data_instalacao DATE NOT NULL,
  plano_id INT NOT NULL,
  FOREIGN KEY (plano_id) REFERENCES plano(id)
);
 
INSERT INTO plano (nome, velocidade_mbps, mensalidade) VALUES
  ('Básico', 100, 79.90),
  ('Família', 300, 99.90),
  ('Gamer', 600, 129.90),
  ('Empresarial', 1000, 249.90),
  ('Fibra Rural', 50, 89.90);
 
INSERT INTO assinante (nome, bairro, data_instalacao, plano_id) VALUES
  ('Rita Gomes', 'Centro', '2026-01-15', 2),
  ('Caio Martins', 'Vila Nova', '2026-02-03', 3),
  ('Juliana Reis', 'Centro', '2026-03-20', 1),
  ('Diego Prado', 'Jardim América', '2026-04-08', 3),
  ('Helena Costa', 'Vila Nova', '2026-05-12', 2),
  ('Otávio Lima', 'Centro', '2026-06-30', 2),
  ('Paula Antunes', 'Jardim América', '2026-08-05', 4),
  ('Igor Teixeira', 'Centro', '2026-09-18', 3);

-- Mostre todos os planos com os seus assinantes, incluindo quem não tem nenhum. Comece o FROM pela tabela plano. Quantas linhas saíram? (LEFT JOIN)
SELECT plano.nome, assinante.nome
FROM plano
LEFT JOIN assinante
ON assinante.plano_id = plano.id;

-- Rode a mesma consulta trocando LEFT JOIN por INNER JOIN. Quantas linhas saíram agora? Quem sumiu, e por quê?
SELECT plano.nome, assinante.nome
FROM plano
INNER JOIN assinante
ON assinante.plano_id = plano.id;

-- Quais planos não têm nenhum assinante? (LEFT JOIN e IS NULL)
SELECT plano.nome
FROM plano
LEFT JOIN assinante
ON assinante.plano_id = plano.id
WHERE plano_id IS NULL;

-- Quantos assinantes cada plano tem, incluindo quem tem zero? (COUNT de uma coluna e GROUP BY)
SELECT plano.nome, COUNT(assinante.id) 
FROM plano
LEFT JOIN assinante
ON assinante.plano_id = plano.id
GROUP BY plano.nome;

-- Mostre os planos com mensalidade abaixo de 100 reais com os seus assinantes, incluindo plano sem assinante. (WHERE na tabela da esquerda)
SELECT plano.mensalidade, assinante.nome
FROM plano
LEFT JOIN assinante
ON plano.mensalidade_id = plano.id
