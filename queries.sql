USE pizzaria;

-- A Quantas tabelas o banco de dados possui?
SHOW TABLES;

SELECT COUNT(*) AS total_tabelas
FROM information_schema.tables
WHERE table_schema = 'pizzaria';

-- B Quantos clientes cadastrados?
SELECT COUNT(*) AS total_clientes
FROM Clientes;

-- C Quantas pizzas cadastradas?
SELECT COUNT(*) AS total_pizzas
FROM Pizzas;

-- D Quantas pizzas o pedido nº 3 possui?
SELECT SUM(quantidade) AS total_pizzas
FROM Itens_Pedido
WHERE pedido_id = 3;

-- E Qual nome do cliente que fez o pedido nº 3?
SELECT c.nome
FROM Clientes c
INNER JOIN Pedidos p
    ON c.cliente_id = p.cliente_id
WHERE p.pedido_id = 3;

-- F Quais os nomes das pizzas do pedido nº 3?
SELECT p.nome AS nome_pizza, ip.quantidade
FROM Itens_Pedido ip
INNER JOIN Pizzas p
    ON ip.pizza_id = p.pizza_id
WHERE ip.pedido_id = 3;

-- Acrescentando cliente
INSERT INTO Clientes (nome, logradouro, numero, bairro, referencia)
VALUES (
    'Gaspar Oliveira',
    'Rua Lizandro Silva',
    21,
    'São Dimas',
    'Ao lado da igrejinha'
);

-- Cadastrando o pedido do cliente
INSERT INTO Pedidos (cliente_id, data, hora)
VALUES (
    (SELECT cliente_id FROM Clientes WHERE nome = 'Gaspar Oliveira' ORDER BY cliente_id DESC LIMIT 1),
    CURDATE(),
    CURTIME()
);

-- Cadastrando as pizzas no pedido
INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
VALUES
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome = 'Margherita'),
    1,
    (SELECT valor FROM Pizzas WHERE nome = 'Margherita')
),
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome = 'Napolitana'),
    2,
    (SELECT valor FROM Pizzas WHERE nome = 'Napolitana')
);

-- Cadastrando pizza A moda do chef
INSERT INTO Pizzas (nome, descricao, valor)
VALUES (
    'A moda do chef',
    'Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas',
    41.90
);

-- Cadastrar novo pedido para Gaspar
INSERT INTO Pedidos (cliente_id, data, hora)
SELECT cliente_id, CURDATE(), CURTIME()
FROM Clientes
WHERE nome = 'Gaspar Oliveira'
ORDER BY cliente_id DESC
LIMIT 1;

-- Inserir 2 pizzas A moda do chef no pedido
INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
SELECT
    (SELECT MAX(pedido_id) FROM Pedidos),
    pizza_id,
    2,
    valor
FROM Pizzas
WHERE nome = 'A moda do chef';

-- Inserir mais 3 pizzas A moda do chef no mesmo pedido
INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
SELECT
    (SELECT MAX(pedido_id) FROM Pedidos),
    pizza_id,
    3,
    valor
FROM Pizzas
WHERE nome = 'A moda do chef';

-- Atualizar valor total do pedido
UPDATE Pedidos
SET valor = (
    SELECT SUM(quantidade * valor)
    FROM Itens_Pedido
    WHERE pedido_id = (SELECT MAX(pedido_id) FROM Pedidos)
)
WHERE pedido_id = (SELECT MAX(pedido_id) FROM Pedidos);

-- Conferir o pedido
SELECT * FROM Pedidos
WHERE pedido_id = (SELECT MAX(pedido_id) FROM Pedidos);

SELECT * FROM Itens_Pedido
WHERE pedido_id = (SELECT MAX(pedido_id) FROM Pedidos);
