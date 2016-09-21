FROM ubuntu:14.04

RUN apt-get update && apt-get install -y python-pip python-dev && apt-get clean

RUN pip install bottle
RUN pip install gunicorn
RUN pip install gevent

EXPOSE 8090

WORKDIR /app
RUN mkdir /app/views

ADD main_app.py .
ADD views views/

CMD ["gunicorn","-b","0.0.0.0:8090","-w","3","-k","gevent","--log-file","-","--log-level","debug","--access-logfile","-","main_app:app"]
