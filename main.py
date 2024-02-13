import os
from dotenv import load_dotenv
from flask import Flask, request, abort
from food_recommendation import recommendation
import os

load_dotenv()
app = Flask(__name__)


@app.post("/food_rec")
async def food_rec():
    api_key = request.headers.get("x-api-key", "")

    if api_key != os.getenv("API_KEY"):
        return abort(401)

    d = request.json

    gender = d["gender"]
    weight = d["weight"]
    height = d["height"]
    age = d["age"]
    activity_level = d["activity_level"]
    target = d["target"]

    breakfast, lunch, dinner, calories, proteins = recommendation(
        gender, weight, height, age, activity_level, target
    )

    breakfast_list = breakfast.to_dict(orient="records")
    lunch_list = lunch.to_dict(orient="records")
    dinner_list = dinner.to_dict(orient="records")

    return {
        "calories": round(float(calories), 2),
        "proteins": round(float(proteins), 2),
        "breakfast": breakfast_list,
        "lunch": lunch_list,
        "dinner": dinner_list,
    }


@app.errorhandler(401)
def unauthorized(e):
    return {
        "status": "fail",
        "message": "invalid api key",
    }, 401
