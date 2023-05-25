FROM tensorflow/tensorflow:2.12.0

WORKDIR /app

RUN apt-get update && apt-get install git wget ffmpeg libsm6 libxext6 libgl1 -y

RUN wget https://storage.googleapis.com/kalorize-test/model_vgg16_2.h5 

RUN pip install opencv-python-headless

RUN pip install git+https://github.com/rcmalli/keras-vggface.git

RUN pip install mtcnn

RUN pip install keras

RUN pip install numpy

RUN pip install tensorflow

RUN pip install flask

COPY prediction.py .

COPY main.py .

CMD [ "python" , "-m", "flask", "--app", "main", "run", "--host=0.0.0.0" ]