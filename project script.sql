WITH HourlyDeviations AS (
SELECT timestamp, region_id, solar_mw + wind_mw AS total_renewables_mw,
fossil_backup_mw, grid_demand_mw,
 AVG(grid_demand_mw) OVER(PARTITION BY region_id ORDER BY
timestamp ROWS BETWEEN 168 PRECEDING AND CURRENT ROW) 
as rolling_avg_demand FROM
energy_timestamp) 
SELECT region_id, COUNT(*) as critical_hours
 FROM HourlyDeviations 
GROUP BY region_id