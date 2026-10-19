# Data Analyst Job Market Intelligence

### A data-driven curriculum and placement plan built from 12,000 Indian job postings

**Tools:** Python (pandas, matplotlib) · MySQL · Jupyter Notebook

---

## Business Problem

A training institute wants its Data Analyst program to match what employers actually ask for. Without market data, it cannot answer four decisions:

1. **Which skills should be taught first?**
2. **Which cities should placement efforts target?**
3. **Which companies should the institute approach?**
4. **Should Data Analyst, Business Analyst, and Data Scientist students follow the same curriculum?**

This project analyzes 12,000 Naukri job postings to answer each of these with data.

## Dataset

- **Source:** Naukri job postings, available on Kaggle as *Data Science Jobs In India* (author: anandhuh). Download it from Kaggle; it is not included in this repository.
- **Size:** 12,000 postings, 11,999 after cleaning (one row had no experience value).
- **Columns:** Job Role, Company, Location, Job Experience, Skills/Description.
- **Data Analyst jobs:** 1,049.
- **Collected:** May 2022.

## Approach

```
Raw CSV  →  Python (clean)  →  MySQL (store + query)  →  Python (charts)  →  Business recommendations
```

| Step | What was done | Tool |
|---|---|---|
| 1. Data quality check | Checked missing values and duplicates (none found) | pandas |
| 2. City cleaning | Merged spellings (Bengaluru / Bangalore / Bangalore/Bengaluru), removed area names such as `Pune(Baner)`, kept the first city when a job listed several | pandas |
| 3. Experience cleaning | Extracted the minimum experience from text like `5-10` and grouped it into 0-2, 3-5, and 5+ years | pandas |
| 4. Skill extraction | Matched 15 skills in the skills text using whole-word, case-insensitive matching (so `sql` does not match `mysql`) | pandas |
| 5. Database | Loaded the clean data into MySQL | MySQL Workbench |
| 6. Analysis | Wrote SQL queries using `GROUP BY`, `CASE`, `UNION ALL`, `HAVING`, and conditional aggregation | SQL |
| 7. Visualization | Built 9 charts | matplotlib |

## Key Insights

### 1. SQL is the most in-demand skill for Data Analyst jobs

| Skill | % of Data Analyst jobs |
|---|---|
| SQL | 27.1 |
| Excel | 21.4 |
| Python | 19.2 |
| Tableau | 15.8 |
| Power BI | 11.9 |

![Top skills](images/chart1_skills.png)

### 2. Excel matters most for entry-level roles, SQL grows with experience

| Experience | SQL % | Excel % | Python % | Power BI % |
|---|---|---|---|---|
| 0-2 yrs | 22.2 | **29.4** | 16.4 | 10.1 |
| 3-5 yrs | 31.3 | 15.6 | 22.0 | 12.7 |
| 5+ yrs | 33.7 | 5.3 | 21.1 | 17.9 |

![Skills by experience](images/chart4_skills_by_experience.png)

### 3. Skill coverage for fresher jobs

Share of the 513 fresher Data Analyst jobs (0-2 years) that mention at least one skill from the set:

| Skills learned | Fresher jobs matched |
|---|---|
| SQL + Excel | 44.2% |
| + Tableau or Power BI | 52.6% |
| + Python | 55.8% |

The first two skills give the biggest jump, and each addition after that adds less.

![Skill coverage](images/chart6_skill_coverage.png)

### 4. Bangalore leads, but fresher share differs by city

| City | Data Analyst jobs | Fresher share |
|---|---|---|
| Bangalore | 294 | 49.7% |
| Mumbai | 113 | 54.9% |
| Gurugram | 110 | 41.8% |
| Hyderabad | 108 | 36.1% |
| Chennai | 82 | 46.3% |
| Pune | 74 | 36.5% |
| Noida | 53 | 49.1% |
| Delhi | 53 | 58.5% |

Bangalore has more than double the jobs of any other city. Mumbai and Delhi have the highest share of entry-level roles.

![City priority](images/chart7_city_priority.png)

### 5. Hiring is fragmented

- 699 companies posted Data Analyst jobs, and 394 posted fresher roles.
- The top 10 companies hold only about 12.7% of fresher jobs.
- Myntra posted the most fresher roles (14).

![Top companies](images/chart8_top_companies.png)

### 6. Each role needs a different skill mix

| Role | Jobs | SQL % | Excel % | Python % |
|---|---|---|---|---|
| Data Analyst | 1,049 | 27.1 | 21.4 | 19.2 |
| Business Analyst | 658 | 19.0 | 11.2 | 9.6 |
| Data Scientist | 1,378 | 16.5 | 0.9 | 44.4 |

![Role tracks](images/chart9_role_tracks.png)

### 7. SQL appears with almost every other skill

| Skill pair | Jobs |
|---|---|
| SQL + Python | 102 |
| SQL + Excel | 72 |
| SQL + Tableau | 70 |
| Tableau + Power BI | 63 |
| SQL + Power BI | 36 |

## Recommendations

1. **Teach SQL and Excel first.** They are the top two skills and match about 44% of fresher Data Analyst jobs.
2. **Add one BI tool second** (Tableau or Power BI). It raises the match to about 53%.
3. **Introduce Python third.** It adds about 3 points for fresher roles, but its importance grows with experience.
4. **Give Excel extra weight in entry-level training.** It appears in 29.4% of 0-2 year jobs but only 5.3% of 5+ year jobs.
5. **Target Bangalore first for placements,** then Mumbai, Gurugram, and Hyderabad. Delhi and Mumbai have the highest shares of fresher roles.
6. **Plan broad employer outreach.** The market is fragmented, so a few partnerships will not cover most openings.
7. **Use separate tracks** for Data Analyst (SQL, Excel, BI), Business Analyst, and Data Scientist (Python first).

## Limitations

- **The data is from May 2022,** so today's market may differ.
- **Each posting lists only a few key skills.** About 44% of fresher Data Analyst postings list none of the five main skills, so coverage figures are a lower bound. Use the percentages to compare skills, not as exact market shares.
- **The dataset came from a "data scientist" search,** so Data Analyst jobs are a smaller sample (1,049).
- **Experience uses the minimum of each range** (for example, `2-5` counts as 2), so the 0-2 band includes roles that require 2 years.
- **Skill matching uses a fixed keyword list** and misses spelling variants or skills outside the list.
- **Descriptive analysis only.** The recommendations are not tested against actual placement outcomes.

## Repository Structure

```
data-analyst-job-market-india/
├── README.md
├── job_market_analysis_final.ipynb     # Python: cleaning, analysis, charts
├── job_market_queries_final.sql        # MySQL queries
└── images/                             # chart1 to chart9 (.png)
```

## How to Run

1. Download the dataset from Kaggle (*Data Science Jobs In India* by anandhuh) and save it as `naukri_data_science_jobs_india.csv` in the same folder as the notebook.
2. Install the libraries: `pip install pandas matplotlib jupyter`
3. Open `job_market_analysis_final.ipynb` and run **Kernel → Restart & Run All**. This creates `jobs_clean.csv` and the chart images.
4. In MySQL Workbench, import `jobs_clean.csv` using the Table Data Import Wizard (the table is created as `jobs_clean`).
5. Open `job_market_queries_final.sql`, run the `RENAME TABLE` line once, then run the queries one at a time.

## Sample Query

```sql
-- How skill demand changes with experience (Data Analyst jobs)
SELECT exp_band,
       COUNT(*) AS jobs,
       ROUND(AVG(`sql`)  * 100, 1) AS sql_pct,
       ROUND(AVG(excel)  * 100, 1) AS excel_pct,
       ROUND(AVG(python) * 100, 1) AS python_pct
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%'
GROUP BY exp_band
ORDER BY exp_band;
```

## Future Improvements

- Add salary analysis using a separate AmbitionBox dataset (the two datasets cannot be joined row by row).
- Build a Power BI or Excel dashboard with city and experience filters.
- Refresh the analysis with current job postings.
- Improve skill extraction with a larger skill dictionary or NLP.

## Author

**Pratiksha Dhakulkar**
Aspiring Data Analyst | Pune, India
[LinkedIn](https://linkedin.com/in/dhakulkar) · [GitHub](https://github.com/PratikshaDhakulkar24)
