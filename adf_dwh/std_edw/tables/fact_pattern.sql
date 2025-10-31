-- ============================================================================
-- Table: FACT_PATTERN
-- Description: Fact table for pattern analysis and metrics
-- Type: Fact Table (Transaction Grain)
-- Environment: {{ environment }}
-- ============================================================================

CREATE OR ALTER TABLE {{ environment }}_ADF_DWH.STD_EDW.FACT_PATTERN (
    PATTERN_KEY INT AUTOINCREMENT NOT NULL COMMENT 'Surrogate key for pattern fact',
    DATE_KEY INT NOT NULL COMMENT 'Foreign key to DIM_CALENDAR',
    MACHINE_KEY INT COMMENT 'Foreign key to DIM_MACHINES',
    PLANT_KEY INT COMMENT 'Foreign key to DIM_PLANT',
    RELEASE_KEY INT COMMENT 'Foreign key to DIM_RELEASES',
    
    -- Pattern Identifiers
    PATTERN_ID VARCHAR(50) NOT NULL COMMENT 'Pattern identifier',
    PATTERN_TYPE VARCHAR(50) COMMENT 'Type or category of pattern',
    PATTERN_NAME VARCHAR(200) COMMENT 'Name of the pattern',
    
    -- Metrics
    PATTERN_COUNT INT COMMENT 'Number of pattern occurrences',
    CYCLE_TIME DECIMAL(18,2) COMMENT 'Cycle time in seconds',
    DEFECT_COUNT INT DEFAULT 0 COMMENT 'Number of defects detected',
    QUALITY_SCORE DECIMAL(5,2) COMMENT 'Quality score (0-100)',
    EFFICIENCY_RATING DECIMAL(5,2) COMMENT 'Efficiency rating (0-100)',
    THROUGHPUT_UNITS INT COMMENT 'Number of units processed',
    DOWNTIME_MINUTES DECIMAL(10,2) DEFAULT 0 COMMENT 'Downtime in minutes',
    UPTIME_MINUTES DECIMAL(10,2) COMMENT 'Uptime in minutes',
    
    -- Performance Indicators
    TARGET_VALUE DECIMAL(18,2) COMMENT 'Target value for the metric',
    ACTUAL_VALUE DECIMAL(18,2) COMMENT 'Actual value achieved',
    VARIANCE_VALUE DECIMAL(18,2) COMMENT 'Variance from target',
    VARIANCE_PERCENT DECIMAL(5,2) COMMENT 'Variance percentage',
    
    -- Additional Attributes
    SHIFT VARCHAR(20) COMMENT 'Shift during which pattern occurred',
    OPERATOR_ID VARCHAR(50) COMMENT 'Operator identifier',
    BATCH_ID VARCHAR(50) COMMENT 'Batch or lot identifier',
    ORDER_ID VARCHAR(50) COMMENT 'Order identifier',
    STATUS VARCHAR(50) COMMENT 'Status of the pattern execution',
    
    -- Timestamps
    PATTERN_START_TIMESTAMP TIMESTAMP_NTZ COMMENT 'Pattern start timestamp',
    PATTERN_END_TIMESTAMP TIMESTAMP_NTZ COMMENT 'Pattern end timestamp',
    CREATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record creation timestamp',
    UPDATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record update timestamp'
)
COMMENT = 'Fact table containing pattern execution metrics for {{ environment }} environment';
