system.run["/bin/bash -c 'curl -s --head <url> | grep -q \"200 OK\" && echo \"up\" || echo \"down\"'"]
SELECT a.name AS action_name, ao.operationid, ao.operationtype, ao.shortdata, ao.longdata
FROM actions a
JOIN operations ao ON a.actionid = ao.actionid;