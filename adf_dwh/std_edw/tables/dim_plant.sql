-- ============================================================================
-- Table: DIM_PLANT
-- Description: Plant dimension table with manufacturing facility information
-- Type: Dimension (SCD Type 2)
-- Environment: {{ environment }}
-- ============================================================================

CREATE OR ALTER TABLE {{ environment }}_ADF_DWH.STD_EDW.DIM_PLANT (
    PLANT_KEY INT AUTOINCREMENT NOT NULL COMMENT 'Surrogate key for plant dimension',
    PLANT_ID VARCHAR(50) NOT NULL COMMENT 'Natural key - Plant identifier',
    PLANT_NAME VARCHAR(200) NOT NULL COMMENT 'Name of the plant',
    PLANT_CODE VARCHAR(20) COMMENT 'Short code for the plant',
    LOCATION VARCHAR(200) COMMENT 'Physical location of the plant',
    CITY VARCHAR(100) COMMENT 'City where plant is located',
    STATE VARCHAR(50) COMMENT 'State where plant is located',
    COUNTRY VARCHAR(100) COMMENT 'Country where plant is located',
    POSTAL_CODE VARCHAR(20) COMMENT 'Postal/ZIP code',
    REGION VARCHAR(100) COMMENT 'Geographic region',
    PLANT_TYPE VARCHAR(50) COMMENT 'Type of plant (Manufacturing, Assembly, etc.)',
    CAPACITY_UNITS VARCHAR(20) COMMENT 'Unit of measure for capacity',
    CAPACITY_VALUE DECIMAL(18,2) COMMENT 'Production capacity value',
    IS_ACTIVE BOOLEAN DEFAULT TRUE COMMENT 'Flag indicating if plant is currently active',
    OPENING_DATE DATE COMMENT 'Date plant started operations',
    CLOSING_DATE DATE COMMENT 'Date plant closed operations (if applicable)',
    MANAGER_NAME VARCHAR(200) COMMENT 'Name of plant manager',
    PHONE VARCHAR(50) COMMENT 'Plant contact phone number',
    EMAIL VARCHAR(200) COMMENT 'Plant contact email',
    CREATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record creation timestamp',
    UPDATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record update timestamp'
)
COMMENT = 'Plant dimension table for {{ environment }} environment';
