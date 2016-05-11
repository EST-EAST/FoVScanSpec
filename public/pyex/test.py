import requests

r = requests.post("http://localhost:3000/sweep_eng_runs/1/sweep_ex_logs", data={'sweep_ex_log': {"sweep_eng_run_id":"1", "a":"6", "b":"8", "c":"9"}, "sweep_eng_run_id":"1","action":"create"})
print(r.status_code, r.reason)



