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

		| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
+-------------------+         +---------------------+          +----------------------+		
|     users      	|         |     addresses       |          |       orders         |
+-------------------+         +---------------------+          +----------------------+
| user_id (PK)  	|  ------ | address_id (PK)     |  ---     | order_id (PK)        |
| first_name        |         | address             |     ---  | address_id (FK)      |
| last_name         |         | zipcode             |          | user_id (FK)         |
| email             |         | state		        |          | created_at           |
| phone_number      |         | country				|          | order_cost           |
| created_at	    |         +---------------------+          | shipping_cost        |
| address_id (FK) 	|        +---------------------+	       | order_total          |
| phone_number      |        |     promos           |  		   | tracking_id          |
+-------------------+        +----------------------+	       | shipping_service     |
       |                     | promo_id (PK)	    |  ------  | promo_id (FK)		  |
       |                     | discount             |          | estimated_delivery_at|
	   |					 | status 				|   	   | delivered_at         |
       |                     +----------------------+          | status               |
       |                                                       +----------------------+ 
       |                                                       				|
 - - - |																	|
 |	+------------------+         +---------------------+  		  +---------------------+ 
 |	|     events	   |         |      products       |          |    order_items      |     
 |	+------------------+         +---------------------+          +---------------------+
 |	| event_id (PK)    |	---  | product_id (PK)     |  ------  | order_id (PK)       |
 |	| session_id       |    |    | name                |          | product_id (FK)     |
 |	| user_id (FK)     |    |    | description         |          | quantity            |
 |	| page_url         |    |    | price               |          +---------------------+
 |	| created_at	   |    |    | inventory	       |                                 
 |	| event_type	   |    |	 +---------------------+ 
 |	| order_id         |    |    
 |	| product_id (FK)  |  ---                                    
 |	+------------------+                                                           
 |                                                                           
+---------------------+                                     
|    reviews      	  |                                     
+---------------------+                                     
| review_id (PK)      |   
| user_id (FK) 		  |                                     
| product_id (FK)     |                                     
| rating	          |                                     
| review		      |                                     
| review_date	      |                                     
+---------------------+                            



 <!--- 
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you 
-->
