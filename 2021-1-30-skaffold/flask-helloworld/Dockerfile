FROM python:3-slim

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080
COPY src .

CMD [ "python", "./app.py" ]