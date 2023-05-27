import shutil
import os
from flask import Flask, request
from prediction import predict
import os

app = Flask(__name__)


@app.post("/")
async def f2hwg():
    f = request.files["picture"]

    path = os.path.join(os.getcwd(), f.filename)

    f.save(path)

    height, weight, gender = predict(path)

    os.remove(path)

    return {
        "height": round(float(height * 10)),
        "weight": round(float(weight)),
        "gender": gender,
    }
