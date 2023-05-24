FROM python:3.9.16-slim

WORKDIR /app

RUN apt-get update

RUN apt-get install git -v

RUN wget https://storage.googleapis.com/kalorize-test/model_vgg16_2.h5

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY prediction.py .

COPY main.py .

CMD [ "python" , "-m", "flask", "--app", "main", "run" ]