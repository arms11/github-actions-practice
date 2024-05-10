FROM python:3.11

RUN apt install make

COPY requirements.txt ./

RUN pip install -r requirements.txt
