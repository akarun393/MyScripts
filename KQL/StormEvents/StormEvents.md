<!-- Start Document Outline -->

* [Explore StormEvents Database](#explore-stormevents-database)
	* [1. getschema operator](#1-getschema-operator)
	* [2. Run StormEvents Table](#2-run-stormevents-table)
	* [3. take/limit Operator](#3-takelimit-operator)
	* [4. Count records in the table](#4-count-records-in-the-table)
	* [5. Where Operator](#5-where-operator)
	* [6. Find events that caused damage to crops.](#6-find-events-that-caused-damage-to-crops)
	* [7. Find events that caused damage to property/crops in Florida](#7-find-events-that-caused-damage-to-propertycrops-in-florida)
	* [8. Find events that caused most damage to property](#8-find-events-that-caused-most-damage-to-property)
	* [9. Find events involving wind that cost most damage to property](#9-find-events-involving-wind-that-cost-most-damage-to-property)
	* [10. Find events that caused damage to property in Florida in Q1 of 2007](#10-find-events-that-caused-damage-to-property-in-florida-in-q1-of-2007)
		* [1. Query Purpose](#1-query-purpose)
		* [2. Step-by-Step Execution](#2-step-by-step-execution)
			* [a. Data Source Selection](#a-data-source-selection)
			* [b. Time Filtering](#b-time-filtering)
			* [c. Damage and Location Filtering](#c-damage-and-location-filtering)
			* [d. Column Selection](#d-column-selection)
			* [e. Result Limiting](#e-result-limiting)

<!-- End Document Outline -->


# Explore StormEvents Database

Storm Events table contains data from old storms that happened in the United States in the year 2007.

## 1. *getschema* operator
* How do we know what’s available for querying in these tables?
* What data is stored in the StormEvents table?
* The most useful functions you can run when interacting with a new data source is getschema.
* This will produce a list of all the columns in the table and their data types.
![1.GetSchema](Image/1.GetSchema.png)


## 2. Run *StormEvents* Table

Entire table is executed, provides all the data from the table.

Query:
```plaintext
StormEvents
```
![StormEvents Table](Image/StormEvents_Table.png)

## 3. *take/limit* Operator
* The *take* operator or the *limit* operator will return a specific number of rows you specified without guaranteeing which records are returned.
* The *take* operator or the *limit* operator are functionally the same thing.
* There is no difference, and you can use whatever one you prefer.
* They do not guarantee consistency in the results. You can rerun the same query and likely see different results returned, even if the data set didn’t change.
* No sorting is performed on this data.

Query:

```plaintext
StormEvents
| take 5

StormEvents
| limit 5
```
![take limit operator](Image/take_limit_operator.png)

## 4. *Count* records in the table
Produce total count of the records in the table.

Query:
```plaintext
StormEvents
| count
```

## 5. *Where* Operator
* The where operator allows you to filter a table to the subset of rows that satisfy your expression.
* You will compare three main types of data: ***strings***, ***numeric/dates***, and what we’ll call “***is empty***”.

Query:
```plaintext
StormEvents
| where EventType == "Winter Storm"
```
![Where operator](Image/Where_operator.png)

## 6. Find events that caused damage to crops.
We can check the DamageCrops is greater than 0.

Query:
```plaintext
StormEvents
| where DamageCrops > 0
| take 10
```
![Damage Crops](Image/DamageCrops.png)

## 7. Find events that caused damage to property/crops in Florida

We can check the *DamageCrops* and *DamageProperty* is greater than 0.

Query:

```plaintext
StormEvents
| where DamageCrops > 0 and DamageProperty > 0
| where State == "FLORIDA"
```
![DamageCrops Property](Image/DamageCrops_Property.png)

## 8. Find events that caused most damage to property

Events that caused most damage to property, selecting top 5 rows.

Query:

```plaintext
StormEvents
| top 5 by DamageProperty desc
```
![DamageProperty 5rows](Image/DamageProperty_5rows.png)

## 9. Find events involving wind that cost most damage to property

Any events with word "wind" that cost most damage to property, selecting top 5 rows.

Query:

```plaintext
StormEvents
| where EventType has "wind"
| top 5 by DamageProperty desc
```
![DamageProperty wind](Image/DamageProperty_wind.png)

## 10. Find events that caused damage to property in Florida in Q1 of 2007

Query:

```plaintext
StormEvents
| where StartTime between (datetime(2007-01-01) .. datetime(2007-03-31))
| where (DamageProperty > 0) and (State == "FLORIDA")
| project StartTime, EventType, DamageProperty
| take 50
```
![DamageProperty Q1](Image/DamageProperty_Q1.png)

This query is analyzing storm events that caused property damage in Florida during the first quarter of 2007.

### 1. Query Purpose
The comment at the top explains this is looking for:

* Events causing property damage
* In Florida
* During Q1 2007 (January 1 - March 31)


### 2. Step-by-Step Execution
#### a. Data Source Selection
`StormEvents` - This selects the table containing storm event data as the source for the query.

#### b. Time Filtering
`| where StartTime between (datetime(2007-01-01) .. datetime(2007-03-31))`

* Filters events to only those that occurred between January 1, 2007 and March 31, 2007.
* The between operator is inclusive of both dates.

#### c. Damage and Location Filtering
`| where (DamageProperty > 0) and (State == "FLORIDA")`

* `DamageProperty > 0` ensures we only get events that caused some property damage.
* `State == "FLORIDA"` restricts results to Florida only.
* Combined with `and` means both conditions must be true.

#### d. Column Selection
`| project StartTime, EventType, DamageProperty`

Selects only these three columns for the output:

* `StartTime:` When the event occurred.
* `EventType:` What type of storm event it was.
* `DamageProperty:` Amount of property damage caused.

#### e. Result Limiting
`| take 50`

* Limits the output to the first 50 records that match all the criteria.
* This prevents returning potentially large result sets.



