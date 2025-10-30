-- ============================================================================
-- Table: DIM_CALENDAR
-- Description: Calendar dimension table with date attributes
-- Type: Dimension (SCD Type 1)
-- Environment: {{ environment }}
-- ============================================================================
CREATE OR ALTER TABLE {{ environment }}_ADF_DWH.STD_EDW.DIM_CALENDAR (
    DATE_KEY INT NOT NULL COMMENT 'Unique identifier for the date (YYYYMMDD format)',
    FULL_DATE DATE NOT NULL COMMENT 'Full date value',
    DAY_OF_WEEK INT COMMENT 'Day of week (1-7, 1=Sunday)',
    DAY_OF_WEEK_NAME VARCHAR(10) COMMENT 'Name of the day (Monday, Tuesday, etc.)',
    DAY_OF_MONTH INT COMMENT 'Day of the month (1-31)',
    DAY_OF_YEAR INT COMMENT 'Day of the year (1-366)',
    WEEK_OF_YEAR INT COMMENT 'Week of the year (1-53)',
    MONTH_NUMBER INT COMMENT 'Month number (1-12)',
    MONTH_NAME VARCHAR(10) COMMENT 'Name of the month',
    QUARTER INT COMMENT 'Quarter (1-4)',
    YEAR INT COMMENT 'Year',
    FISCAL_YEAR INT COMMENT 'Fiscal year',
    FISCAL_QUARTER INT COMMENT 'Fiscal quarter',
    IS_WEEKEND BOOLEAN COMMENT 'Flag indicating if the date is a weekend',
    IS_HOLIDAY BOOLEAN COMMENT 'Flag indicating if the date is a holiday',
    HOLIDAY_NAME VARCHAR(100) COMMENT 'Name of the holiday if applicable',
    CREATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record creation timestamp',
    UPDATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record update timestamp',
)
COMMENT = 'Calendar dimension table for {{ environment }} environment';
