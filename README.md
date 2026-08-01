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

**Rationale:**

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

**Rationale:**

### Loading:
**Type:** Batch processing

**Load:** Full load > TRUNCATE & INSERT

**SCD:** Type 1

**Rationale:**




