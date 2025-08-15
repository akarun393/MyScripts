<!-- Start Document Outline -->

* [Kusto Query Language (KQL)](#kusto-query-language-kql)
	* [Where KQL is used](#where-kql-is-used)
	* [Tabular Expression](#tabular-expression)
	* [Control Commands](#control-commands)
	* [How to use KQL](#how-to-use-kql)
	* [KQL Query Structure](#kql-query-structure)
		* [1. TableName](#1-tablename)
		* [2. Filtering data](#2-filtering-data)
		* [3. Aggregating data](#3-aggregating-data)
		* [4. Ordering data](#4-ordering-data)
		* [5. Modify column output](#5-modify-column-output)

<!-- End Document Outline -->



# Kusto Query Language (KQL)

Kusto Query Language is a powerful tool to explore your data and discover patterns, identify anomalies and outliers, create statistical modeling, and more.

A Kusto query is a read-only request to process data and return results. Kusto
queries are made of one or more query statements.


There are three kinds of query statements.
* tabular expression statement.
* let statement
* set statement

All query statements are separated by a ; (semicolon)

## Where KQL is used

* KQL (Kusto Query Language) is a versatile tool widely adopted across Azure.
* Over 150 service spanning applications, IaaS workloads, infrastructure, and the Azure platform can stream their data to Azure Monitor, all queryable using KQL.
* Additionally, you can integrate custom log sources from on-premises environments or other cloud platforms for comprehensive analysis.
* Remember, KQL is **case-sensitive**.
* Some of the Azure data sources where KQL can be used 

1. App services
2. Azure Arc
3. Azure Stack
4. Desktop virtualization
5. Firewalls
6. Azure Front Door
7. Key Vaults
8. Storage accounts
9. SQL databases, managed instances, and servers.

## Tabular Expression
* The most common kind of query statement is a tabular expression statement, which
means both its input and output consist of tables or tabular datasets.
* Tabular statements contain zero or more operators, each of which starts with a
* tabular input and returns a tabular output.
* Operators are sequenced by a | (pipe).


## Control Commands
* In contrast to Kusto queries, Control commands are requests to Kusto to process or modify data or metadata.
* Not all control commands modify data or metadata.
* Where ever you see . (dot) at starting, it is control command.
* For example, the .show tables command returns a list of all tables in the current database.

## How to use KQL
* ***Kusto.Explorer*** is a rich desktop application that enables you to explore your data using the Kusto Query Language in an easy-to-use user interface.
* To Install, navigate to https://aka.ms/ke
* Different Panels: Menu panel, Query Editor, Results Panel, Connections Panel, Work Folders Panel.
* The files are saved in kusto as .kql extension. 

## KQL Query Structure

A good pattern is to ask what we are looking for and when we are looking for it. Filtering based on time ranges is a great way to speed up your queries because you’ll often be parsing a lot of data. 

The KQL (Kusto Query Language) query structure you've provided follows a common pipeline pattern where data flows through a series of operations, each separated by the pipe (|) character. Here's a breakdown of each component:

```plaintext
TableName
| filtering data
| aggregating data
| ordering data
| modify column output
```
### 1. TableName
This is your starting point, specifying which table to query
***Example:*** StormEvents, SecurityEvent, Heartbeat

### 2. Filtering data
Reduces the dataset by applying conditions (where clauses)

**Common operators:**

`where` - filters rows based on conditions

`take/limit` - returns first N rows (for sampling)

> Example: | where EventID == 4624 (successful logons)

### 3. Aggregating data
Groups and summarizes data

**Common operators:**

`summarize` - creates aggregations with functions like count(), avg(), sum()

`join` - combines data from multiple tables

`make-series` - creates time series data

> Example: | summarize count() by State

### 4. Ordering data
Sorts the results

**Common operators:**

`sort by` (ascending)

`order by` (descending with desc)

> Example: | order by count_ desc

### 5. Modify column output
Adjusts what columns are shown and how

**Common operators:**

`project` - selects specific columns

`project-away` - removes specific columns

`extend` - creates new calculated columns

`rename` - changes column names

> Example: | project State, EventCount=count_
