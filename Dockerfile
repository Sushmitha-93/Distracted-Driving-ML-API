# Python version
FROM python:3.9

# Working directory. We are now in /code folder in docker server
WORKDIR /code

# Copying requirements.txt to /code folder
COPY ./requirements.txt /code/requirements.txt

# Configure server
# RUN pip install --upgrade pip

# Install packages mentioned in requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# This is required if cv2 libraries is used. We are installing the cv2 dependencies
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

#  Copy all the file in /app folder to code folder
COPY ./app /code/app

# Command to run fast api app using uvicorn on the server
#CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8500"]
CMD uvicorn app.main:app --host 0.0.0.0 --port $PORT
#CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", $PORT]
