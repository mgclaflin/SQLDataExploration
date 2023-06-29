use CovidData;


select *
from CovidDeaths$;


select location, date, total_cases, new_cases, total_deaths, population_density
from CovidDeaths$
where continent is not null
order by 1,2;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country 

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths$
where continent is not null
order by 1,2


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Looking at total cases vs population
-- shows ratio of infection to population density

select location, date, total_cases, population_density, (total_cases/population_density)*100 as InfectionRatio
from CovidDeaths$
where continent is not null
order by 1,2;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Looking at countires with highest infection rate compared top population density

select location, population_density, Max(total_cases) as HighestInfectionCount, Max((total_cases/population_density)) as InfectionRatio
from CovidDeaths$
where continent is not null
group by location, population_density
order by InfectionRatio desc;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Showing countries with the highest death rate compared to population density

select location, population_density, Max(CAST(total_deaths as int)) as HighestDeathCount, Max((cast(total_deaths as int)/population_density)) as DeathRatio
from CovidDeaths$
where continent is not null
group by location, population_density
order by DeathRatio desc;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Break down by continent
select location, Max(CAST(total_deaths as int)) as HighestDeathCount
from CovidDeaths$
where continent is  null
group by location
order by HighestDeathCount desc;


-- Global Numbers for cases by date

select date, sum(new_cases)
from CovidDeaths$
where continent is not null
group by date
order by 1,2;

-- total cases, deaths, and death percentage per day for the world
select date, sum(new_cases) as NewCases, sum(cast(new_deaths as int)) as NewDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from CovidDeaths$
where continent is not null
group by date
order by 1,2;


-- Total for the entire time range
select sum(new_cases) as NewCases, sum(cast(new_deaths as int)) as NewDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from CovidDeaths$
where continent is not null
order by 1,2;



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select *
from CovidDeaths$ cd
join CovidVaccinations$ cv
on cd.location = cv.location
and cd.date = cv.date;