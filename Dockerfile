FROM coollabsio/openclaw:latest
COPY . /data
EXPOSE 3000
CMD ["gateway", "--port", "3000", "--data", "/data"]
