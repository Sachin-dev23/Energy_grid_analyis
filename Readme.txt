# Smart Grid Energy Risk & Sustainability Analytics Dashboard

## 📊 Project Overview
This repository contains a full-stack data analytics project engineered to identify structural supply-demand risks, clean energy output variability, and operational grid strains. 

Using an anonymized grid telemetry dataset covering multiple distinct regions (`REG_NORTH`, `REG_SOUTH`, `REG_EAST`), this project demonstrates a modern data pipeline workflow: extracting and transforming messy time-series data using **SQL**, engineering reliability metrics, and presenting interactive, executive-ready insights inside a dynamic **Microsoft Excel** dashboard interface.

---

## 🛠️ Tech Stack & Skills Demonstrated
*   **Data Engineering & Transformation:** SQL (Common Table Expressions (CTEs), String Parsing, Conditional Logic, Window Functions).
*   **Analytics & Business Intelligence:** Microsoft Excel (Power Query, Pivot Tables, Interactive Cross-Filtering Slicers).
*   **Core Concepts:** Telemetry Data Cleaning, Infrastructure Deficit Modeling, Capacity Optimization, Renewable Energy Tracking.

---

## 💻 Phase 1: SQL Data Engineering & Cleaning Layer

The raw telemetry logs presented structural formatting issues, specifically irregular decimal values within the timestamp text strings (e.g., `01-09-2026 14.00`). The production script below handles data extraction, rounds and parses operational hour indices, maps external temperature conditions into descriptive classifications, and extracts metrics like net load deficits.

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
```

---

## 📊 Phase 2: Excel Executive Dashboard Framework

The output from the SQL data layer was connected directly to Microsoft Excel via **Power Query**, building a data model structured around the following design parameters:

### 1. Executive Key Performance Indicators (KPIs)
*   **Total Grid Strain Incidents:** 789 critical events flagged across all nodes.
*   **Grid Strain Incident Rate (78%):** Proves that the overwhelming majority of operating hours run at razor-thin capacity margins.
*   **Renewable Energy Penetration (13%):** Measures the true percentage of gross customer demand satisfied by green alternatives (Solar/Wind).
*   **Fossil Fuel Backup Capacity (96.73%):** Highlights near-total reliance on traditional combustion infrastructure during stress peaks.

### 2. Analytical Visualizations
*   **Supply vs. Demand Combo Graph:** A dual-axis column and line chart mapping average grid demand against actual solar/wind output over a 24-hour cycle. It visually validates the 100% incident rate spike occurring directly between 18:00 and 21:00 as solar input decays.
*   **Regional Sustainability Matrix:** A stacked bar chart aggregating green assets by geography. It isolates `REG_SOUTH` as the primary wind provider and `REG_NORTH` as the dominant solar producer.
*   **Dynamic Control Panel:** Integrated cross-filtering slicers mapped to `region_id` and `weather_tier` to instantly isolate operational performance during severe heat anomalies.

---

## 📈 Strategic Business Insights Uncovered
1.  **The Solar Eclipse Window:** A severe operational gap systematically manifests during evening peak demand periods (18:00 to 21:00). As industrial/residential usage spikes, solar capacity drops to zero, forcing the grid into immediate over-reliance on backup combustion units.
2.  **Asset Distribution Vulnerability:** While `REG_SOUTH` boasts high wind generation, it remains isolated. In contrast, `REG_NORTH` requires substantial transmission infrastructure improvements to support its steep peak-hour cooling demand during periods of extreme heat.

---

## 📁 Repository Structure
*   `/sql_scripts/grid_clean_transformation.sql` - Main data processing script containing metric calculations.
*   `/data/processed_grid_analytics.csv` - The engineered dataset output used for dashboard modeling.
*   `/dashboard/Smart_Grid_Executive_Dashboard.xlsx` - Completed frontend Excel application workbook.
*   `/assets/dashboard_preview.png` - High-resolution interface preview for stakeholder review.
