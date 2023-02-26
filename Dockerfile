FROM python:latest AS download

RUN mkdir /app

RUN cd /app

WORKDIR /app

COPY DownloadLatest.py /app/
COPY requirements.txt /app/

RUN python -m pip install -r requirements.txt

RUN python ./DownloadLatest.py

FROM alpine:latest AS run

RUN apk update
RUN apk upgrade
RUN apk add bash openjdk11-jre-headless

RUN mkdir /app

WORKDIR /app

COPY --from=download /app/musicBot.jar /app
COPY start.sh /app

RUN chmod +x /app/start.sh

ENV token=0
ENV owner=0
ENV prefix="!"

ENTRYPOINT ["/bin/bash", "/app/start.sh"]