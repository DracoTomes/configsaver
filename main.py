from fastapi import FastAPI
from datetime import datetime
import json
import os

app = FastAPI()


@app.post("/{roomname}")
def save_config(roomname: str, data: dict):
    if not os.path.isdir(f"/configs/{roomname}"):
        os.mkdir(f"/configs/{roomname}")
    with open(f"/configs/{roomname}/{datetime.now().strftime('%y-%m-%d_%H-%M-%S')}", "w") as configfile:
        configfile.write(json.dumps(data, indent=2))
    return {"acknowledged": True}



