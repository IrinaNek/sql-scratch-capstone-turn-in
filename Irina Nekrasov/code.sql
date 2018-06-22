select count(distinct utm_campaign) as total_campaigns 
from page_visits;

select count(distinct utm_source) as total_sources 
from page_visits;

select distinct utm_campaign, utm_source
from page_visits;

Select distinct page_name
from page_visits;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
 count(ft.first_touch_at),
  pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
group by utm_campaign 
order by 2;

WITH last_touch AS (
    SELECT user_id,
        max(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
 count(lt.last_touch_at) as total_last_touch,,
  pv.utm_source,
		pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
group by utm_campaign 
order by 2;

Select count(distinct user_id) as total_users,
page_name
from page_visits
where page_name = '4 - purchase'
group by page_name;


WITH last_touch AS (
    SELECT user_id,
        max(timestamp) as last_touch_at
    FROM page_visits 
  where page_name = '4 - purchase'
    GROUP BY user_id)
SELECT count(lt.last_touch_at) as total_last_touch,
  pv.utm_source, pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
group by utm_campaign 
order by 1;
