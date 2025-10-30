# Views

This directory contains SQL views that provide denormalized, business-friendly access to the data warehouse.

## Available Views

### VW_FACT_PATTERN

**Purpose**: Comprehensive, denormalized view of pattern execution data with all dimension attributes.

**Base Table**: FACT_PATTERN

**Joins**:
- DIM_CALENDAR (date attributes)
- DIM_MACHINES (machine details)
- DIM_PLANT (plant/facility information)
- DIM_RELEASES (release information)
- STD_PATTERN (standard pattern specifications)

**Key Features**:

1. **Complete Dimension Attributes**: All attributes from related dimensions are included
2. **Calculated Metrics**:
   - Performance Rating (Excellent/Good/Acceptable/Poor)
   - Quality Rating
   - Efficiency Rating Classification
   - Overall Equipment Effectiveness (OEE) %
   - Defect Rate %
   - Actual Duration in seconds

3. **Business-Friendly Names**: Clear, descriptive column names
4. **Optimized for Reporting**: Designed for BI tools and analytics

**Common Use Cases**:

```sql
-- 1. Daily Performance Dashboard
SELECT 
    FULL_DATE,
    COUNT(*) AS TOTAL_EXECUTIONS,
    AVG(QUALITY_SCORE) AS AVG_QUALITY,
    AVG(EFFICIENCY_RATING) AS AVG_EFFICIENCY,
    AVG(OEE_PERCENT) AS AVG_OEE
FROM VW_FACT_PATTERN
WHERE FULL_DATE >= DATEADD(DAY, -30, CURRENT_DATE())
GROUP BY FULL_DATE
ORDER BY FULL_DATE;

-- 2. Plant Performance Comparison
SELECT 
    PLANT_NAME,
    PLANT_REGION,
    COUNT(*) AS EXECUTIONS,
    AVG(OEE_PERCENT) AS AVG_OEE,
    SUM(THROUGHPUT_UNITS) AS TOTAL_UNITS,
    AVG(DEFECT_RATE_PERCENT) AS DEFECT_RATE
FROM VW_FACT_PATTERN
WHERE YEAR = YEAR(CURRENT_DATE())
GROUP BY PLANT_NAME, PLANT_REGION
ORDER BY AVG_OEE DESC;

-- 3. Machine Efficiency Analysis
SELECT 
    MACHINE_NAME,
    MACHINE_TYPE,
    PLANT_NAME,
    COUNT(*) AS EXECUTIONS,
    AVG(EFFICIENCY_RATING) AS AVG_EFFICIENCY,
    AVG(CYCLE_TIME) AS AVG_CYCLE_TIME,
    SUM(DOWNTIME_MINUTES) AS TOTAL_DOWNTIME
FROM VW_FACT_PATTERN
WHERE FULL_DATE >= DATEADD(MONTH, -1, CURRENT_DATE())
    AND MACHINE_KEY IS NOT NULL
GROUP BY MACHINE_NAME, MACHINE_TYPE, PLANT_NAME
ORDER BY AVG_EFFICIENCY DESC;

-- 4. Pattern Quality Trends
SELECT 
    PATTERN_NAME,
    PATTERN_TYPE,
    MONTH_NAME,
    YEAR,
    AVG(QUALITY_SCORE) AS AVG_QUALITY,
    COUNT(*) AS EXECUTIONS,
    SUM(DEFECT_COUNT) AS TOTAL_DEFECTS
FROM VW_FACT_PATTERN
WHERE YEAR >= YEAR(CURRENT_DATE()) - 1
GROUP BY PATTERN_NAME, PATTERN_TYPE, MONTH_NAME, YEAR
ORDER BY YEAR DESC, MONTH_NUMBER DESC, AVG_QUALITY DESC;

-- 5. Shift Performance Analysis
SELECT 
    SHIFT,
    PLANT_NAME,
    AVG(QUALITY_SCORE) AS AVG_QUALITY,
    AVG(EFFICIENCY_RATING) AS AVG_EFFICIENCY,
    AVG(OEE_PERCENT) AS AVG_OEE,
    COUNT(*) AS EXECUTIONS
FROM VW_FACT_PATTERN
WHERE FULL_DATE >= DATEADD(MONTH, -3, CURRENT_DATE())
GROUP BY SHIFT, PLANT_NAME
ORDER BY PLANT_NAME, SHIFT;

-- 6. Top Performing Patterns
SELECT 
    PATTERN_NAME,
    PATTERN_TYPE,
    COUNT(*) AS EXECUTIONS,
    AVG(QUALITY_SCORE) AS AVG_QUALITY,
    AVG(EFFICIENCY_RATING) AS AVG_EFFICIENCY,
    AVG(OEE_PERCENT) AS AVG_OEE,
    AVG(VARIANCE_PERCENT) AS AVG_VARIANCE_PCT
FROM VW_FACT_PATTERN
WHERE FULL_DATE >= DATEADD(MONTH, -1, CURRENT_DATE())
GROUP BY PATTERN_NAME, PATTERN_TYPE
HAVING COUNT(*) >= 10
ORDER BY AVG_OEE DESC
LIMIT 20;

-- 7. Defect Analysis by Plant and Machine
SELECT 
    PLANT_NAME,
    MACHINE_NAME,
    COUNT(*) AS EXECUTIONS,
    SUM(DEFECT_COUNT) AS TOTAL_DEFECTS,
    SUM(THROUGHPUT_UNITS) AS TOTAL_UNITS,
    AVG(DEFECT_RATE_PERCENT) AS AVG_DEFECT_RATE,
    AVG(QUALITY_SCORE) AS AVG_QUALITY
FROM VW_FACT_PATTERN
WHERE FULL_DATE >= DATEADD(MONTH, -1, CURRENT_DATE())
GROUP BY PLANT_NAME, MACHINE_NAME
HAVING SUM(DEFECT_COUNT) > 0
ORDER BY TOTAL_DEFECTS DESC;

-- 8. Weekend vs Weekday Performance
SELECT 
    CASE WHEN IS_WEEKEND THEN 'Weekend' ELSE 'Weekday' END AS DAY_TYPE,
    COUNT(*) AS EXECUTIONS,
    AVG(QUALITY_SCORE) AS AVG_QUALITY,
    AVG(EFFICIENCY_RATING) AS AVG_EFFICIENCY,
    AVG(OEE_PERCENT) AS AVG_OEE
FROM VW_FACT_PATTERN
WHERE FULL_DATE >= DATEADD(MONTH, -3, CURRENT_DATE())
GROUP BY CASE WHEN IS_WEEKEND THEN 'Weekend' ELSE 'Weekday' END;

-- 9. Monthly Performance Trends
SELECT 
    YEAR,
    MONTH_NAME,
    COUNT(*) AS EXECUTIONS,
    AVG(QUALITY_SCORE) AS AVG_QUALITY,
    AVG(EFFICIENCY_RATING) AS AVG_EFFICIENCY,
    AVG(OEE_PERCENT) AS AVG_OEE,
    SUM(THROUGHPUT_UNITS) AS TOTAL_UNITS,
    SUM(DEFECT_COUNT) AS TOTAL_DEFECTS
FROM VW_FACT_PATTERN
WHERE YEAR >= YEAR(CURRENT_DATE()) - 1
GROUP BY YEAR, MONTH_NAME, MONTH_NUMBER
ORDER BY YEAR DESC, MONTH_NUMBER DESC;

-- 10. Release Impact Analysis
SELECT 
    RELEASE_NAME,
    RELEASE_VERSION,
    COUNT(*) AS EXECUTIONS,
    AVG(QUALITY_SCORE) AS AVG_QUALITY,
    AVG(EFFICIENCY_RATING) AS AVG_EFFICIENCY,
    AVG(CYCLE_TIME) AS AVG_CYCLE_TIME
FROM VW_FACT_PATTERN
WHERE RELEASE_KEY IS NOT NULL
    AND FULL_DATE >= DATEADD(MONTH, -6, CURRENT_DATE())
GROUP BY RELEASE_NAME, RELEASE_VERSION
ORDER BY RELEASE_NAME, RELEASE_VERSION;
```

## Column Reference

### Dimension Keys
- `PATTERN_KEY` - Fact table primary key
- `DATE_KEY` - Calendar dimension key
- `MACHINE_KEY` - Machine dimension key
- `PLANT_KEY` - Plant dimension key
- `RELEASE_KEY` - Release dimension key

### Date Attributes (from DIM_CALENDAR)
- `FULL_DATE`, `YEAR`, `QUARTER`, `MONTH_NAME`, `MONTH_NUMBER`
- `WEEK_OF_YEAR`, `DAY_OF_WEEK_NAME`, `DAY_OF_MONTH`
- `IS_WEEKEND`, `IS_HOLIDAY`, `HOLIDAY_NAME`
- `FISCAL_YEAR`, `FISCAL_QUARTER`

### Machine Attributes (from DIM_MACHINES)
- `MACHINE_ID`, `MACHINE_NAME`, `MACHINE_CODE`, `MACHINE_TYPE`
- `MANUFACTURER`, `MACHINE_MODEL`, `SERIAL_NUMBER`
- `MACHINE_STATUS`, `MACHINE_IS_ACTIVE`, `MACHINE_DEPARTMENT`

### Plant Attributes (from DIM_PLANT)
- `PLANT_ID`, `PLANT_NAME`, `PLANT_CODE`, `PLANT_TYPE`
- `PLANT_LOCATION`, `PLANT_CITY`, `PLANT_STATE`, `PLANT_COUNTRY`, `PLANT_REGION`

### Release Attributes (from DIM_RELEASES)
- `RELEASE_ID`, `RELEASE_NAME`, `RELEASE_CODE`, `RELEASE_VERSION`
- `RELEASE_TYPE`, `PRODUCT_NAME`, `RELEASE_DATE`, `RELEASE_STATUS`

### Pattern Information
- `PATTERN_ID`, `PATTERN_NAME`, `PATTERN_TYPE`
- `STD_PATTERN_NAME`, `PATTERN_CATEGORY`, `PATTERN_FAMILY`
- `STANDARD_CYCLE_TIME`, `STD_TARGET_QUALITY_SCORE`, `STD_TARGET_EFFICIENCY`

### Metrics
- `PATTERN_COUNT`, `CYCLE_TIME`, `THROUGHPUT_UNITS`
- `QUALITY_SCORE`, `EFFICIENCY_RATING`
- `DEFECT_COUNT`, `UPTIME_MINUTES`, `DOWNTIME_MINUTES`

### Performance Indicators
- `TARGET_VALUE`, `ACTUAL_VALUE`, `VARIANCE_VALUE`, `VARIANCE_PERCENT`
- `PERFORMANCE_RATING` - Calculated: Excellent/Good/Acceptable/Poor
- `QUALITY_RATING` - Calculated: Excellent/Good/Acceptable/Poor
- `EFFICIENCY_RATING_CLASS` - Calculated: Excellent/Good/Acceptable/Poor
- `OEE_PERCENT` - Overall Equipment Effectiveness
- `DEFECT_RATE_PERCENT` - Defects per unit

### Additional Attributes
- `SHIFT`, `OPERATOR_ID`, `BATCH_ID`, `ORDER_ID`, `STATUS`

### Timestamps
- `PATTERN_START_TIMESTAMP`, `PATTERN_END_TIMESTAMP`
- `ACTUAL_DURATION_SECONDS`
- `CREATED_TIMESTAMP`, `UPDATED_TIMESTAMP`

## Performance Considerations

1. **Indexing**: The base FACT_PATTERN table has indexes on all foreign keys
2. **Materialized View**: For very large datasets, consider creating a materialized view
3. **Partitioning**: Consider partitioning by date for better performance
4. **Caching**: Snowflake's result caching helps with repeated queries

## Creating Materialized View (Optional)

For better performance on large datasets:

```sql
CREATE OR REPLACE MATERIALIZED VIEW VW_FACT_PATTERN_MATERIALIZED AS
SELECT * FROM VW_FACT_PATTERN;

-- Refresh the materialized view
ALTER MATERIALIZED VIEW VW_FACT_PATTERN_MATERIALIZED REFRESH;
```

## BI Tool Integration

This view is optimized for use with:
- Tableau
- Power BI
- Looker
- Qlik Sense
- Other BI and reporting tools

Simply connect to the view as your data source and all dimension attributes are readily available.

## Deployment

This view is included in the deployment scripts and will be created automatically.

Manual deployment:

```bash
# Using Snowflake CLI
snow sql -f dev_adf_dwh/views/vw_fact_pattern.sql

# Or include in deployment
./scripts/deploy.sh dev
```

## Maintenance

- The view automatically reflects changes to underlying tables
- No manual refresh needed (unless using materialized view)
- Monitor query performance and add indexes as needed
- Consider aggregated views for common summary queries

