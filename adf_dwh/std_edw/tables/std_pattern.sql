-- ============================================================================
-- Table: STD_PATTERN
-- Description: Standard pattern definitions and configurations
-- Type: Reference Table
-- Environment: {{ environment }}
-- ============================================================================
CREATE OR ALTER TABLE {{ environment }}_ADF_DWH.STD_EDW.STD_PATTERN (
    STD_PATTERN_KEY INT AUTOINCREMENT NOT NULL COMMENT 'Surrogate key for standard pattern',
    STD_PATTERN_ID VARCHAR(50) NOT NULL COMMENT 'Natural key - Standard pattern identifier',
    STD_PATTERN_NAME VARCHAR(200) NOT NULL COMMENT 'Name of the standard pattern',
    STD_PATTERN_CODE VARCHAR(20) COMMENT 'Short code for the pattern',
    
    -- Pattern Classification
    PATTERN_CATEGORY VARCHAR(100) COMMENT 'Category of pattern',
    PATTERN_TYPE VARCHAR(50) COMMENT 'Type or classification',
    PATTERN_FAMILY VARCHAR(100) COMMENT 'Pattern family grouping',
    
    -- Standard Specifications
    DESCRIPTION TEXT COMMENT 'Detailed description of the pattern',
    SPECIFICATIONS TEXT COMMENT 'Technical specifications',
    STANDARD_CYCLE_TIME DECIMAL(18,2) COMMENT 'Standard cycle time in seconds',
    TOLERANCE_UPPER DECIMAL(18,2) COMMENT 'Upper tolerance limit',
    TOLERANCE_LOWER DECIMAL(18,2) COMMENT 'Lower tolerance limit',
    TARGET_QUALITY_SCORE DECIMAL(5,2) COMMENT 'Target quality score (0-100)',
    TARGET_EFFICIENCY DECIMAL(5,2) COMMENT 'Target efficiency percentage',
    
    -- Requirements and Constraints
    MACHINE_REQUIREMENTS TEXT COMMENT 'Required machine specifications',
    SKILL_LEVEL_REQUIRED VARCHAR(50) COMMENT 'Required operator skill level',
    CERTIFICATION_REQUIRED VARCHAR(200) COMMENT 'Required certifications',
    MATERIALS_REQUIRED TEXT COMMENT 'Required materials and quantities',
    TOOLS_REQUIRED TEXT COMMENT 'Required tools and equipment',
    
    -- Version Control
    VERSION VARCHAR(50) COMMENT 'Pattern version',
    REVISION_NUMBER INT COMMENT 'Revision number',
    EFFECTIVE_DATE DATE COMMENT 'Date pattern becomes effective',
    EXPIRATION_DATE DATE COMMENT 'Date pattern expires',
    SUPERSEDED_BY VARCHAR(50) COMMENT 'ID of pattern that supersedes this one',
    
    -- Approval and Compliance
    APPROVED_BY VARCHAR(200) COMMENT 'Name of approver',
    APPROVAL_DATE DATE COMMENT 'Date of approval',
    COMPLIANCE_STANDARDS TEXT COMMENT 'Relevant compliance standards',
    SAFETY_NOTES TEXT COMMENT 'Safety considerations and notes',
    
    -- Status
    IS_ACTIVE BOOLEAN DEFAULT TRUE COMMENT 'Flag indicating if pattern is currently active',
    IS_CERTIFIED BOOLEAN DEFAULT FALSE COMMENT 'Flag indicating if pattern is certified',
    STATUS VARCHAR(50) COMMENT 'Current status (Draft, Active, Deprecated, etc.)',
    
    -- Metadata
    CREATED_BY VARCHAR(200) COMMENT 'User who created the pattern',
    CREATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record creation timestamp',
    UPDATED_BY VARCHAR(200) COMMENT 'User who last updated the pattern',
    UPDATED_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Record update timestamp',
)
COMMENT = 'Standard pattern definitions for {{ environment }} environment';
