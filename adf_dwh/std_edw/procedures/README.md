# Stored Procedures

This directory contains stored procedures for data loading and processing.

## Available Procedures

### SP_FACT_PATTERN_LOAD

**Purpose**: Load the FACT_PATTERN table from dimension tables with calculated metrics.

**Parameters**:
- `START_DATE` (DATE): Beginning of the date range to load
- `END_DATE` (DATE): End of the date range to load

**Returns**: String message with execution summary

**Usage Examples**:

```sql
-- Load data for January 2025
CALL SP_FACT_PATTERN_LOAD('2025-01-01', '2025-01-31');

-- Load data for current month
CALL SP_FACT_PATTERN_LOAD(
    DATE_TRUNC('MONTH', CURRENT_DATE()), 
    LAST_DAY(CURRENT_DATE())
);

-- Load data for yesterday
CALL SP_FACT_PATTERN_LOAD(
    DATEADD(DAY, -1, CURRENT_DATE()), 
    DATEADD(DAY, -1, CURRENT_DATE())
);

-- Load data for last 7 days
CALL SP_FACT_PATTERN_LOAD(
    DATEADD(DAY, -7, CURRENT_DATE()), 
    CURRENT_DATE()
);
```

**What It Does**:

1. **Creates Staging Data**: Generates pattern execution records by joining:
   - DIM_CALENDAR (for date keys and date attributes)
   - DIM_MACHINES (for active machines)
   - STD_PATTERN (for pattern specifications and targets)
   - DIM_PLANT (via machine relationship)

2. **Calculates Metrics**:
   - Cycle times with variance
   - Quality scores
   - Efficiency ratings
   - Defect counts
   - Uptime/downtime minutes
   - Throughput units

3. **Calculates Performance Indicators**:
   - Variance from target (absolute and percentage)
   - Target vs. actual values

4. **Enriches with Attributes**:
   - Shift information (Day/Evening/Night)
   - Operator IDs
   - Batch and Order IDs
   - Status tracking

5. **Loads FACT_PATTERN**: Inserts enriched data into the fact table

6. **Returns Summary**: Provides execution statistics including:
   - Date range processed
   - Number of rows inserted
   - Execution duration

**Notes**:

- This procedure uses **simulated data** for demonstration purposes
- In production, replace the data generation logic with actual source data from:
  - Staging tables
  - External stages
  - Streams
  - Source system tables

- The procedure uses `CREATE OR REPLACE` for idempotency
- Temporary tables are automatically cleaned up
- Error handling included with automatic cleanup
- Optimized to load one pattern execution per machine per day

**Customization**:

To use with real source data, modify STEP 1 to select from your staging table:

```sql
CREATE OR REPLACE TEMPORARY TABLE TEMP_PATTERN_STAGING AS
SELECT
    c.DATE_KEY,
    m.MACHINE_KEY,
    m.PLANT_KEY,
    r.RELEASE_KEY,
    s.PATTERN_ID,
    s.PATTERN_TYPE,
    -- ... map your source columns here
FROM YOUR_STAGING_TABLE s
INNER JOIN DIM_CALENDAR c ON s.EXECUTION_DATE = c.FULL_DATE
INNER JOIN DIM_MACHINES m ON s.MACHINE_ID = m.MACHINE_ID
-- ... additional joins as needed
WHERE c.FULL_DATE BETWEEN START_DATE AND END_DATE;
```

## Deployment

This procedure is included in the deployment scripts and will be created automatically when you deploy the project.

To deploy manually:

```bash
# Using Snowflake CLI
snow sql -f procedures/sp_fact_pattern_load.sql

# Or using the deployment scripts
./scripts/deploy.sh dev
```

## Testing

After deployment, test the procedure:

```sql
-- Ensure dimension tables have data first
SELECT COUNT(*) FROM DIM_CALENDAR;
SELECT COUNT(*) FROM DIM_MACHINES;
SELECT COUNT(*) FROM DIM_PLANT;
SELECT COUNT(*) FROM STD_PATTERN;

-- Run the procedure for a small date range
CALL SP_FACT_PATTERN_LOAD('2025-01-01', '2025-01-01');

-- Verify data was loaded
SELECT COUNT(*) FROM FACT_PATTERN;

-- Check sample records
SELECT TOP 10 * FROM FACT_PATTERN ORDER BY CREATED_TIMESTAMP DESC;
```

## Scheduling

To schedule this procedure to run automatically, create a Snowflake Task:

```sql
-- Create a task to run daily at 2 AM
CREATE OR REPLACE TASK TASK_DAILY_FACT_PATTERN_LOAD
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = 'USING CRON 0 2 * * * UTC'
AS
    CALL SP_FACT_PATTERN_LOAD(
        DATEADD(DAY, -1, CURRENT_DATE()), 
        DATEADD(DAY, -1, CURRENT_DATE())
    );

-- Enable the task
ALTER TASK TASK_DAILY_FACT_PATTERN_LOAD RESUME;

-- Check task history
SELECT *
FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY())
WHERE NAME = 'TASK_DAILY_FACT_PATTERN_LOAD'
ORDER BY SCHEDULED_TIME DESC
LIMIT 10;
```

## Monitoring

Monitor procedure execution with:

```sql
-- Query history
SELECT 
    QUERY_TEXT,
    START_TIME,
    END_TIME,
    TOTAL_ELAPSED_TIME/1000 AS DURATION_SECONDS,
    ROWS_INSERTED,
    ROWS_UPDATED,
    EXECUTION_STATUS
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
WHERE QUERY_TEXT LIKE '%SP_FACT_PATTERN_LOAD%'
    AND EXECUTION_STATUS = 'SUCCESS'
ORDER BY START_TIME DESC
LIMIT 20;
```

## Performance Considerations

- The procedure uses temporary tables for staging
- Indexes on dimension tables improve join performance
- Consider adding appropriate WHERE clauses to limit data volume
- For large date ranges, consider breaking into smaller batches
- Monitor warehouse sizing based on data volume

## Future Enhancements

Potential improvements:
- Add incremental loading logic (only new/changed records)
- Implement SCD Type 2 handling for dimension changes
- Add data quality checks and validations
- Create audit logging table for execution history
- Add parameters for different load strategies (full, incremental, etc.)
- Implement error handling with retry logic

