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

ENV token=0
ENV owner=0
ENV prefix="!!"
ENV game="Default"
ENV status="ONLINE"
ENV songinstatus="false"
ENV altprefix="NONE"

ENV success = "🎶"
ENV warning = "💡"
ENV error = "🚫"
ENV loading = "⌚"
ENV searching = "🔎"

ENV help = help
ENV npimages = false
ENV stayinchannel = false
ENV maxtime = 0
ENV alonetimeuntilstop = 0
ENV playlistsfolder = "Playlists"
ENV updatealerts="true"
ENV lyrics.default = "A-Z Lyrics"

ENTRYPOINT ["/bin/bash", "/app/start.sh"]