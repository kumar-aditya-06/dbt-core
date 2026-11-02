select system$get_dbt_log('01c822ca-000e-2453-0002-e34200046f5a');


execute dbt project from workspace "USER$"."PUBLIC"."dbt-core" args='compile --target dev' ENVIRONMENT='dev';

------------- external packages -----------
CREATE OR REPLACE NETWORK RULE dbt_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('hub.getdbt.com', 'codeload.github.com');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION dbt_ext_access
  ALLOWED_NETWORK_RULES = (dbt_network_rule)
  ENABLED = TRUE;

GRANT USAGE ON INTEGRATION dbt_ext_access TO ROLE ACCOUNTADMIN;

ALTER DBT PROJECT "dbt-core" add  EXTERNAL_ACCESS_INTEGRATIONS = (dbt_ext_access);

---- now we can use or execute dbt deps too ..
/*
select {{ dbt_utils.generate_surrogate_key(['col1', 'col2']) }} as sk
from {{ ref('my_model') }}
*/