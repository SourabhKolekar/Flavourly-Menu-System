## Flavourly Digital Menu System 
This is a small application to retrieve restaurant menus and related data. It fetches the menu of active stores and  
saves it in the json file. The accompanying awsLambdaHandler can be deployed to AWS env after some changes in the 
configuration. 

### Setup
- Language Used: Java (JDK 17)
- Build System: Maven
- IDE: IntelliJ IDEA
- Test: JUnit5, Mockito
- Database: MySQL (Local currently - script attached which can be deployed to the RDS and used with the lambda)
- AWS Lambda: Integrated for cloud execution
- AWS SDK: For Lambda deployment and execution

### Project Structure
The project follows a modular structure with clear separation of concerns. The directories are organized as follows:

- `src/main/java`
  - `org.example.dao`: Contains `RestaurantInterface` and its implementation `RestaurantInterfaceImpl`, which interact with the database to fetch restaurant details. 
  - `model`: Contains database models and response models like RestaurantResponse and MenuResponse.
  - `service`: Contains RestaurantService, which orchestrates the business logic for fetching restaurant menus.
  - `utils`: Contains utility classes like DatabaseUtil (for database connections), JsonWriter (for writing data to 
    JSON files), and MenuBuilder (for constructing menu responses).
  - `main.java`: Contains the entry point Main.java to run the application locally with command-line interaction and 
    JSON file output.
  - `RestaurantMenuHandler.java`: The AWS Lambda handler that enables the function to run in the AWS Cloud. It 
    interfaces with AWS Lambda, receives requests, and sends responses.
- `src/test/java`
  - `integration`: Contains integration tests like `RestaurantServiceIntegrationTest`, which tests the full flow of the API, including database interactions.
  - `unit`: Contains unit tests for individual components like MenuBuilderTest, RestaurantInterfaceImplTest, and 
    RestaurantServiceTest.

### Other information
`/miscellaneous` directory contains few additional things
- `Flavourly ER Diagram`: This is an ER diagram to show the relationships between tables in the database.
- `FlavourlyMenuSystem-fatjar.jar` : executable JAR for local execution which can be executed with

`java -jar miscellaneous/FlavourlyMenuSystem-fatjar.jar`

(`note`: it'll try to connect with local mysql instance with the
credentials as `user: root` and `password: root@1234` if needed to provide new credentials please perform `mvn clean 
package` after altering the database credentials in `DatabaseUtil.java` and delete the `MenuBuilderTest.java` and
`RestaurantInterfaceImplTest.java` from unit tests (Because of mocking limitations of Mockito)).

- `/Results`: Contains the sample JSON menu output along with the screenshots of the executed application.
- Unit tests files of `MenuBuilderTest.java` and `RestaurantInterfaceImplTest.java`. I have added them here for
  evaluation purposes as while performing `mvn clean package`, these two files give error related to unable to mock
  the database functions since Mockito does not mock System interfaces and classes.

  
#### AWS Lambda Integration
The project includes an AWS Lambda handler (RestaurantMenuHandler) designed to run the menu fetching logic in the cloud. This handler interfaces with AWS API Gateway or other Lambda invocation sources to process the requests. The Lambda function is designed to process the input restaurant ID and return the menu data as a JSON response. The Lambda handler follows the standard AWS Lambda execution model and leverages the existing business logic in RestaurantService and RestaurantInterfaceImpl to retrieve and process data from the database.
While the Lambda function is written, it has not been deployed to AWS yet. It'll need additional configuration 
including database that can be accessible via internet(RDS can be great option). 

### MySQL Configuration
The directory `MySQL` contains the scripts for creation of above tables with the relations and population of the data.
It contains two scripts:
- `Definition.sql`: It contains the tables creation script which applies relationships between tables as well.
- `Data.sql`: Contains the dataset for all the tables which can be used for the application.
  As per the local configuration of the MySQL, please update the `USER`, `PASS` variables defined in the `DatabaseUtil.
  java` in `/utils` Directory.

OR there's `flavourly_menu_db-dump.sql` which is generated using mysqldump utility. Executing that sql file or
importing the SQL file will create and populate the database and tables.

### Database Structure
Database: MySQL 
currently using local mysql instance and for production ready application, further this can be moved to AWS RDS 
mysql instance.

Tables: The project contains multiple tables as per the requirement along with some additional tables that can 
be used for further enhancement of the application. The tables provided in the script are as follows:
- `Restaurant`: Contains information about the restaurants which contains the menu.
- `Restaurant_Hours`: Contains information about restaurant open, close times of the week.
- `Menu`: Contains the information about the menu e.g. Breakfast, Lunch, Dinner etc.
- `Menu_Category`: Contains category information like Appetizers, Main Course, Starters etc. which depends on the 
  restaurant's category definition which can change as per restaurant.
- `Menu_Item`: Contains actual menu item like Churros, Paneer Tikka Masala, Nachos etc. This contains all the 
  information like price, allergens, spice_level and tags related to the menu item.
These tables are used for the for fetching restaurant and menu details.

Along with this, additional tables are provided which can be useful in the further enhancement of the application 
(they are no operations currently that depend on these tables), which are as follow:
- `User`: Contains information about the users that will use the system. 
- `Audit_Log`: Contains information about the actions like inserting new data, updating/removing current 
  data which are performed in the database for auditing purposes. 
- `Menu_Item_Feedback`: Feedback for the Users/Customers on the specific menu_item for enhancement.
 
The database configuration is managed using DatabaseUtil.java, which uses JDBC to connect to the MySQL database. The 
current configuration in code is Local with local mysql instance credentials which should be stored securely in 
AWS secret manager and fetched using environment variables or secret manager API. For our technical challenge 
purpose, local mysql instance is used.


### Running the Application
To run the application locally, follow these steps:

- Clone the repository and navigate to the project directory.
- Run the MySQL scripts provided in MySQL Directory as per the MySQL Configuration provided above.
- Install dependencies (Make sure you have Maven installed):
`mvn clean install`
- Run the application locally by executing the `Main.java` class:
`mvn exec:java -Dexec.mainClass="org.example.Main"`
This will allow you to interact with the application through the command line and output restaurant menu details to 
  a JSON file in the project directory.

OR

Execute the `FlavourlyMenuSystem-fatjar.jar` in `/miscellaneous` directory. It's an executable JAR for local execution 
which can be executed with

`java -jar miscellaneous/FlavourlyMenuSystem-fatjar.jar`

(`note`: it'll try to connect with local mysql instance with the
credentials as `user: root` and `password: root@1234` if needed to provide new credentials please perform `mvn clean 
package` after altering the database credentials in `DatabaseUtil.java` and an new fat jar gets created in `/target` 
directory.


### Run AWS Lambda locally:

You can use AWS SAM (Serverless Application Model) or the AWS Lambda runtime for local testing. The attached 
`template.yml` and `event.json` have the basic configuration provided. The Application will need database URL as 
local testing of AWS lambda cannot communicate with the Local MySql instance that we currently are using. So after 
moving the database to RDS and updating the database url in `DatabaseUtil.java` we can perform local testing of AWS 
Lambda.
- Make sure to have AWS SAM CLI installed in the system.
- perform `sam local invoke "RestaurantMenuHandler" -e event.json`


### Design Decisions
- **Separation of Concerns**: The application follows a modular approach with clear separation between the model, service,
and DAO layers. This ensures that the business logic and database interaction are separate, making the application easier to test and maintain.
- **Standard Java instead of Springboot Web application**: The application follows standard java project 
  practises opposed to Springboot web application that can provide the Restful api as this application is targeted 
  for lambda as we needed as much lightweight functionality as possible.
- **AWS Lambda**: The Lambda function is designed for scalable cloud execution. It processes incoming requests and 
  invokes the business logic to fetch restaurant menus dynamically from the database.
- **Database Integration**: The MySQL database schema was designed to support restaurants, menus, categories, and 
  items, ensuring flexibility in retrieving menus based on various conditions like active hours.

### Improvements & Future Enhancements
- Additional Error Handling: Add more detailed error handling for various failure scenarios, such as invalid restaurant 
  IDs, database connection issues, or missing data.
- Production ready Lambda Deployment: Integrate AWS Lambda deployment and testing into the CI/CD pipeline using AWS 
  CDK, github actions etc.
- Additional Logging: Implement additional logging for reporting purposes.
- Deploy to AWS: Complete the deployment process to AWS Lambda and integrate with API Gateway for real-world use.
- Performance Optimization: Profile and optimize the database queries and service layers for faster response times.
- Implementing whole CRUD operations which can utilize other tables and improve full functionality of 
  the application.
