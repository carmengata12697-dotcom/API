-- tabla de clientes
CREATE TABLE IR NOT EXISTS clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(120) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    activo BOOLEAN DEFAULT 1,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_ultima_compra DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- índices para CLIENTES
CREATE INDEX IF NOT EXISTS idx_clientes_email ON clientes (email);
CREATE INDEX IF NOT EXISTS idx_clientes_pais ON clientes (pais);
CREATE INDEX IF NOT EXISTS idx_clientes_activo ON clientes (activo);

-- tabla de transacciones
CREATE TABLE IF NOT EXISTS transacciones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    moneda VARCHAR(3) DEFAULT 'USD',
    tipo_transaccion VARCHAR(20) NOT NULL, --pagado, reembolso, pendiente,transferencia
    estado VARCHAR(20) NOT NULL, --completada, fallida, pendiente, cancelada
    descripcion VARCHAR(255),
    referencia_externa VARCHAR(100),
    feccha_transaccion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_completada DATETIME,
   metadara TEXT, --JSON con información adicional 
   
   creada_en DATETIME DEFAULT CURRENT_TIMESTAMP,
   actualizada_en DATETIME DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- indices para TRANSACCIONES
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_id ON transacciones (cliente_id);
CREATE INDEX IF NOT EXISTS idx_transacciones_tipo_estado ON transacciones (tipo_transaccion, estado);
CREATE INDEX IF NOT EXISTS idx_transacciones_fecha ON transacciones (feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_referencia ON transacciones (referencia_externa);
CREATE INDEX IF NOT EXISTS idx_transacciones_tipo ON transacciones (tipo_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_estado ON transacciones (estado);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_tipo ON transacciones (cliente_id, tipo_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_estado ON transacciones (cliente_id, estado);
CREATE INDEX IF NOT EXISTS  idx_transacciones_cliente_fecha ON transacciones (cliente_id, feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_tipo_fecha ON transacciones (tipo_transaccion, feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_estado_fecha ON transacciones (estado, feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_tipo_estado ON transacciones (cliente_id, tipo_transaccion, estado);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_tipo_fecha ON transacciones (cliente_id, tipo_transaccion, feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_estado_fecha ON transacciones (cliente_id, estado, feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_tipo_estado_fecha ON transacciones (tipo_transaccion, estado, feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_tipo_estado_fecha ON transacciones (cliente_id, tipo_transaccion, estado, feccha_transaccion);
CREATE INDEX IF NOT EXISTS idx_transacciones_descripcion ON transacciones (descripcion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_descripcion ON transacciones (cliente_id, descripcion);
CREATE INDEX IF NOT EXISTS idx_transacciones_estado_descripcion ON transacciones (estado, descripcion);
CREATE INDEX IF NOT EXISTS idx_transacciones_tipo_descripcion ON transacciones (tipo_transaccion, descripcion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_tipo_descripcion ON transacciones (cliente_id, tipo_transaccion, descripcion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_estado_descripcion ON transacciones (cliente_id, estado, descripcion);
CREATE INDEX IF NOT EXISTS idx_transacciones_tipo_estado_descripcion ON transacciones (tipo_transaccion, estado, descripcion);
CREATE INDEX IF NOT EXISTS idx_transacciones_cliente_tipo_estado_descripcion ON transacciones (cliente_id, tipo_transaccion, estado, descripcion);      

-- tabla de auditoría logs
CREATE TABLE IF NOT EXISTS auditoria (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    accion VARCHAR(50) NOT NULL, --login, compra, actualización de perfil, etc.
    descripcion VARCHAR(255),
    fecha_accion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- índices para auditoria logs
CREATE INDEX IF NOT EXISTS idx_auditoria_cliente_id ON auditoria (cliente_id);
CREATE INDEX IF NOT EXISTS idx_auditoria_fecha ON auditoria (fecha_accion); 
CREATE INDEX IF NOT EXISTS idx_auditoria_accion ON auditoria (accion);
CREATE INDEX IF NOT EXISTS idx_auditoria_cliente_accion ON auditoria (cliente_id, accion);
CREATE INDEX IF NOT EXISTS idx_auditoria_cliente_fecha ON auditoria (cliente_id, fecha_accion);
CREATE INDEX IF NOT EXISTS idx_auditoria_accion_fecha ON auditoria (accion, fecha_accion);
CREATE INDEX IF NOT EXISTS idx_auditoria_cliente_accion_fecha ON auditoria (cliente_id, accion, fecha_accion);
CREATE INDEX IF NOT EXISTS idx_auditoria_descripcion ON auditoria (descripcion);
CREATE INDEX IF NOT EXISTS idx_auditoria_cliente_descripcion ON auditoria (cliente_id, descripcion);
CREATE INDEX IF NOT EXISTS idx_auditoria_accion_descripcion ON auditoria (accion, descripcion);
CREATE INDEX IF NOT EXISTS idx_auditoria_cliente_accion_descripcion ON auditoria (cliente_id, accion, descripcion);
CREATE INDEX IF NOT EXISTS idx_auditoria_fecha_descripcion ON auditoria (fecha_accion, descripcion);
CREATE INDEX IF NOT EXISTS idx_auditoria_cliente_fecha_descripcion ON auditoria (cliente_id, fecha_accion, descripcion);

-- tabla de acciones
CREATE TABLE IF NOT EXISTS acciones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL, --login, compra, actualización de perfil, etc.
    descripcion VARCHAR(255)
);

-- índices para acciones
CREATE INDEX IF NOT EXISTS idx_acciones_nombre ON acciones (nombre);
CREATE INDEX IF NOT EXISTS idx_acciones_descripcion ON acciones (descripcion);
CREATE INDEX IF NOT EXISTS idx_acciones_nombre_descripcion ON acciones (nombre, descripcion);
CREATE INDEX IF NOT EXISTS idx_acciones_descripcion_nombre ON acciones (descripcion, nombre);
CREATE INDEX IF NOT EXISTS idx_acciones_nombre_descripcion ON acciones (nombre, descripcion);

-- tabla de portafolios de inversión por cliente
CREATE TABLE IF NOT EXISTS portafolios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    nombre_portafolio VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- índices para portafolios de inversión por cliente
CREATE INDEX IF NOT EXISTS idx_portafolios_cliente_id ON portafolios (cliente_id);
CREATE INDEX IF NOT EXISTS idx_portafolios_nombre ON portafolios (nombre_portafolio);
CREATE INDEX IF NOT EXISTS idx_portafolios_fecha_creacion ON portafolios (fecha_creacion);
CREATE INDEX IF NOT EXISTS idx_portafolios_fecha_actualizacion ON portafolios (fecha_actualizacion);
CREATE INDEX IF NOT EXISTS idx_portafolios_cliente_nombre ON portafolios (cliente_id, nombre_portafolio);
CREATE INDEX IF NOT EXISTS idx_portafolios_cliente_fecha_creacion ON portafolios (cliente_id, fecha_creacion);
CREATE INDEX IF NOT EXISTS idx_portafolios_cliente_fecha_actualizacion ON portafolios (cliente_id, fecha_actualizacion);    
CREATE INDEX IF NOT EXISTS idx_portafolios_nombre_fecha_creacion ON portafolios (nombre_portafolio, fecha_creacion);
CREATE INDEX IF NOT EXISTS idx_portafolios_nombre_fecha_actualizacion ON portafolios (nombre_portafolio, fecha_actualizacion);
CREATE INDEX IF NOT EXISTS idx_portafolios_fecha_creacion_actualizacion ON portafolios (fecha_creacion, fecha_actualizacion);
