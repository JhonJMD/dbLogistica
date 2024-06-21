CREATE DATABASE logistica;

USE logistica;

CREATE TABLE paises(
	pais_id VARCHAR(10),
	nombre VARCHAR(100),
	CONSTRAINT pk_id_pais PRIMARY KEY (pais_id)
);

CREATE TABLE estado_paquete(
	estado_id INT AUTO_INCREMENT,
	nombre VARCHAR(20),
	CONSTRAINT pk_id_estado_paquete PRIMARY KEY (estado_id)
);

CREATE TABLE tipo_servicio(
	servicio_id INT AUTO_INCREMENT,
	nombre VARCHAR(50),
	CONSTRAINT pk_id_servicio PRIMARY KEY (servicio_id)
);

CREATE TABLE conductores(
	conductor_id INT AUTO_INCREMENT,
	nombre VARCHAR(100),
	CONSTRAINT pk_id_conductor PRIMARY KEY (conductor_id)
);

CREATE TABLE marcas(
	marca_id INT AUTO_INCREMENT,
	nombre VARCHAR(50),
	CONSTRAINT pk_id_marca PRIMARY KEY (marca_id)
);

CREATE TABLE estado_seguimiento(
	estado_id INT AUTO_INCREMENT,
	nombre VARCHAR(20),
	CONSTRAINT pk_id_estado_seguimiento PRIMARY KEY (estado_id)
);

CREATE TABLE dimensiones(
	dimension_id INT AUTO_INCREMENT,
	ancho DOUBLE(5,2),
	largo DOUBLE(5,2),
	CONSTRAINT pk_id_dimension PRIMARY KEY (dimension_id)
);

CREATE TABLE auxiliares(
	auxiliar_id INT AUTO_INCREMENT,
	nombre VARCHAR(100),
	CONSTRAINT pk_id_auxiliar PRIMARY KEY (auxiliar_id)
);

CREATE TABLE telefono_auxiliares(
	telefono_id INT AUTO_INCREMENT,
	numero VARCHAR(20),
	auxiliar_id INT(11),
	CONSTRAINT pk_idtelefono_telauxiliar PRIMARY KEY (telefono_id),
	CONSTRAINT fk_idauxiliar_telauxiliar FOREIGN KEY (auxiliar_id) REFERENCES auxiliares(auxiliar_id)
);

CREATE TABLE ciudades( 
	ciudad_id VARCHAR(10),
	nombre VARCHAR(100),
	pais_id VARCHAR(10),
	CONSTRAINT pk_id_ciudad PRIMARY KEY (ciudad_id),
	CONSTRAINT fk_idpais_ciudad FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
);

CREATE TABLE direccion_cliente(
	direccion_idcli INT AUTO_INCREMENT,
	calle VARCHAR(20),
	carrera VARCHAR(20),
	descripcion VARCHAR(200),
	ciudad_id VARCHAR(10),
	CONSTRAINT pk_iddireccion_direccli PRIMARY KEY (direccion_idcli),
	CONSTRAINT fk_idciudad_direccli FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE TABLE direccion_destinatario(
	direccion_iddes INT AUTO_INCREMENT,
	calle VARCHAR(20),
	carrera VARCHAR(20),
	descripcion VARCHAR(200),
	ciudad_id VARCHAR(10),
	CONSTRAINT pk_iddireccion_direcdes PRIMARY KEY (direccion_iddes),
	CONSTRAINT fk_idciudad_direcdes FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE TABLE direccion_sucursales(
	direccion_idsur INT AUTO_INCREMENT,
	calle VARCHAR(20),
	carrera VARCHAR(20),
	descripcion VARCHAR(200),
	ciudad_id VARCHAR(10),
	CONSTRAINT pk_iddireccion_direcsur PRIMARY KEY (direccion_idsur),
	CONSTRAINT fk_idciudad_direcsur FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE TABLE clientes(
	cliente_id INT AUTO_INCREMENT,
	nombre VARCHAR(100),
	email VARCHAR(100),
	direccion_id INT(11),
	CONSTRAINT pk_id_cliente PRIMARY KEY (cliente_id),
	CONSTRAINT fk_iddireccion_cliente FOREIGN KEY (direccion_id) REFERENCES direccion_cliente(direccion_idcli)
);

CREATE TABLE telefonos_clientes(
	telefono_id INT AUTO_INCREMENT,
	numero VARCHAR(20),
	cliente_id INT(11),
	CONSTRAINT pk_idtelefono_telcliente PRIMARY KEY (telefono_id),
	CONSTRAINT fk_idcliente_telcliente FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE paquetes(
	paquete_id INT AUTO_INCREMENT,
	peso DOUBLE(10,2),
	dimension_id INT(11),
	contenido TEXT,
	valor_declarado DOUBLE(10,2),
	servicio_id INT(11),
	estado_id INT(11),
	CONSTRAINT pk_id_paquete PRIMARY KEY (paquete_id),
	CONSTRAINT fk_idestado_paquete FOREIGN KEY (estado_id) REFERENCES estado_paquete(estado_id),
	CONSTRAINT fk_idservicio_paquete FOREIGN KEY (servicio_id) REFERENCES tipo_servicio(servicio_id),
	CONSTRAINT fk_iddimension_paquete FOREIGN KEY (dimension_id) REFERENCES dimensiones(dimension_id)
);

CREATE TABLE sucursales(
	sucursal_id INT AUTO_INCREMENT,
	nombre VARCHAR(100),
	direccion_id INT(11),
	CONSTRAINT pk_id_sucursal PRIMARY KEY (sucursal_id),
	CONSTRAINT fk_iddireccion_sucursal FOREIGN KEY (direccion_id) REFERENCES direccion_sucursales(direccion_idsur)
);

CREATE TABLE modelos(
	modelo_id INT AUTO_INCREMENT,
	nombre VARCHAR(50),
	marca_id INT(11),
	CONSTRAINT pk_id_modelo PRIMARY KEY (modelo_id),
	CONSTRAINT fk_idmarca_modelo FOREIGN KEY (marca_id) REFERENCES marcas(marca_id)
);

CREATE TABLE vehiculos(
	vehiculo_id INT AUTO_INCREMENT,
	placa VARCHAR(20),
	modelo_id INT(11),
	capacidad_carga DOUBLE(10,2),
	sucursal_id INT(11),
	CONSTRAINT pk_id_vehiculo PRIMARY KEY (vehiculo_id),
	CONSTRAINT fk_idsucursal_vehiculo FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id),
	CONSTRAINT fk_idmodelo_vehiculo FOREIGN KEY (modelo_id) REFERENCES modelos(modelo_id)
);

CREATE TABLE rutas(
	ruta_id INT AUTO_INCREMENT,
	descripcion VARCHAR(200),
	sucursal_id INT(11),
	CONSTRAINT pk_id_ruta PRIMARY KEY (ruta_id),
	CONSTRAINT fk_idsucursal_ruta FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE ruta_axiliares(
	ruta_id INT(11),
	auxiliar_id INT(11),
	CONSTRAINT pk_id_rutaux PRIMARY KEY (ruta_id, auxiliar_id),
	CONSTRAINT fk_idruta_rutaaux FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
	CONSTRAINT fk_idauxiliar_rutaaux FOREIGN KEY (auxiliar_id) REFERENCES auxiliares(auxiliar_id)
);

CREATE TABLE destinatarios(
	destinatario_id INT AUTO_INCREMENT,
	nombre VARCHAR(100),
	email VARCHAR(100),
	direccion_id INT(11),
	CONSTRAINT pk_id_destinatario PRIMARY KEY (destinatario_id),
	CONSTRAINT fk_iddireccion_destinatario FOREIGN KEY (direccion_id) REFERENCES direccion_destinatario(direccion_iddes)
);

CREATE TABLE envios(
	envio_id INT AUTO_INCREMENT,
	cliente_id INT(11),
	paquete_id INT(11),
	fecha_envio DATE,
	hora_envio TIME,
	destinatario_id INT(11),
	ruta_id INT(11),
	sucursal_id INT(11),
	CONSTRAINT pk_id_envio PRIMARY KEY (envio_id),
	CONSTRAINT fk_idcliente_envio FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
	CONSTRAINT fk_idpaquete_envio FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
	CONSTRAINT fk_idruta_envio FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
	CONSTRAINT fk_idsucursal_envio FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id),
	CONSTRAINT fk_iddestinatario_envios FOREIGN KEY (destinatario_id) REFERENCES destinatarios(destinatario_id)
);

CREATE TABLE ubicacion_seguimiento(
	ubicacion_idseg INT AUTO_INCREMENT,
	calle VARCHAR(20),
	carrera VARCHAR(20),
	descripcion VARCHAR(200),
	ciudad_id VARCHAR(10),
	CONSTRAINT pk_idubiseg_ubicaseg PRIMARY KEY (ubicacion_idseg),
	CONSTRAINT fk_idciudad_ubicaseg FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE TABLE seguimiento(
	seguimiento_id VARCHAR(20),
	paquete_id INT(11),
	ubicacion_id INT(11),
	fecha_hora TIME,
	estado_id INT(11),
	CONSTRAINT pk_id_seguimiento PRIMARY KEY (seguimiento_id),
	CONSTRAINT fk_idpaquete_seguimiento FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
	CONSTRAINT fk_idestado_seguimiento FOREIGN KEY (estado_id) REFERENCES estado_seguimiento(estado_id)
);

CREATE TABLE conductores_rutas(
	conductor_id INT(11),
	ruta_id INT(11),
	vehiculo_id INT(11),
	sucursal_id INT(11),
	CONSTRAINT pk_conductores_rutas PRIMARY KEY (conductor_id, ruta_id),
	CONSTRAINT fk_idconductor_conrutas FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id),
	CONSTRAINT fk_idvehiculo_conrutas FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(vehiculo_id),
	CONSTRAINT fk_idsucursal FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE telefonos_conductores(
	telefono_id INT AUTO_INCREMENT,
	numero VARCHAR(20),
	conductor_id INT(11),
	CONSTRAINT pk_idtelefono_telconductor PRIMARY KEY (telefono_id),
	CONSTRAINT fk_idconductor_telconductor FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id)
);
