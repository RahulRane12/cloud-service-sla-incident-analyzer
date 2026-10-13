-- 1. Create the database
CREATE DATABASE IF NOT EXISTS cloud_sla_db;
USE cloud_sla_db;

-- Drop tables if already existing to allow clean rerun
DROP TABLE IF EXISTS fact_incidents;
DROP TABLE IF EXISTS dim_services;

-- 2. Create the Services dimension table
CREATE TABLE dim_services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(50) NOT NULL,
    service_tier VARCHAR(20) NOT NULL
);

-- 3. Create the Incidents fact table
CREATE TABLE fact_incidents (
    incident_id VARCHAR(20) PRIMARY KEY,
    service_id INT,
    region VARCHAR(30),
    severity VARCHAR(10),
    downtime_minutes INT,
    sla_breached INT,
    FOREIGN KEY (service_id) REFERENCES dim_services(service_id)
);

-- 4. Insert master data into dim_services
INSERT INTO dim_services (service_id, service_name, service_tier) VALUES
(1, 'Auth-Service', 'Tier-1'),
(2, 'Payment-Gate', 'Tier-1'),
(3, 'Notify-Worker', 'Tier-2'),
(4, 'Search-API', 'Tier-2');

-- 5. Insert cleaned incident records
INSERT INTO fact_incidents (incident_id, service_id, region, severity, downtime_minutes, sla_breached) VALUES
('INC-101', 1, 'ap-south-1', 'P1', 75, 1),
('INC-102', 2, 'us-east-1', 'P1', 40, 0),
('INC-103', 3, 'eu-central-1', 'P2', 120, 0),
('INC-104', 1, 'ap-south-1', 'P2', 290, 1),
('INC-105', 4, 'us-east-1', 'P3', 60, 0),
('INC-106', 2, 'us-east-1', 'P2', 85, 0),
('INC-107', 4, 'eu-central-1', 'P1', 95, 1);
