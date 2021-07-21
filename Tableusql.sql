--Death by percentage for the entire world
Select SUM(new_cases) as Total_Cases, SUM(convert(int,new_deaths)) as Total_Deaths, SUM(convert(int,new_deaths))/SUM(new_cases)*100 as Death_By_Percentage
From PortfolioProjectTableu..coviddeath
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


--Death by percentage for Nepal
Select SUM(new_cases) as Total_Cases, SUM(convert(int,new_deaths)) as Total_Deaths, SUM(convert(int,new_deaths))/SUM(new_cases)*100 as Death_By_Percentage
From PortfolioProjectTableu..coviddeath
Where location like '%Nepal%' and continent is not null
--Group By date
order by 1,2
 
--Total death count of each continent without redundancy

Select location, SUM(convert(int, new_deaths)) as Total_death_count
From PortfolioProjectTableu..coviddeath
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by Total_death_count desc


--Percentage of infected population
Select Location, Population, date, MAX(total_cases) as Highest_Infection_Count,  Max((total_cases/population))*100 as Percent_Population_Infected
From PortfolioProjectTableu..coviddeath
Group by Location, Population, Date
order by Percent_Population_Infected desc

--Percentage of infected population in Nepal
Select Location, Population, MAX(total_cases) as Highest_Infection_Count,  Max((total_cases/population))*100 as Percent_Population_Infected
From PortfolioProjectTableu..coviddeath
--where location = 'Nepal'
Group by Location, Population

--percentage of infecvted population in the world
Select Location, Population, MAX(total_cases) as Highest_Infection_Count,  Max((total_cases/population))*100 as Percent_Population_Infected
From PortfolioProjectTableu..coviddeath
where location = 'Nepal'
Group by Location, Population


--Percentage of infected population in Nepal for each day

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProjectTableu..coviddeath
Where location like '%Nepal%'
Group by Location, Population, date
order by PercentPopulationInfected desc


