select system$get_dbt_log('01c822ca-000e-2453-0002-e34200046f5a');


execute dbt project from workspace "USER$"."PUBLIC"."dbt-core" args='compile --target dev' ENVIRONMENT='dev';

create warehouse dbt_vw;