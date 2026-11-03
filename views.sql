USE Pizzaria;

-- View 1: pedidos com o nome do cliente
DROP VIEW IF EXISTS vw_pedidos1;

CREATE VIEW vw_pedidos1 AS
SELECT
    p.pedido_id,
    p.cliente_id,
    c.nome AS cliente,
    p.data,
    p.hora,
    p.valor
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.cliente_id;

-- Consultar a primeira view
SELECT * FROM vw_pedidos1;


-- View 2: detalhes dos pedidos, clientes e pizzas
DROP VIEW IF EXISTS vw_pedidos_itens;

CREATE VIEW vw_pedidos_itens AS
SELECT
    p.pedido_id,
    c.nome AS cliente,
    pi.nome AS pizza,
    ip.quantidade,
    ip.valor AS valor_unitario,
    ip.quantidade * ip.valor AS subtotal
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.cliente_id
INNER JOIN Itens_Pedido ip ON p.pedido_id = ip.pedido_id
INNER JOIN Pizzas pi ON ip.pizza_id = pi.pizza_id;

-- Consultar os detalhes dos pedidos
SELECT * FROM vw_pedidos_itens;


-- View 3: valor total de cada pedido
DROP VIEW IF EXISTS vw_total_pedidos;

CREATE VIEW vw_total_pedidos AS
SELECT
    p.pedido_id,
    c.nome AS cliente,
    SUM(ip.quantidade * ip.valor) AS valor_total
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.cliente_id
INNER JOIN Itens_Pedido ip ON p.pedido_id = ip.pedido_id
GROUP BY p.pedido_id, c.nome;

-- Consultar o total de cada pedido
SELECT * FROM vw_total_pedidos;


-- View 4: quantidade de pizzas por pedido
DROP VIEW IF EXISTS vw_quantidade_pizzas;

CREATE VIEW vw_quantidade_pizzas AS
SELECT
    p.pedido_id,
    c.nome AS cliente,
    SUM(ip.quantidade) AS total_pizzas
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.cliente_id
INNER JOIN Itens_Pedido ip ON p.pedido_id = ip.pedido_id
GROUP BY p.pedido_id, c.nome;

-- Consultar a quantidade de pizzas por pedido
SELECT * FROM vw_quantidade_pizzas;


