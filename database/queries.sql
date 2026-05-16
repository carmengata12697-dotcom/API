-- total de transacciones por cliente

SELECT
    c.nombre,
    c.email,
    COUNT(t.id) AS total_transacciones
    SUM(t.monto) AS total_monto,
    AVG(t.monto) AS promedio_monto
FROM clientes c
LEFT JOIN transacciones t ON c.id = t.cliente_id
GROUP BY c.id
ORDER BY total_monto DESC;

--transacciones en el último mes
select
    c.id,
    t.fecha,
    t.nombre,
    t.monto,
    t.moneda,
    t.tipo,
    t.estado,
FROM transacciones t
JOIN clientes c ON t.cliente_id = c.id
WHERE t.fecha >= date('now', '-30 days')
ORDER BY t.fecha DESC;

-- transacciones por estado
SELECT
    estado,
    COUNT(*) AS total_transacciones,
    SUM(monto) AS total_monto
FROM transacciones
GROUP BY estado.id;


-- resumen diario de transacciones
SELECT
    date(fecha) AS fecha,
    COUNT(*) AS total_transacciones,
    SUM(monto) AS total_monto
FROM transacciones
GROUP BY date(fecha)
ORDER BY fecha DESC;


--clientes con más transacciones
SELECT
    c.nombre,
    c.email,
    COUNT(t.id) AS total_transacciones
FROM clientes c
LEFT JOIN transacciones t ON c.id = t.cliente_id
GROUP BY c.id
ORDER BY total_transacciones DESC;