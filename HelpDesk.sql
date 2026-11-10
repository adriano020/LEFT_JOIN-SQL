-- Banco da central de suporte
CREATE DATABASE suporte_join;
USE suporte_join;
 
-- Técnicos da equipe
CREATE TABLE tecnico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  nivel VARCHAR(5) NOT NULL
);
 
-- Chamados: tecnico_id aponta para tecnico(id)
CREATE TABLE chamado (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(80) NOT NULL,
  prioridade VARCHAR(10) NOT NULL,
  status VARCHAR(15) NOT NULL,
  data_abertura DATE NOT NULL,
  tecnico_id INT NOT NULL,
  FOREIGN KEY (tecnico_id) REFERENCES tecnico(id)
);
 
INSERT INTO tecnico (nome, email, nivel) VALUES
  ('Renata Silva', 'renata.silva@empresa.com.br', 'N1'),
  ('Paulo Gomes', 'paulo.gomes@empresa.com.br', 'N2'),
  ('Aline Torres', 'aline.torres@empresa.com.br', 'N3'),
  ('Marcos Vieira', 'marcos.vieira@empresa.com.br', 'N1');
 
INSERT INTO chamado (titulo, prioridade, status, data_abertura, tecnico_id) VALUES
  ('Impressora não imprime', 'Baixa', 'Resolvido', '2026-10-20', 1),
  ('Sem acesso ao e-mail', 'Média', 'Resolvido', '2026-10-21', 1),
  ('Servidor de arquivos lento', 'Alta', 'Em andamento', '2026-10-22', 2),
  ('VPN não conecta', 'Alta', 'Aberto', '2026-10-23', 2),
  ('Suspeita de phishing', 'Crítica', 'Em andamento', '2026-10-24', 3),
  ('Troca de senha', 'Baixa', 'Resolvido', '2026-10-25', 1),
  ('Backup falhou', 'Crítica', 'Aberto', '2026-10-26', 3),
  ('Instalar software', 'Média', 'Aberto', '2026-10-27', 2);
  
  SELECT * FROM tecnico;
  
  -- Mostre o título de cada chamado e o nome do técnico responsável.
 SELECT chamado.titulo AS chamado_titulo, tecnico.nome AS tecnico_nome
 FROM chamado 
 JOIN tecnico ON chamado.tecnico_id = tecnico.id;
 
 -- Quais chamados estão com a Aline Torres? Mostre título e prioridade.
 SELECT chamado.titulo, chamado.prioridade
 FROM chamado 
 JOIN tecnico ON chamado.tecnico_id = tecnico.id
 WHERE tecnico.nome = 'Aline Torres';
 
 -- Mostre os chamados Abertos que estão com técnicos de nível N2. (WHERE com AND)
 SELECT chamado.titulo, chamado.status, chamado.prioridade, tecnico.nome AS tecnico_nome, tecnico.nivel
 FROM chamado 
 JOIN tecnico ON chamado.tecnico_id = tecnico.id
 WHERE chamado.status = 'Aberto' 
 AND tecnico.nivel = 'N2';
 
 -- Mostre chamado, técnico e data dos 3 chamados mais recentes. (ORDER BY e LIMIT)
SELECT chamado.titulo AS chamado, tecnico.nome AS tecnico, chamado.data_abertura AS data
FROM chamado 
JOIN tecnico ON chamado.tecnico_id = tecnico.id
ORDER BY chamado.data_abertura DESC
LIMIT 3;

-- Quantos chamados os técnicos de nível N1 já resolveram? (COUNT)SELECT 
COUNT(chamado.id) AS total_resolvidos_n1
FROM chamado 
JOIN tecnico ON chamado.tecnico_id = tecnico.id
WHERE chamado.status = 'Resolvido' 
AND tecnico.nivel = 'N1';

SELECT DISTINCT tecnico.nome 
FROM tecnico 
LEFT JOIN chamado  ON tecnico.id = chamado.tecnico_id;

