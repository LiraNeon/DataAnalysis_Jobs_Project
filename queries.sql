/*
1. What are top 10 paying data analyst jobs + their companies?
*/

-- SELECT 
--     job_id, 
--     job_title_short,
--     job_location,
--     job_schedule_type,
--     salary_year_avg,
--     job_posted_date,
--     name AS company_name
-- FROM 
--     job_postings_fact
-- LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
-- WHERE
--     job_title_short = 'Data Analyst' AND
--     job_location = 'Anywhere' AND
--     salary_year_avg IS NOT NULL
-- order by salary_year_avg DESC
-- limit 10
    

/*
2. What are the top skills of these jobs
*/

-- WITH top_paying_jobs AS(
-- SELECT 
--     job_id, 
--     job_title_short,
--     salary_year_avg,
--     name AS company_name
-- FROM 
--     job_postings_fact
-- LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
-- WHERE
--     job_title_short = 'Data Analyst' AND
--     job_location = 'Anywhere' AND
--     salary_year_avg IS NOT NULL
-- order by salary_year_avg DESC
-- limit 10
-- )

-- SELECT
--     top_paying_jobs.*,
--     skills 
-- FROM top_paying_jobs
-- INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
-- INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
-- ORDER BY salary_year_avg DESC

/* 
3. Most in-demand skills for data analyst*/

-- SELECT 
--     skills, 
--     COUNT(skills_job_dim.job_id) AS demand_count 
-- FROM job_postings_fact
-- INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
-- INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
-- WHERE
--     job_title_short = 'Data Analyst' AND
--     job_work_from_home = TRUE
-- GROUP BY
--     skills
-- ORDER BY
--     demand_count DESC
-- LIMIT 5


/*
4. Better payed skills by DA*/
-- SELECT 
--     skills, 
--     ROUND(AVG(salary_year_avg),2) AS avg_salary 
-- FROM job_postings_fact
-- INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
-- INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
-- WHERE
--     job_title_short = 'Data Analyst' AND
--     salary_year_avg IS NOT NULL
-- GROUP BY
--     skills
-- ORDER BY
--     avg_salary
-- LIMIT 25

/*
5. Optimal skills to learn as DA (remote)*/

-- WITH skills_demand AS(
--     SELECT 
--     skills_dim.skill_id,
--     skills_dim.skills, 
--     COUNT(skills_job_dim.job_id) AS demand_count 
--     FROM job_postings_fact
--     INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
--     INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE
--         job_title_short = 'Data Analyst' AND
--         job_work_from_home = TRUE AND
--         job_work_from_home = TRUE
--     GROUP BY
--         skills_dim.skill_id
-- ), 
-- average_salary AS(
--     SELECT 
--         skills_job_dim.skill_id,
--         ROUND(AVG(salary_year_avg),2) AS avg_salary 
--     FROM job_postings_fact
--     INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
--     INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE
--         job_title_short = 'Data Analyst' AND
--         salary_year_avg IS NOT NULL
--     GROUP BY
--         skills_job_dim.skill_id
-- )

-- SELECT
--     skills_demand.skill_id,
--     skills_demand.skills,
--     demand_count,
--     avg_salary
-- FROM skills_demand
-- INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id 



















/*
--------------------Info about DA in Peru
*/

with peru_jobs as(
    select * FROM job_postings_fact
    where job_postings_fact.job_country = 'Peru'
    and (job_postings_fact.job_title_short like '%Data Analyst%'
    or job_postings_fact.job_title_short like '%Data Scientist%'
    or job_postings_fact.job_title_short like '%Data Engineer%')
), jobs_resumed as ( 
    select * FROM job_postings_fact
    where 
    (job_postings_fact.job_title_short like '%Data Analyst%'
    or job_postings_fact.job_title_short like '%Data Scientist%'
    or job_postings_fact.job_title_short like '%Data Engineer%')
    and job_postings_fact.job_country is not NULL
)

/*
    Searching for only 'Data' careers jobs in Peru (Data engineer/analyst/scientist)
*/



/*


/*
   Count how many jobs ask remote work 
*/
-- with jobs_resumed as ( 
--     select * FROM job_postings_fact
--     where 
--     (job_postings_fact.job_title_short like '%Data Analyst%'
--     or job_postings_fact.job_title_short like '%Data Scientist%'
--     or job_postings_fact.job_title_short like '%Data Engineer%')
--     and job_postings_fact.job_country is not NULL
-- )
-- SELECT 
--     SUM(CASE WHEN jobs_resumed.job_work_from_home = 'TRUE' THEN 1 ELSE 0 END) AS Work_at_home,
--     SUM(CASE WHEN jobs_resumed.job_work_from_home = 'FALSE' THEN 1 ELSE 0 END) AS Work_at_office
-- FROM 
--     jobs_resumed;


/*
    Count how many jobs doesnt need degree mention
*/

-- with jobs_resumed as ( 
--     select * FROM job_postings_fact
--     where 
--     (job_postings_fact.job_title_short like '%Data Analyst%'
--     or job_postings_fact.job_title_short like '%Data Scientist%'
--     or job_postings_fact.job_title_short like '%Data Engineer%')
--     and job_postings_fact.job_country is not NULL
-- )
-- select * FROM jobs_resumed
-- where jobs_resumed.job_no_degree_mention = FALSE;



/*
    Which country has the most DA jobs (analyst + engineer + scientist) 
*/


-- with jobs_resumed as ( 
--     select * FROM job_postings_fact
--     where 
--     (job_postings_fact.job_title_short like '%Data Analyst%'
--     or job_postings_fact.job_title_short like '%Data Scientist%'
--     or job_postings_fact.job_title_short like '%Data Engineer%')
--     and job_postings_fact.job_country is not NULL
-- )

-- select 
--     COUNT(jobs_resumed.job_id) as data_count, jobs_resumed.job_country
--     FROM jobs_resumed
--     GROUP BY jobs_resumed.job_country
--     ORDER BY data_count desc;

/*
    Which country has the least DA jobs (analyst+engineer+scientist) 
    (note: this is the same as the previous query but in ascending order)
*/

-- with jobs_resumed as ( 
--     select * FROM job_postings_fact
--     where 
--     (job_postings_fact.job_title_short like '%Data Analyst%'
--     or job_postings_fact.job_title_short like '%Data Scientist%'
--     or job_postings_fact.job_title_short like '%Data Engineer%')
--     and job_postings_fact.job_country is not NULL
-- )

-- select 
--     COUNT(jobs_resumed.job_id) as data_count, jobs_resumed.job_country
--     FROM jobs_resumed
--     GROUP BY jobs_resumed.job_country
--     ORDER BY data_count ASC;


/*
    Which platform offers more DA jobs in Peru
*/

-- with peru_jobs as(
--     select * FROM job_postings_fact
--     where job_postings_fact.job_country = 'Peru'
--     and (job_postings_fact.job_title_short like '%Data Analyst%'
--     or job_postings_fact.job_title_short like '%Data Scientist%'
--     or job_postings_fact.job_title_short like '%Data Engineer%')
-- )
-- select COUNT(peru_jobs.job_id) as via_counts, peru_jobs.job_via 
-- from peru_jobs 
-- GROUP by peru_jobs.job_via
-- order by via_counts desc
-- limit 10;


/*
    Which jobs have better salary in x country (average)(add company) (only by year)
*/
-- with resumed_jobs_country as(
--     select * FROM job_postings_fact
--     where 
--     (job_postings_fact.job_title_short like '%Data Analyst%'
--     or job_postings_fact.job_title_short like '%Data Scientist%'
--     or job_postings_fact.job_title_short like '%Data Engineer%')
--     and job_postings_fact.salary_rate = 'year'
-- )
-- select round(avg(resumed_jobs_country.salary_year_avg), 2), 
-- resumed_jobs_country.job_country, 
-- company_dim.name
-- from resumed_jobs_country
-- left join company_dim on company_dim.company_id = resumed_jobs_country.company_id
-- group by resumed_jobs_country.job_country,company_dim.name 


/*
    Which are the  skills asked for the most payed DA jobs (limit 10)
*/

-- with resumed_jobs_country as(
--     select * FROM job_postings_fact
--     where
--         (job_postings_fact.job_title_short like '%Data Analyst%'
--         or job_postings_fact.job_title_short like '%Data Scientist%'
--         or job_postings_fact.job_title_short like '%Data Engineer%')
--         and job_postings_fact.salary_rate = 'year' 
--         and job_postings_fact.salary_year_avg IS NOT NULL 
-- )
-- select resumed_jobs_country.job_id, 
--     resumed_jobs_country.job_title_short,
--     resumed_jobs_country.salary_year_avg,
--     resumed_jobs_country.job_country,
--     skills_dim.skill_id,
--     skills_dim.skills,
--     skills_dim.type, 
--     company_dim.name
-- from resumed_jobs_country
-- left join company_dim on company_dim.company_id = resumed_jobs_country.company_id
-- inner join skills_job_dim on skills_job_dim.job_id = resumed_jobs_country.job_id  
-- inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
