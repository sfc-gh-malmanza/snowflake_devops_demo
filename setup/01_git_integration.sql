-- ============================================================================
-- Setup: Snowflake Git Integration
-- Description: One-time setup to connect Snowflake to your GitHub repository
-- Run this manually once per environment (DEV and PROD)
-- ============================================================================

-- Step 1: Create a secret to store GitHub Personal Access Token (PAT)
-- Replace 'your_github_pat' with your actual PAT
CREATE OR REPLACE SECRET git_secret
  TYPE = password
  USERNAME = 'your_github_username'
  PASSWORD = 'your_github_pat';

-- Step 2: Create API integration for GitHub
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-malmanza/')
  ALLOWED_AUTHENTICATION_SECRETS = (git_secret)
  ENABLED = TRUE;

-- Step 3: Create Git repository object pointing to your repo
CREATE OR REPLACE GIT REPOSITORY snowflake_devops_repo
  API_INTEGRATION = git_api_integration
  GIT_CREDENTIALS = git_secret
  ORIGIN = 'https://github.com/sfc-gh-malmanza/snowflake_devops_demo.git';

-- Step 4: Verify the setup
SHOW GIT REPOSITORIES;

-- Step 5: Fetch the repository
ALTER GIT REPOSITORY snowflake_devops_repo FETCH;

-- Step 6: List files to verify
LS @snowflake_devops_repo/branches/main/;

SELECT 'Git integration setup complete!' AS STATUS;

