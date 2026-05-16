-- insertar clientes de ejemplo
INSERT INTO clientes ( correo_electronico, nombre, apellido, pais, telefono) VALUES
('m.sasa@email.com', 'Maria', 'Sasa', 'Argentina', '123456789'),
('j.doe@email.com', 'John', 'Doe', 'USA', '987654321'),
('ele.dash@email.com', 'Ele', 'Dash', 'UK', '555555555'),

--insertar transacciones de ejemplo
-- transacciones para cliente 1
INSERT INTO transacciones ( cliente_id, monto, moneda, tipo, estado, descripcion, referencia_externa, metadara, fecha) VALUES
(1, 100.00, 'USD', 'compra', 'completada', 'Compra de producto A', 'REF12345', '{"detalles": "Producto A, cantidad 1"}', current_timestamp),
(1, 50.00, 'USD', 'compra', 'pendiente', 'Compra de producto B', 'REF12346', '{"detalles": "Producto B, cantidad 2"}', current_timestamp),
(1, 20.00, 'USD', 'reembolso', 'completada', 'Reembolso por producto A', 'REF12347', '{"detalles": "Producto A, cantidad 1"}', current_timestamp),

-- transacciones para cliente 2
(2, 200.00, 'USD', 'compra', 'completada', 'Compra de producto C', 'REF12348', '{"detalles": "Producto C, cantidad 1"}', current_timestamp),
(2, 80.00, 'USD', 'compra', 'pendiente', 'Compra de producto D', 'REF12349', '{"detalles": "Producto D, cantidad 4"}', current_timestamp),
(2, 30.00, 'USD', 'reembolso', 'completada', 'Reembolso por producto D', 'REF12350', '{"detalles": "Producto D, cantidad 2"}', current_timestamp),

-- transacciones para cliente 3
(3, 150.00, 'USD', 'compra', 'completada', 'Compra de producto E', 'REF12351', '{"detalles": "Producto E, cantidad 1"}', current_timestamp),
(3, 60.00, 'USD', 'compra', 'pendiente', 'Compra de producto F', 'REF12352', '{"detalles": "Producto F, cantidad 3"}', current_timestamp),
(3, 25.00, 'USD', 'reembolso', 'completada', 'Reembolso por producto F', 'REF12353', '{"detalles": "Producto F, cantidad 1"}', current_timestamp);


-- insertar registros de ejemplo en la tabla de auditoría
INSERT INTO auditoria ( cliente_id, accion, usuario, ip_address, timestamp) VALUES
(1, 'Inicio de sesión', 'm.sasa', '127.0.0.1', datatime('now')),
(1, 'Actualización de perfil', 'admin', '127.0.0.3', datatime('now', '-2 hours')),
(2, 'desactivación de cuenta', 'j.doe', '127.0.02', datatime('now', '-1 day'));
