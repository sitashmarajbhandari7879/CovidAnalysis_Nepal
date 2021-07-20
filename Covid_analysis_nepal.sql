SELECT *
FROM PortfolioProject..coviddeath
Where location = 'Nepal'
order by 3,4

--SELECT *
--FROM PortfolioProject..covidvaccination
--order by 3,4

--Selecting the data to work on

SELECT location, date, total_cases,new_cases,total_deaths,population
from PortfolioProject..coviddeath
order by 1,2

--Total cases vs Total Deaths
SELECT location, date, total_cases,total_deaths,population,(total_deaths / total_cases)*100 as Death_by_percentage
from PortfolioProject..coviddeath
where location like '%Nepal%'
order by 1,2

--Total cases vs Population
SELECT location, date,population, total_cases,total_deaths,(total_cases / population)*100 as Percentage_of_cases
from PortfolioProject..coviddeath
where location like '%Nepal%'
order by 1,2


-- Hightest infection with respective to population for each country
SELECT location,population, Max(total_cases) as Highest_Infection_Count,Max(total_cases / population)*100 as Percentage_of_cases
from PortfolioProject..coviddeath
Group by location,population
order by 1,2

---- Hightest infection with respective to population for Nepal
SELECT location,population, Max(total_cases) as Highest_Infection_Count,Max(total_cases / population)*100 as Percentage_of_cases
from PortfolioProject..coviddeath
where location like '%Nepal%'
Group by location,population


--
-- Highest infection with respective to population for all country in des order
SELECT location,population, Max(total_cases) as Highest_Infection_Count,Max(total_cases / population)*100 as Percentage_of_cases
from PortfolioProject..coviddeath
Group by location,population
order by Percentage_of_cases desc


--- Highest death count
SELECT location,population, Max(cast (total_deaths as int)) as Death_count,Max(total_deaths/population) as death_per_population
from PortfolioProject..coviddeath
Where continent is not null
Group by location,population
order by Death_count desc

--Highest death count per continent
SELECT continent, Max(cast (total_deaths as int)) as Death_count
from PortfolioProject..coviddeath
where continent is not null
Group by continent
order by Death_count desc


--Total number of cases and Total number of death per day
SELECT date, sum(cast(new_deaths as int)) as totalDeath, sum(new_cases) as TotalCase,sum(cast (new_deaths as int))/sum(new_cases)*100 as DeathPerCase
from PortfolioProject..coviddeath
where continent is not null
Group by date
order by 1,2

--Total number of cases and Total number of death in the world
SELECT sum(cast(new_deaths as int)) as totalDeath, sum(new_cases) as TotalCase,sum(cast (new_deaths as int))/sum(new_cases)*100 as DeathPerCase
from PortfolioProject..coviddeath
where continent is not null
order by 1,2

--Number of vaccination per population

--using common table expression

With PopulationVsVac (Continent, Location, Date,Population,New_vaccination,VaccinatedNumber) as
(
Select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations ,sum(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location,dea.date) as VaccinatedNumber
from PortfolioProject..covidvaccination as vac
join PortfolioProject..coviddeath as dea
	on dea.location = vac.location 
where dea.continent is not null
)
Select * from PopulationVsVac

drop view Asia_data

--creating view for visualization
Create View Asia_data as
Select dea.location,dea.population,Max(dea.total_cases)as totalCase,Max(convert(bigint,dea.total_deaths))as totalDeath,max(convert(bigint,vac.total_vaccinations)) as total_vaccinated
from PortfolioProject..coviddeath dea 
Join PortfolioProject..covidvaccination vac
on dea.location = vac.location
and dea.iso_code = vac.iso_code
where dea.continent = 'Asia'
Group by dea.location,dea.population


Create View Africa_data as
Select dea.location,dea.population,Max(dea.total_cases)as totalCase,Max(convert(bigint,dea.total_deaths))as totalDeath,max(convert(bigint,vac.total_vaccinations)) as total_vaccinated
from PortfolioProject..coviddeath dea 
Join PortfolioProject..covidvaccination vac
on dea.location = vac.location
and dea.iso_code = vac.iso_code
where dea.continent = 'Africa'
Group by dea.location,dea.population




