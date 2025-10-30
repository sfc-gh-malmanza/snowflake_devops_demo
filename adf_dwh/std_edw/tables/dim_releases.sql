-- ============================================================================
-- Table: DIM_RELEASES
-- Description: Release dimension table with product release information
-- Type: Dimension (SCD Type 2)
-- Environment: {{ environment }}
-- ============================================================================

CREATE OR ALTER TABLE {{ environment }}_ADF_DWH.STD_EDW.DIM_RELEASES (
    RELEASE_KEY INT AUTOINCREMENT NOT NULL COMMENT 'Surrogate key for release dimension',
    RELEASE_ID VARCHAR(50) NOT NULL COMMENT 'Natural key - Release identifier',
    RELEASE_NAME VARCHAR(200) NOT NULL COMMENT 'Name of the release',
    RELEASE_CODE VARCHAR(20) COMMENT 'Short code for the release',
    RELEASE_VERSION VARCHAR(50) COMMENT 'Version number or identifier',
    RELEASE_TYPE VARCHAR(50) COMMENT 'Type of release (Major, Minor, Patch, Hotfix)',
    PRODUCT_NAME VARCHAR(200) COMMENT 'Name of the product being released',
    PRODUCT_LINE VARCHAR(100) COMMENT 'Product line or family',
    RELEASE_DATE DATE COMMENT 'Planned or actual release date',
    START_DATE DATE COMMENT 'Development start date',
    END_DATE DATE COMMENT 'Development end date',
    STATUS VARCHAR(50) COMMENT 'Current status (Planning, Development, Testing, Released, etc.)',
    PRIORITY VARCHAR(20) COMMENT 'Priority level (Critical, High, Medium, Low)',
    RELEASE_MANAGER VARCHAR(200) COMMENT 'Name of release manager',
    DESCRIPTION TEXT COMMENT 'Description of the release',
    RELEASE_NOTES TEXT COMMENT 'Release notes and change log',
    IS_ACTIVE BOOLEAN DEFAULT TRUE COMMENT 'Flag indicating if release is currently active',
    IS_DEPLOYED BOOLEAN DEFAULT FALSE COMMENT 'Flag indicating if release has been deployed',
    DEPLOYMENT_DATE DATE COMMENT 'Actual deployment date',
    ROLLBACK_DATE DATE COMMENT 'Date of rollback if applicable',
    AFFECTED_SYSTEMS TEXT COMMENT 'Systems affected by this release',
    DEPENDENCIES TEXT COMMENT 'Dependencies on other releases',
    CREATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record creation timestamp',
    UPDATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record update timestamp',
)
COMMENT = 'Release dimension table for {{ environment }} environment';
