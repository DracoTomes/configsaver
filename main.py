from fastapi import FastAPI
from datetime import datetime
import json
import os

app = FastAPI()


@app.post("/{name}")
def save_config(name: str, data: dict):
    if not os.path.isdir(f"/configs/{name}"):
        os.mkdir(f"/configs/{name}")
    with open(f"/configs/{name}/{datetime.now().strftime('%y-%m-%d_%H-%M-%S')}", "w") as configfile:
        configfile.write(json.dumps(data, indent=2))
    return {"acknowledged": True}



