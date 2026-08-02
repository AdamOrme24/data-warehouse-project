# Medallion Data Warehouse Project

This project is personal project designed to explore the end-to-end management of a database through ETL of structured data, and the creation of a data warehouse that aligns with Medallion Architecture methodology. The output is three structured Star schemas that have been cleaned, standardized and tested, and can be queried reliably to produce data-driven insights when paired with business intelligence tools such as PowerBI or Tableau.

This project is heavily inspired by the **sql-data-warehouse-project** by [DataWithBaraa](https://github.com/DataWithBaraa/) and uses the source data from that project.

This project is licensed under the [MIT License](LICENSE).

## Data Architecture 🏗️

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.

<img width="1068" height="696" alt="image" src="https://github.com/user-attachments/assets/0f8ceb79-1dcd-4f33-8cb6-b0bc331b69a1" />



**Rationale:**

The Medallion Architecture was chosen as a result of the size (11 MB) and data types (.csv) of the combined dataset. Whilst a KIMBALL architecture is well-suited to Star schemas, it relies on fact and dimension tables consisting of numeric metrics, which did not appear in the data source adn I lacked context to create them, and descriptive context to produce a reliable Star schema. Furthermore, by skipping the creation of an Enterprise Data Warehouse (EDW), therein lies a risk to data integrity.

The Medallion structure followed the Bronze, Silver, Gold structure, ensuring the entire raw dataset was loaded into the bronze layer, a task which was completed as a full load due to the small data size, without any loss of data. Medallion is tailored for files and tables, with schema enforcement applied incrementally at the Silver and Gold stages.

One future improvement would be to define the project in the context of a specific end user, accounting for factors such as their role, industry, and technical proficiency, as a KIMBALL architecture is a good solution for 'classic' Business Intelligence, dashboarding, and projects requiring fast query responses for non-technical users and is built bottom-up; focusing on business processes to create dimensional star schemas that match how users naturally think about data.

Finally, the Medallion architecture is an architecture that allows the data to follow Separation of Concerns (SoC) methodology throughout its ETL cycle.

## ETL Method 📖

The ETL method for this project included actions for each stage of the process:

### Extraction:
**Type:** Full extraction

**Method:** Pull extraction

**Technique:** File parsing

**Rationale:** The full extraction was completed due to the limited size of the source dataset adn the lack of a requirement to maintain state tracking or monitor bandwidth during extraction. The pull extraction was chosen because it allows for easier error handling and isolation of extraction failures, as well as the fact that the source dataset is static and thus not affected by data-staleness. File parsing was used because the source dataset was stored entirely as .csv files. 

### Transformation:
Data enrichment, Data integration, Derived columns, Data normalisation & standardisation, Business rules and logic, Data aggregations

**Cleansing:** 

• Removal of duplicates

• Data filtering

• Handling missing data

• Handling invalid values

• Handling unwanted spaces

• Data type casting

• Outlier detection

**Rationale:** De-duplication helps to prevent key metrics being skewed and will save computational resources. Data filtering decreases the volume of scanned data, making downstream database queries and dashboard renders significantly faster. Missing data was handled with COALESCE and NULLIF operations to remove bad nulls. TRIM operations was used to handle poorly-formatted data. Statistical outliers were identified and removed by using WINDOW operations with CASE WHEN functions to find values more than 3 standard deviations from the mean.

### Loading:
**Type:** Batch processing

**Load:** Full load > TRUNCATE & INSERT

**SCD:** Type 1

**Rationale:**Processing data in massive blocks allows the SQL engine to optimize memory usage, disk I/O, and index updates much better than trickling rows one by one, furthermore, the server hosting the Data Warehouse is hosted in MS Azure, therefore, batch processing allows the cloud resource to be spun up and down immediately at the beginning and end of the process. The TRUNCATE & INSERT loading is used so any historical data corruption, deleted source records, or sync errors from previous days are automatically wiped out, and the pipeline avoids expensive MERGE or UPDATE logic, removing the need for complex key-matching code.
