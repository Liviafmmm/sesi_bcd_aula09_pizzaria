-- A Quantas tabelas o banco de dados possui?
SHOW TABLES;

SELECT COUNT(*) AS total_tabelas
FROM information_schema.tables
WHERE table_schema = 'Pizzaria';

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
