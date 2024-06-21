

# Base de datos logistica

![](/home/camper/Documents/JhonJMD/DB/dbLogistica/ERLogistica.png)

## Casos de uso:

1. Registrar un nuevo Pais:

   ```sql
   INSERT INTO paises (pais_id, nombre)
   VALUES ('PA001', 'Colombia');
   ```

2. Registrar una nueva Ciudad:

   ```SQL
   INSERT INTO ciudades (ciudad_id, nombre, pais_id)
   VALUES ('CI001','Bucaramanga','PA001');
   ```

3. Registrar una nueva Sucursal:

   ```SQL
   INSERT INTO direccion_sucursales (calle, carrera, descripcion, ciudad_id)
   VALUES ('Calle 34', 'Carrera 2', 'Avinida 2 Barrio Palomitas', 'CI001');
   SET @direccion_idsur = LAST_INSERT_ID();
   
   INSERT INTO sucursales (nombre, direccion_id)
   VALUES ('Envia BGA', @direccion_idsur);
   ```

4. Registrar un nuevo Cliente:

   ```sql
   INSERT INTO direccion_cliente (calle, carrera, descripcion, ciudad_id)
   VALUES ('Calle 12', 'Carrera 40', 'Conjuntto Miraflores', 'CI001');
   SET @direccion_idcli = LAST_INSERT_ID();
   
   INSERT INTO clientes (nombre, email, direccion_id)
   VALUES ('John Dee', 'johndee@gmail.com', @direccion_idcli);
   ```

5. Registrar un nuevo numero de telefono para un Cliente:

   ```sql
   SET @cliente_id = LAST_INSERT_ID();
   
   INSERT INTO telefonos_clientes(numero, cliente_id)
   VALUES ('3124198288', @cliente_id);
   ```

6. Registrar un nuevo Paquete:

   ```sql
   INSERT INTO estado_paquete (nombre)
   VALUES ('Bodega'), ('Proceso de Envio'), ('Enviado'), ('Entregado');
   
   INSERT INTO tipo_servicio (nombre)
   VALUES ('Paqueteria'), ('Mensajeria'), ('Almacenamiento');
   
   INSERT INTO dimensiones (ancho, largo)
   VALUES (10.00, 20.00);
   SET @dimension_id = LAST_INSERT_ID();
   
   INSERT INTO paquetes (peso, dimension_id, contenido, valor_declarado, servicio_id, estado_id)
   VALUES (5.50, @dimension_id, 'Equipos electronicos delicados', 100.00, 1, 1);
   ```

7. Registrar un nuevo Envio:

   ```sql
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
   ```

8. Registrar un nuevo Vehiculo:

   ```SQL
   INSERT INTO marcas (nombre)
   VALUES ('Mercedez');
   
   SET @marca_id = LAST_INSERT_ID();
   
   INSERT INTO modelos (nombre, marca_id)
   VALUES ('MG002', @marca_id);
   
   SET @modelo_id = LAST_INSERT_ID();
   
   INSERT INTO vehiculos (placa, modelo_id, capacidad_carga, sucursal_id)
   VALUES ('ABC123', @modelo_id, 1000.00, @sucursal_id);
   
   SET @vehiculo_id = LAST_INSERT_ID();
   ```

9. Registrar un nuevo Conductor:

   ```sql
   INSERT INTO conductores (nombre)
   VALUES ('Jose Heredia');
   SET @conductor_id = LAST_INSERT_ID();
   ```

10. Registrar un nuevo numero de telefono para un Conductor:

    ```sql
    INSERT INTO telefonos_conductores (numero, conductor_id)
    VALUES ('3124198581', @conductor_id);
    ```

11. Asignar un Conductor a una Ruta y un Vehiculo:

    ```sql
    INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id, sucursal_id)
    VALUES (@conductor_id, @ruta_id, @vehiculo_id, 1);
    ```

12. Registrar un nuevo Auxiliar:

    ```sql
    INSERT INTO auxiliares (nombre)
    VALUES ('Maria Alejandra');
    SET @auxiliar_id = LAST_INSERT_ID();
    ```

13. Asignar un Auxiliar a una Ruta:

    ```sql
    INSERT INTO ruta_axiliares (ruta_id, auxiliar_id)
    VALUES (@ruta_id, @auxiliar_id);
    ```

14. Registrar un Evento de Seguimiento para un Cliente:

    ```sql
    INSERT INTO ubicacion_seguimiento (calle, carrera, descripcion, ciudad_id)
    VALUES ('No Aplica', 'No Aplica', 'Via BGA', 'CI001');
    SET @ubicacion_idseg = LAST_INSERT_ID();
    
    INSERT INTO estado_seguimiento (nombre)
    VALUES ('Preparacion'), ('Encamino'), ('Entregado');
    
    INSERT INTO seguimiento (seguimiento_id, paquete_id, ubicacion_id, fecha_hora, estado_id)
    VALUES ('SEGU123', @paquete_id, @ubicacion_idseg, '12:00:00', 1);
    ```

15. Generar un Reporte de Envios por Cliente:

    ```sql
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
    ```

16. Actualizar el Estado de un Paquete:

    ```sql
    SET @nuevo_estado_id = 2;
    
    UPDATE paquetes
    SET estado_id = @nuevo_estado_id
    WHERE paquete_id = @paquete_id;
    ```

17. Rastrear la Ubicacion Actual de un Paquete:

    ```sql
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
    ```

## Casos Multitabla:

1. Obtener informacion completa de Envios:

   ```sql
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
   ```

2. Obtener historial de Envios de un Cliente:

   ```SQL
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
   ```

3. Listar Conductores y sus Rutas Asignadas:

   ```sql
   SELECT 
       c.nombre AS nombre_conductor,
       r.descripcion AS ruta
   FROM conductores c
   JOIN conductores_rutas cr ON c.conductor_id = cr.conductor_id
   JOIN rutas r ON cr.ruta_id = r.ruta_id;
   ```

4. Obtener detalles de Rutas Asignadas:

   ```sql
   SELECT
       r.ruta_id AS id_ruta,
       r.descripcion AS descripcion,
       r.sucursal_id AS id_sucursal
   FROM rutas r
   JOIN conductores_rutas cr ON r.ruta_id = cr.ruta_id;
   ```

5. Generar reporte de Paquetes por Sucursal y Estado:

   ```SQL
   
   ```

6. Obtener informacion completa de un Paquete y su historial de Seguimiento:

   ```
   
   ```

## Casos de uso Between, In y Not In:

1. Obtener Paquetes enviados dentro de un rango de fechas:
2. Obtener Paquetes con Ciertos Estados:
3. Obtener Paquetes excluyendo ciertos Estados:
4. Obtener Clientes con Envios realizados dentro de un rango de Fechas:
5. Obtener Conductores disponibles que no estan asignados a ciertas rutas:
6. Obtener Información de paquetes con valor declarado dentro de un Rango específico:
7. Obtener Auxiliares asignados a Rutas específicas:
8. Obtener envíos a destinos excluyendo ciertas Ciudades:
9. Obtener Seguimientos de Paquetes en un Rango de fechas:
10. Obtener Clientes que tienen ciertos tipos de Paquetes: