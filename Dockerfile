FROM python:3.9.18-bullseye

WORKDIR /app


COPY requirements.txt .

RUN pip install -r requirements.txt

COPY food_recommendation.py .

COPY knn.pkl .

COPY cleaned_recipes.csv .

# COPY prediction_hwg.py .

COPY main.py .

CMD [ "python" , "-m", "flask", "--app", "main", "run", "--host=0.0.0.0" ]