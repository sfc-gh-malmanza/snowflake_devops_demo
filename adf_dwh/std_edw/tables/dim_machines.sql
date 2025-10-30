-- ============================================================================
-- Table: DIM_MACHINES
-- Description: Machine dimension table with equipment information
-- Type: Dimension (SCD Type 2)
-- Environment: {{ environment }}
-- ============================================================================

CREATE OR ALTER TABLE {{ environment }}_ADF_DWH.STD_EDW.DIM_MACHINES (
    MACHINE_KEY INT AUTOINCREMENT NOT NULL COMMENT 'Surrogate key for machine dimension',
    MACHINE_ID VARCHAR(50) NOT NULL COMMENT 'Natural key - Machine identifier',
    MACHINE_NAME VARCHAR(200) NOT NULL COMMENT 'Name of the machine',
    MACHINE_CODE VARCHAR(20) COMMENT 'Short code for the machine',
    PLANT_KEY INT COMMENT 'Foreign key to DIM_PLANT',
    MACHINE_TYPE VARCHAR(100) COMMENT 'Type or category of machine',
    MANUFACTURER VARCHAR(200) COMMENT 'Machine manufacturer',
    MODEL VARCHAR(100) COMMENT 'Machine model',
    SERIAL_NUMBER VARCHAR(100) COMMENT 'Serial number',
    PURCHASE_DATE DATE COMMENT 'Date machine was purchased',
    INSTALLATION_DATE DATE COMMENT 'Date machine was installed',
    WARRANTY_EXPIRATION_DATE DATE COMMENT 'Warranty expiration date',
    CAPACITY_UNITS VARCHAR(20) COMMENT 'Unit of measure for machine capacity',
    CAPACITY_VALUE DECIMAL(18,2) COMMENT 'Machine capacity value',
    POWER_RATING DECIMAL(18,2) COMMENT 'Power rating in kilowatts',
    IS_ACTIVE BOOLEAN DEFAULT TRUE COMMENT 'Flag indicating if machine is currently operational',
    STATUS VARCHAR(50) COMMENT 'Current status (Running, Idle, Maintenance, etc.)',
    MAINTENANCE_INTERVAL_DAYS INT COMMENT 'Days between maintenance cycles',
    LAST_MAINTENANCE_DATE DATE COMMENT 'Date of last maintenance',
    NEXT_MAINTENANCE_DATE DATE COMMENT 'Date of next scheduled maintenance',
    DEPARTMENT VARCHAR(100) COMMENT 'Department responsible for machine',
    COST_CENTER VARCHAR(50) COMMENT 'Cost center for accounting',
    NOTES TEXT COMMENT 'Additional notes or comments',
    CREATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record creation timestamp',
    UPDATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record update timestamp',
)
COMMENT = 'Machine dimension table for {{ environment }} environment';
