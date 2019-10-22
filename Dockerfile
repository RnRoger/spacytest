FROM python:3.6  

WORKDIR /app

# COPY ./requirements.txt ./
# COPY /prodigy-1.8.4-cp35.cp36.cp37-cp35m.cp36m.cp37m-linux_x86_64.whl ./
# COPY ./patterns.jsonl ./
# COPY ./prodigy-app.py ./

COPY ./app/ ./

RUN pip install -r requirements.txt && \
    apt-get -y update && \
    apt-get -y install nano
RUN python -m spacy download en_core_web_sm
RUN pip install prodigy-1.8.4-cp35.cp36.cp37-cp35m.cp36m.cp37m-linux_x86_64.whl

EXPOSE 8080

RUN prodigy ner.teach your_dataset en_core_web_sm your_data.jsonl --label POSITION --patterns patterns.jsonl

# docker-compose keeps this contrainer running
