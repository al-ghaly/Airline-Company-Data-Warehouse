# Airline Company Data Warehouse 
## Data Warehouse modeling, design, implementation, and analysis for an Airline Company.<br><br>
> ### This project is a real treasure for any one struggling to understand data warehouse concepts, modeling, design, implementation, data integration, or even SQL DML Statements, as it will walk you from square zero having nothing, into having a well-structured data warehouse, helping you along the side to understand all about data warehousing.
---
<br>

## The major purpose of the project is to model a data warehouse design that is able to help the management team make data-driven decisions.
### Those questions were stated before the design and we want to design a data warehouse that is able to answer all those questions and more.
![Questions](https://github.com/al-ghaly/Airline-Company-Data-Warehouse/assets/61648960/c7c5a788-b92c-4363-ae5b-35bf560ee007)
<br><br><br>

## With a good data warehouse model, we were able to answer all those questions and more with simple SQL Queries
### Here is a sample of the queries to see how simple it is to gain any kind of insights you want from the data warehouse.
![SQL 1](https://github.com/al-ghaly/Airline-Company-Data-Warehouse/assets/61648960/1ac0dc50-0796-4be0-957b-b73b71e1c12d)

## Even more complex analysis is easy with a good model
![SQL 2](https://github.com/al-ghaly/Airline-Company-Data-Warehouse/assets/61648960/2db1d74f-ef56-438a-8f92-058b9c03aabd)

<br>

---

> ### The project is implemented in SQL SERVER Database, and I have attached both the DWH creation & Data population scripts, but for simplicity I have also attached a backup file of the data warehouse, you can restore it in SQL Server Management Studio.

---
<br>

**Let’s start what we will do:**
- First, I will do my research to understand how airline companies work and what are
the main business processes we are interested in analyzing.
- Then, I will gather some of the questions that we need our model to answer.
- Then we will dive into the modeling process, defining the dimensions, facts,
measurements, granularity, sparsity, and summarizability issues for our model.
- Next step will be designing the schema for our model.
- Then I will collect some data to populate into the data warehouse.
- Next step, I will integrate the data into the database (SQL SERVER Database).
- Before diving into the analysis, I will spend some time talking about indexes.
- The last step is what we are doing all those steps for, which is analyzing the data
warehouse and getting interesting insights to help the Management Team make
data-driven decisions.
---
<br>

**In the project files you will see some files:**
- **Project Documentations.pdf:** The project's documentations.
- **DWH Schema.png:** The schema for our data warehouse model.
- **DWH Tables.xlsx:** The dimensions / facts / indexes of the data warehouse.
- **DWH Creation.SQL:** The SQL Scripts for creating the data warehouse tables.
- **Schema.pdf:** The schema for our data warehouse generated from SQL SERVER.
- **Tables' Populations:** The SQL Scripts to poulate the data into the tables.
- **DWHProjAirlineCom.bak:** Backup of the data warehouse, you can restore it using SQL Server Management Studio.
- **Insights.SQL:** The SQL Queries used to gain insights and answer questions from the data warehouse.
<br>

#### The Project Documentations file includes:
- Each step we have done throughout the project 
- **DWH Schema:** The data warehouse model.
- **DWH Tables:** The dimension & Fact tables design for the data warehouse.
- **Questions:** We want the data warehouse to answer.
- **Database Tuning Intro:** A little brief about indexes.
- **INSIGHTS:** Some insights we used the data warehouse to get and some questions we answered.
- All insights are illustrated.

<br>

>**The modeling process for each business process of the 4 modeled processes is stated in the project docs (“Project Documentations.pdf” file):**
  -  STEP ONE:<br>
     o Stating the business processes.
  -  STEP THREE:<br>
     o Choosing the grain for each process.
  -  STEP FIVE:<br>
     o Choosing Facts & Dimensions.
  -  STEP SEVEN:<br>
     o The actual schema design.<br><br>

>The logical schema design is stated in STEP SEVEN and in a separate “DWH Schema.PNG” file, STEP EIGHT is stating why we choose a star schema model, details about each component in the star schema are also stated in STEP EIGHT, and details about each component in our design is stated along with the actual component.

> 14 Business Questions are answered with 25 SQL Statements in STEP TWELVE along with the output for each statement (Questions were stated in STEP TWO before we made the design, then we made a design that was able to answer all those questions and way more).
  
