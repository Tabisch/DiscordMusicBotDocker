import requests
import json

headersRelease = {
    "Accept": "application/vnd.github+json",
    }

headersDownload = {
    "Accept": "application/octet-stream",
}

repoLatestReleaseUrl = "https://api.github.com/repos/jagrosh/MusicBot/releases/latest"

result = requests.get(repoLatestReleaseUrl, headers=headersRelease)

resultJson = json.loads(result.text)

print(json.dumps(resultJson , indent= 4))

downloadUrl = resultJson["assets"][0]["browser_download_url"]

releaseDownload = requests.get(downloadUrl, allow_redirects=True ,headers=headersDownload)

print(f"Downloading...")

with open("musicBot.jar", "wb") as binary_file:
    binary_file.write(releaseDownload.content)

print(f"Download complete.")