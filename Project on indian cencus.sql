# total population
Select sum(population) from datatwo;



# Average literacy rate
Select round(avg(Literacy), 2) from dataone;



# district, state and literacy rate for the districts in that the population is above 1 million
select d.district, d.state, d.literacy from dataone d inner join datatwo t
on d.district = t.district
where t.population>1000000;



# select district, state and sex ratio in that the literacy rate above 80%
select district, state, sex_ratio from dataone 
where literacy>80;



# select district, state, total population for all districts from table one
select sum(datatwo.population), dataone.district, dataone.state from dataone inner join datatwo
on dataone.district = datatwo.district
group by dataone.district, dataone.state
order by dataone.state;



# calculation of population for each state
select sum(d.population), d.state from datatwo d inner join dataone t
on d.district = t.district
group by d.state;



 # top 5 states with highest population
 select max(population), state from datatwo
 group by state
 limit 5;
 
 
 
 # districts with literacy rate above 80% and population more than one million
 select d.district, t.population, d.literacy from dataone d inner join datatwo t
 on d.district = t.district
 where d.literacy>80 AND t.population>1000000;
 
 
 
 # top 5 states with lowest population
select min(population), state from datatwo
 group by state
 order by min(population) desc
 limit 5;
 
 
 
# top 3 state with highest growth rate
select max(growth)*100 AS "Top growing state", state from dataone
group by state
order by max(growth) desc
limit 3;



# name of state beginig with the a
select distinct(state) from dataone
where state like "a%";




# number of males and females
SELECT c.district, c.state, round(c.population/(c.sex_ratio+1),0) AS males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) AS females
FROM (
  SELECT a.district, a.state, a.sex_ratio/1000 AS sex_Ratio, b.population
  FROM dataone a
  INNER JOIN datatwo b ON a.district = b.district
) c;




# number of literate and illetrate people
select a.district, a.state, round((a.literacy_rate*a.population),0) AS literate, round((1-a.literacy_rate),2)*a.population as illetrate from 
(select d.district, d.state, d.literacy/100 as literacy_Rate, p.population from dataone d inner join datatwo p
on d.district = p.district) a;



#sum of census in last and current year
select d.state, sum(d.last_year_census_population), sum(current_census_population) from
(select c.district, c.state, round(c.population/(1+c.growth), 0) AS last_year_census_population, c.population current_census_population from
(select a.district, a.state, a.growth as growth, b.population from dataone a inner join datatwo b
on a.district = b.district) c) d
group by d.state;




# top 3 states with highest literacy rate
select a.*from
(select district, state, literacy, rank() over(partition by state order by literacy) AS "Rank" from dataone) a
where a.rank in (1,2,3);



