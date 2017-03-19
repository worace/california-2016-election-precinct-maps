select pct16, st_asgeojson(geog)
from precincts
where st_intersects(geog,
                    st_point(-118.384692, 34.023018)::geography);

select pres_clinton,
       pres_trump,
       pres_johnson,
       pres_stein,
       pres_lariva,
       pres_other
from results
join precincts
on results.pct16 = precincts.pct16
where st_intersects(geog,
                    st_point(-118.384692, 34.023018)::geography);

select count(*)
from districts
where statefp = '06';

-- CA District 25
select st_asgeojson(geog)
from districts
where statefp = '06'
and cd114fp = '25';

-- CA 25 Precincts
select count(*)
from precincts
join districts
on st_intersects(districts.geog, precincts.geog)
where statefp = '06'
and cd114fp = '25';

select count(*)
from precincts p
join districts d
-- on districts.geog && precincts.geog
on st_intersects(p.geog, d.geog)
where statefp = '06'
and cd114fp = '25'
and d.geog && p.geog;

select st_asgeojson(geog) from (
select p.*
from precincts as p,
(select geog from districts where statefp = '06' and cd114fp = '25') as d
where p.geog && d.geog
) as bounding limit 1;


create table ca25_precincts AS
select p.*
from precincts p
join districts d
on st_intersects(p.geog, d.geog)
where statefp = '06'
and cd114fp = '25'
and d.geog && p.geog;

select r.pct16, pres_clinton_per, pres_clinton, pres_trump from results r
inner join ca25_precincts p
on r.pct16 = p.pct16
order by pres_clinton_per desc limit 5;

select r.pct16,
       pres_clinton,
       pres_trump,
       pres_clinton_per,
       pres_trump_per,
       pres_lariva,
       (r.pres_trump + r.pres_clinton) as total
from results r
inner join ca25_precincts p
on r.pct16 = p.pct16
where (r.pres_trump + r.pres_clinton) > 1000
-- Rough way to get districts in santa clarita
and st_dwithin(st_point(-118.554723, 34.389804)::geography, p.geog, 10000)
order by pres_lariva
desc limit 2;
