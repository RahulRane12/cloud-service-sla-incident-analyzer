SELECT 
    s.service_name,
    s.service_tier,
    COUNT(f.incident_id) AS total_incidents,
    ROUND(AVG(f.downtime_minutes), 1) AS avg_downtime_mins,
    SUM(f.sla_breached) AS total_breaches,
    ROUND((SUM(f.sla_breached) / COUNT(f.incident_id)) * 100, 1) AS breach_rate_pct
FROM dim_services s
JOIN fact_incidents f ON s.service_id = f.service_id
GROUP BY s.service_name, s.service_tier
ORDER BY total_breaches DESC;
