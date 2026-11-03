USE Pizzaria;

-- Consultar todos os clientes
SELECT * FROM Clientes;

-- Ver a estrutura da tabela
DESCRIBE Clientes;

-- Buscar um cliente pelo nome completo
SELECT *
FROM Clientes
WHERE nome = 'Adelcio Biazi';

-- Buscar pelo nome exato usando LIKE
SELECT *
FROM Clientes
WHERE nome LIKE 'Adelcio';

-- Buscar nomes que contenham Ana
SELECT *
FROM Clientes
WHERE nome LIKE '%Ana%';

-- Buscar nomes que começam com Ana
SELECT *
FROM Clientes
WHERE nome LIKE 'Ana%';

-- Remover o índice caso ele já exista
DROP INDEX IF EXISTS i_nome ON Clientes;

-- Criar um índice para a coluna nome
CREATE INDEX i_nome ON Clientes(nome);

-- Conferir os índices da tabela
SHOW INDEX FROM Clientes;

-- Consultar novamente a estrutura
DESCRIBE Clientes;

-- Testar a busca depois da criação do índice
SELECT *
FROM Clientes
WHERE nome LIKE 'Ana%';