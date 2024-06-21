INSERT INTO paises (pais_id, nombre)
VALUES ('PA001', 'Colombia');


INSERT INTO ciudades (ciudad_id, nombre, pais_id)
VALUES ('CI001','Bucaramanga','PA001');


INSERT INTO direccion_sucursales (calle, carrera, descripcion, ciudad_id)
VALUES ('Calle 34', 'Carrera 2', 'Avinida 2 Barrio Palomitas', 'CI001');
SET @direccion_idsur = LAST_INSERT_ID();

INSERT INTO sucursales (nombre, direccion_id)
VALUES ('Envia BGA', @direccion_idsur);


INSERT INTO direccion_cliente (calle, carrera, descripcion, ciudad_id)
VALUES ('Calle 12', 'Carrera 40', 'Conjuntto Miraflores', 'CI001');
SET @direccion_idcli = LAST_INSERT_ID();

INSERT INTO clientes (nombre, email, direccion_id)
VALUES ('John Dee', 'johndee@gmail.com', @direccion_idcli);


SET @cliente_id = LAST_INSERT_ID();

INSERT INTO telefonos_clientes(numero, cliente_id)
VALUES ('3124198288', @cliente_id);


INSERT INTO estado_paquete (nombre)
VALUES ('Bodega'), ('Proceso de Envio'), ('Enviado'), ('Entregado');

INSERT INTO tipo_servicio (nombre)
VALUES ('Paqueteria'), ('Mensajeria'), ('Almacenamiento');

INSERT INTO dimensiones (ancho, largo)
VALUES (10.00, 20.00);
SET @dimension_id = LAST_INSERT_ID();

INSERT INTO paquetes (peso, dimension_id, contenido, valor_declarado, servicio_id, estado_id)
VALUES (5.50, @dimension_id, 'Equipos electronicos delicados', 100.00, 1, 1);


SET @paquete_id = LAST_INSERT_ID();

INSERT INTO direccion_destinatario (calle, carrera, descripcion, ciudad_id)
VALUES ('Calle 34', 'Carrera 2', 'Barrio Molinos', 'CI001');
SET @direccion_iddes = LAST_INSERT_ID();

INSERT INTO destinatarios (nombre, email, direccion_id)
VALUES ('Alejandro Basto', 'alejandrobasto@gmail.com', @direccion_iddes);
SET @destinatario_id = LAST_INSERT_ID();

INSERT INTO rutas (descripcion, sucursal_id)
VALUES ('Area Metropolitana', 1);
SET @ruta_id = LAST_INSERT_ID();

INSERT INTO envios (cliente_id, paquete_id, fecha_envio, hora_envio, destinatario_id, ruta_id, sucursal_id)
VALUES (@cliente_id, @paquete_id, '2024-06-21', '12:00:00', @destinatario_id, @ruta_id, 1); 


INSERT INTO marcas (nombre)
VALUES ('Mercedez');

SET @marca_id = LAST_INSERT_ID();

INSERT INTO modelos (nombre, marca_id)
VALUES ('MG002', @marca_id);

SET @modelo_id = LAST_INSERT_ID();

INSERT INTO vehiculos (placa, modelo_id, capacidad_carga, sucursal_id)
VALUES ('ABC123', @modelo_id, 1000.00, @sucursal_id);
SET @vehiculo_id = LAST_INSERT_ID();


INSERT INTO conductores (nombre)
VALUES ('Jose Heredia');
SET @conductor_id = LAST_INSERT_ID();


INSERT INTO telefonos_conductores (numero, conductor_id)
VALUES ('3124198581', @conductor_id);


INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id, sucursal_id)
VALUES (@conductor_id, @ruta_id, @vehiculo_id, 1);


INSERT INTO auxiliares (nombre)
VALUES ('Maria Alejandra');
SET @auxiliar_id = LAST_INSERT_ID();


INSERT INTO ruta_axiliares (ruta_id, auxiliar_id)
VALUES (@ruta_id, @auxiliar_id);


INSERT INTO ubicacion_seguimiento (calle, carrera, descripcion, ciudad_id)
VALUES ('No Aplica', 'No Aplica', 'Via BGA', 'CI001');
SET @ubicacion_idseg = LAST_INSERT_ID();

INSERT INTO estado_seguimiento (nombre)
VALUES ('Preparacion'), ('Encamino'), ('Entregado');

INSERT INTO seguimiento (seguimiento_id, paquete_id, ubicacion_id, fecha_hora, estado_id)
VALUES ('SEGU123', @paquete_id, @ubicacion_idseg, '12:00:00', 1);


SELECT 
    e.envio_id AS envio_id,
    e.cliente_id AS cliente_id,
    e.paquete_id AS paquete_id,
    e.fecha_envio AS fecha_envio,
    e.hora_envio AS hora_envio,
    e.destinatario_id AS destinatario_id,
    e.ruta_id AS ruta_id,
    e.sucursal_id AS sucursal_id,
    c.nombre AS cliente_nombre,
    c.email AS cliente_email,
    p.peso AS paquete_peso,
    p.contenido AS paquete_contenido,
    p.valor_declarado AS paquete_valor_declarado,
    d.nombre AS destinatario_nombre,
    d.email AS destinatario_email,
    r.descripcion AS ruta_descripcion,
    s.nombre AS sucursal_nombre
FROM envios e
JOIN clientes c ON e.cliente_id = c.cliente_id
JOIN paquetes p ON e.paquete_id = p.paquete_id
JOIN destinatarios d ON e.destinatario_id = d.destinatario_id
JOIN rutas r ON e.ruta_id = r.ruta_id
JOIN sucursales s ON e.sucursal_id = s.sucursal_id
WHERE e.cliente_id = 1;


SET @nuevo_estado_id = 2;

UPDATE paquetes
SET estado_id = @nuevo_estado_id
WHERE paquete_id = @paquete_id;


SELECT 
    u.calle AS ubicacion_calle,
    u.carrera AS ubicacion_carrera,
    u.descripcion AS descripcion_ubicacion,
    c.nombre AS ciudad_nombre
FROM seguimiento s
JOIN ubicacion_seguimiento u ON s.ubicacion_id = u.ubicacion_idseg
JOIN ciudades c ON u.ciudad_id = c.ciudad_id
WHERE s.paquete_id = 1 
ORDER BY s.fecha_hora DESC;


SELECT 
    e.envio_id AS id_envio,
    e.cliente_id AS id_cliente,
    e.paquete_id AS id_paquete,
    e.fecha_envio AS fecha,
    e.hora_envio AS hora,
    e.destinatario_id AS id_destinatario,
    e.ruta_id AS id_ruta,
    e.sucursal_id AS id_sucursal
FROM envios e;


SELECT 
    c.nombre AS nombre_cliente,
    e.envio_id AS id_envio,
    e.paquete_id AS id_paquete,
    e.fecha_envio AS fecha,
    e.hora_envio AS hora,
    e.destinatario_id AS id_destinatario,
    e.ruta_id AS id_ruta,
    e.sucursal_id AS id_sucursal
FROM clientes c
JOIN envios e ON e.cliente_id = c.cliente_id
WHERE c.cliente_id = 1;


SELECT 
    c.nombre AS nombre_conductor,
    r.descripcion AS ruta
FROM conductores c
JOIN conductores_rutas cr ON c.conductor_id = cr.conductor_id
JOIN rutas r ON cr.ruta_id = r.ruta_id;


SELECT
    r.ruta_id AS id_ruta,
    r.descripcion AS descripcion,
    r.sucursal_id AS id_sucursal
FROM rutas r
JOIN conductores_rutas cr ON r.ruta_id = cr.ruta_id;


SELECT 
    