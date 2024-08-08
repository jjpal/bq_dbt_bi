<!--

Welcome to the Greenery dbt project!
### Using the starter project

Try running the following commands:
- dbt run
- dbt test
-->

### dbt Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

- dbt init: Initializes a new dbt project.

- dbt run: Runs all models within the project.

        To run a single model: dbt run --select stg_reviews.sql

- dbt deps: Install and download [dbt packages](https://hub.getdbt.com/) dependencies listed in the packages.yml file.

- dbt seed: Loads csv files found in the seed-paths defined in the dbt_project.yml file.

- dbt test: Tests all tests within the project.

- dbt build: dbt run + dbt test + dbt snapshot + dbt seed (in DAG order).

- dbt docs generate: to generate the documentation for the project. 

- dbt snapshot: Executes snapshots in the snapshots-paths defined in the dbt_project.yml file.


Troubleshooing commands
dbt compile 
dbt debug 


 <!--- 
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you 
-->
