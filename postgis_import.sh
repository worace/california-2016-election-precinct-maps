#!/usr/bin/env bash

DB_NAME="ca2016"

if psql -c "\l" | grep -q $DB_NAME
then
  echo "ca2016 db already exists, dropping to start from scratch..."
  psql -c "drop database $DB_NAME;"
fi
createdb $DB_NAME

# csvstack final-results/*-munged.csv > final-results/all_precinct_results.csv;

psql -d $DB_NAME -f ./schema.sql

# -I add index to the geog column
# -G use geography w/srid 4326 instead of geom
# -s -s 4326
shp2pgsql -I -G  shapefiles/merged.shp public.precincts | psql -d $DB_NAME

shp2pgsql -I -G  postgis/c114_districts/tl_2015_us_cd114.shp public.districts | psql -d $DB_NAME

# Using a ruby script to standardize the CSV columns
# So postgres won't break on missing columns
cat final-results/all_precinct_results.csv | \
  ./clean_csv_columns.rb | \
  psql -d $DB_NAME \
       -c "COPY results FROM STDIN DELIMITER ',' CSV HEADER;"


# psql -d $DB_NAME -c "cluster precincts using precincts_geog_idx;"
# psql -d $DB_NAME -c "cluster districts using districts_geog_idx;"
