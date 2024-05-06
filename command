

system.run["/bin/bash -c 'curl -s --head <url> | grep -q \"200 OK\" && echo \"up\" || echo \"down\"'"]
SELECT a.name AS action_name, ao.operationid, ao.operationtype, ao.shortdata, ao.longdata
FROM actions a
JOIN operations ao ON a.actionid = ao.actionid;

SELECT 
  session_id,
  program_name,
  STATUS,
  total_elapsed_time/1000 AS total_elapsed_time_sec,
  [text] AS query_text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS t
WHERE STATUS = 'RUNNING'
  AND total_elapsed_time > @threshold_seconds * 1000 -- Replace @threshold_seconds with your desired threshold in seconds
ORDER BY total_elapsed_time DESC

SELECT 
  SCHEMA_NAME(schema_id) AS schema_name,
  OBJECT_NAME(query_id) AS query_name,
  last_elapsed_time/1000 AS last_elapsed_time_sec,
  execution_count
FROM sys.dm_exec_query_stats
WHERE last_elapsed_time > @threshold_seconds * 1000 -- Replace @threshold_seconds with your desired threshold in seconds
ORDER BY last_elapsed_time DESC;

SELECT TOP 10
    r.session_id AS SessionID,
    r.start_time AS StartTime,
    s.text AS QueryText,
    r.total_elapsed_time / 1000.0 AS TotalElapsedTimeSeconds
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) s
WHERE r.status = 'running'
ORDER BY r.total_elapsed_time DESC;

SELECT TOP 10
    r.session_id AS SessionID,
    r.start_time AS StartTime,
    s.text AS QueryText,
    r.total_elapsed_time / 1000.0 AS TotalElapsedTimeSeconds,
    r.logical_reads AS LogicalReads,
    r.reads AS Reads,
    r.writes AS Writes,
    r.cpu_time AS CPUTime
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) s
WHERE r.status = 'running'
ORDER BY r.total_elapsed_time DESC;

