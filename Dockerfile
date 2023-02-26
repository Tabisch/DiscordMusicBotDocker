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
COPY config.txt /app

RUN chmod +x /app/start.sh

ENV TOKEN=0
ENV OWNER=0
ENV PREFIX="!!"
ENV GAME="Default"
ENV STATUS="ONLINE"
ENV SONGINSTATUS=false
ENV ALTPREFIX="NONE"

ENV SUCCESS="🎶"
ENV WARNING="💡"
ENV ERROR="🚫"
ENV LOADING="⌚"
ENV SEARCHING="🔎"

ENV HELP="help"
ENV NPIMAGES=false
ENV STAYINCHANNEL=false
ENV MAXTIME=0
ENV ALONETIMEUNTILSTOP=0
ENV PLAYLISTSFOLDER="Playlists"
ENV UPDATEALERTS=true
ENV LYRICS_DEFAULT="A-Z Lyrics"

ENTRYPOINT ["/bin/bash", "/app/start.sh"]