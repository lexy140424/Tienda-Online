CREATE DATABASE tienda_online;
USE tienda_online;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    imagen VARCHAR(255),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    rol ENUM('cliente','admin') DEFAULT 'cliente'
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('Pendiente','Pagado','Enviado','Entregado','Cancelado') DEFAULT 'Pendiente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO categorias (nombre, descripcion) VALUES
('Zapatillas','Calzado deportivo'),
('Remeras','Ropa deportiva'),
('Accesorios','Complementos');

INSERT INTO productos (nombre,descripcion,precio,stock,imagen,id_categoria) VALUES
('Nike Air Max','Zapatilla deportiva',150000,15,'airmax.jpg',1),
('Adidas Campus','Zapatilla urbana',130000,10,'campus.jpg',1),
('Remera Oversize','Color negro',30000,20,'remera.jpg',2),
('Gorra Nike','Color blanco',25000,12,'gorra.jpg',3);

INSERT INTO usuarios (nombre,apellido,email,contraseña,telefono,direccion,rol) VALUES
('Administrador','Sistema','admin@tienda.com','admin123','111111111','CABA','admin'),
('Juan','Pérez','juan@gmail.com','123456','1122334455','Buenos Aires','cliente');

INSERT INTO pedidos (id_usuario,total,estado)
VALUES (2,180000,'Pendiente');

INSERT INTO detalle_pedido (id_pedido,id_producto,cantidad,precio_unitario,subtotal)
VALUES (1,1,1,150000,150000),
(1,4,1,30000,30000);
