CREATE DATABASE medtrack;
USE medtrack;

CREATE TABLE suppliers (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200),
  contact VARCHAR(200)
);

CREATE TABLE medications (
  med_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200),
  strength VARCHAR(50),
  supplier_id INT,
  unit_price DECIMAL(10,2),
  CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE inventory (
  inventory_id INT AUTO_INCREMENT PRIMARY KEY,
  med_id INT,
  batch VARCHAR(100),
  quantity INT,
  expiry_date DATE,
  location VARCHAR(100),
  CONSTRAINT fk_med FOREIGN KEY (med_id) REFERENCES medications(med_id)
);

CREATE TABLE patients (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200),
  dob DATE
);

CREATE TABLE prescriptions (
  presc_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT,
  med_id INT,
  dosage VARCHAR(100),
  quantity INT,
  date_issued DATE,
  prescriber VARCHAR(200),
  status VARCHAR(50), -- e.g., issued/dispensed
  CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  CONSTRAINT fk_med2 FOREIGN KEY (med_id) REFERENCES medications(med_id)
);
