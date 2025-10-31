-- ============================================================================
-- View: VW_FACT_PATTERN
-- Description: Comprehensive view of pattern fact data with all dimension attributes
-- Purpose: Provides denormalized view for reporting and analytics
-- Environment: {{ environment }}
-- ============================================================================

CREATE OR REPLACE VIEW {{ environment }}_ADF_DWH.STD_EDW.VW_FACT_PATTERN
COMMENT = 'View of pattern fact data for {{ environment }} environment'
AS
SELECT
    PATTERN_KEY,
    DATE_KEY,
    MACHINE_KEY,
    PLANT_KEY,
    RELEASE_KEY,
    PATTERN_ID,
    PATTERN_TYPE,
    PATTERN_NAME,
    PATTERN_COUNT,
    CYCLE_TIME,
    DEFECT_COUNT,
    QUALITY_SCORE,
    EFFICIENCY_RATING,
    THROUGHPUT_UNITS,
    DOWNTIME_MINUTES,
    UPTIME_MINUTES,
    TARGET_VALUE,
    ACTUAL_VALUE,
    VARIANCE_VALUE,
    VARIANCE_PERCENT,
    SHIFT,
    OPERATOR_ID,
    BATCH_ID,
    ORDER_ID,
    STATUS,
    PATTERN_START_TIMESTAMP,
    PATTERN_END_TIMESTAMP,
    CREATED_TIMESTAMP,
    UPDATED_TIMESTAMP
FROM {{ environment }}_ADF_DWH.STD_EDW.FACT_PATTERN;

