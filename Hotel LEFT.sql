-- Banco do hotel
CREATE DATABASE hotel_left;
USE hotel_left;
 
-- Quartos do hotel
CREATE TABLE quarto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(5) NOT NULL UNIQUE,
  tipo VARCHAR(15) NOT NULL,
  diaria DECIMAL(7,2) NOT NULL
);
 
-- Reservas: quarto_id aponta para quarto(id)
CREATE TABLE reserva (
  id INT AUTO_INCREMENT PRIMARY KEY,
  hospede VARCHAR(60) NOT NULL,
  data_entrada DATE NOT NULL,
  noites INT NOT NULL,
  quarto_id INT NOT NULL,
  FOREIGN KEY (quarto_id) REFERENCES quarto(id)
);
 
INSERT INTO quarto (numero, tipo, diaria) VALUES
  ('101', 'Standard', 180.00),
  ('102', 'Standard', 180.00),
  ('201', 'Luxo', 320.00),
  ('202', 'Luxo', 320.00),
  ('301', 'Suíte', 550.00),
  ('302', 'Suíte', 550.00);
 
INSERT INTO reserva (hospede, data_entrada, noites, quarto_id) VALUES
  ('Carlos Souza', '2026-11-10', 2, 1),
  ('Beatriz Lima', '2026-11-12', 3, 1),
  ('Pedro Alves', '2026-11-10', 1, 3),
  ('Larissa Melo', '2026-11-14', 2, 3),
  ('Marcos Dias', '2026-11-11', 4, 3),
  ('Fernanda Rocha', '2026-11-13', 2, 5),
  ('João Pereira', '2026-11-15', 5, 5),
  ('Sofia Nunes', '2026-11-12', 1, 1);
  
  -- Mostre todos os quartos com os seus reservas, incluindo quem não tem nenhum. Comece o FROM pela tabela quarto. Quantas linhas saíram? (LEFT JOIN)
  SELECT quarto.numero, reserva.hospede
  FROM quarto
  LEFT JOIN reserva
  ON reserva.quarto_id = quarto.id;

-- Quais quartos não têm nenhuma reserva? (LEFT JOIN e IS NULL)
SELECT quarto.numero
FROM quarto
LEFT JOIN reserva
ON reserva.quarto_id = quarto.id
WHERE reserva.id IS NULL;

SELECT quarto.numero
FROM quarto
LEFT JOIN reserva
ON reserva.quarto_id = quarto.id
WHERE reserva.id IS NOT NULL;

-- Quantas reservas cada quarto tem, incluindo quem tem zero? (COUNT de uma coluna e GROUP BY)
SELECT quarto.numero, COUNT(reserva.id) 
FROM quarto
LEFT JOIN reserva
ON reserva.quarto_id = quarto.id
GROUP BY quarto.numero;