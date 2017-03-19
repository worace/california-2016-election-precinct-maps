## Data Sources

* Precinct results - from datadesk repo (`all_results.csv`)
* Precinct geographies - from datadesk repo (`merged.shp`)

### 114th Congress Districts

Downloaded from US Census Data site

```
wget -P postgis/data/c114_districts ftp://ftp2.census.gov/geo/tiger/TIGER2015/CD/tl_2015_us_cd114.zip
```

### Census Tract Geographies

```
wget -P postgis/data/2010_census_tracts https://www2.census.gov/geo/tiger/TIGER2010/TRACT/2010/tl_2010_06_tract10.zip
```

### Census Tract Demographic Data

```
wget -P postgis/data/2010_census_tract_demographics https://www2.census.gov/census_2010/03-Demographic_Profile/California/ca2010.dp.zip
```

(~1GB file:)

```
wget -P postgis/data/ca_summary_file https://www2.census.gov/census_2010/04-Summary_File_1/California/ca2010.sf1.zip
```
