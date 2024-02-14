FROM python:3.9.18-bullseye

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY food_recommendation.py .

RUN wget https://storage.googleapis.com/klrz-prod/knn.pkl

RUN wget https://storage.googleapis.com/klrz-prod/cleaned_recipes.csv

COPY main.py .

CMD [ "python" , "-m", "flask", "--app", "main", "run", "--host=0.0.0.0" ]