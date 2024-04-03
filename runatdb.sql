-- CREACION DB --
DROP DATABASE runat;
CREATE DATABASE runat;
USE runat;

CREATE TABLE ubicacion(
	id_location INT NOT NULL AUTO_INCREMENT,
    city_name VARCHAR(30) NOT NULL,
    city_zipcode INT NOT NULL,
    state VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_location)
);

CREATE TABLE departamentos(
	id_department INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(30)NOT NULL,
    department_description VARCHAR(300) NOT NULL,
    PRIMARY KEY (id_department)
);

CREATE TABLE rangos(
	id_rank INT NOT NULL AUTO_INCREMENT,
    rank_name_hierarchy VARCHAR(30) NOT NULL,
    salary_floor DECIMAL NOT NULL,
    salary_ceiling DECIMAL NOT NULL,
    PRIMARY KEY (id_rank)
);

CREATE TABLE puestos(
	id_position INT NOT NULL AUTO_INCREMENT,
    position_name VARCHAR(30) NOT NULL,
    id_rank INT NOT NULL,
    id_department INT NOT NULL,
    PRIMARY KEY (id_position),
    FOREIGN KEY (id_rank) REFERENCES rangos(id_rank),
    FOREIGN KEY (id_department) REFERENCES departamentos(id_department)
);

CREATE TABLE empleados(
	id_employee INT NOT NULL AUTO_INCREMENT,
    employee_name VARCHAR(150) NOT NULL,
    phone INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    rfc_employee VARCHAR(50) NOT NULL,
    salary DECIMAL NOT NULL,
    employee_bank_name VARCHAR(70) NOT NULL,
    employee_bank_account INT NOT NULL,
    hiring_date DATE NOT NULL,
    id_manager INT,
    id_location INT,
    id_position INT,
    PRIMARY KEY (id_employee),
    FOREIGN KEY (id_manager) REFERENCES empleados(id_employee),
    FOREIGN KEY (id_location) REFERENCES ubicacion(id_location),
    FOREIGN KEY (id_position) REFERENCES puestos(id_position)
);
	
CREATE TABLE categoria_actividades(
	id_category INT NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_category)
);

CREATE TABLE experiencias_tours(
	id_experience INT NOT NULL AUTO_INCREMENT,
    experience_name VARCHAR(150) NOT NULL,
    id_category INT NOT NULL,
    experience_description VARCHAR(255) NOT NULL,
    duration INT NOT NULL,
    requirements_restrictions VARCHAR(255) NOT NULL,
    price_per_person DECIMAL NOT NULL,
    payment_agreement_percent DECIMAL NOT NULL,
    id_location INT NOT NULL,
    PRIMARY KEY (id_experience),
    FOREIGN KEY (id_category) REFERENCES categoria_actividades(id_category),
    FOREIGN KEY (id_location) REFERENCES ubicacion(id_location)
);

CREATE TABLE proveedores_experiencias(
	id_supplier INT NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(150) NOT NULL,
    phone INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    main_contact_name VARCHAR(150) NOT NULL,
    payment_method DECIMAL NOT NULL,
    bank_name VARCHAR(150) NOT NULL,
    bank_account INT NOT NULL,
    supplier_rfc VARCHAR(50) NOT NULL,
    id_location INT NOT NULL,
	PRIMARY KEY (id_supplier),
    FOREIGN KEY (id_location) REFERENCES ubicacion(id_location)    
);

CREATE TABLE clientes(
	id_customer INT NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(150) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone INT NOT NULL,
    rfc_customer VARCHAR(50) NOT NULL,
    id_location INT NOT NULL,
    PRIMARY KEY (id_customer),
    FOREIGN KEY (id_location) REFERENCES ubicacion(id_location)
);

CREATE TABLE ventas(
	id_sale_transaction INT NOT NULL AUTO_INCREMENT,
    id_customer INT NOT NULL,
    id_experience INT NOT NULL,
    sale_date DATE NOT NULL,
    experience_date DATE NOT NULL,
    group_size INT NOT NULL,
    amount_total DECIMAL NOT NULL,
    id_employee_sale INT NOT NULL,
    id_employee_lead INT NOT NULL,
    notes VARCHAR(255), 
    PRIMARY KEY (id_sale_transaction),
    FOREIGN KEY (id_customer) REFERENCES clientes(id_customer),
    FOREIGN KEY (id_experience) REFERENCES experiencias_tours(id_experience),
    FOREIGN KEY (id_employee_sale) REFERENCES empleados(id_employee),
    FOREIGN KEY (id_employee_lead) REFERENCES empleados(id_employee)
);

CREATE TABLE feedback(
	id_feedback INT NOT NULL AUTO_INCREMENT,
    id_customer INT NOT NULL,
    id_experience INT NOT NULL, 
    id_employee INT NOT NULL,
	id_supervision INT NOT NULL,
    feedback_received VARCHAR(300),
    feedback_status VARCHAR(20),
    resolution VARCHAR(300),
    PRIMARY KEY (id_feedback),
    FOREIGN KEY (id_customer) REFERENCES clientes(id_customer),
    FOREIGN KEY (id_experience) REFERENCES experiencias_tours(id_experience),
    FOREIGN KEY (id_employee) REFERENCES empleados(id_employee),
    FOREIGN KEY (id_supervision) REFERENCES empleados(id_employee)
);


CREATE TABLE pago_proveedores(
	id_payment_transaction INT NOT NULL AUTO_INCREMENT,
    id_supplier INT NOT NULL,
    id_experience INT NOT NULL,
    id_sale_transaction INT NOT NULL,
    total_payment DECIMAL NOT NULL,
    payment_date DATE NOT NULL,
    PRIMARY KEY (id_payment_transaction),
    FOREIGN KEY (id_supplier) REFERENCES proveedores_experiencias(id_supplier),
    FOREIGN KEY (id_experience) REFERENCES experiencias_tours(id_experience),
    FOREIGN KEY (id_sale_transaction) REFERENCES ventas(id_sale_transaction)
);
