FROM danzilla/centos6-python3-django

WORKDIR /opt/django_project

COPY . /opt/django_project

RUN pip3.4 install -r requirements.txt

#Allow external from a requirements file didn't seem to work
RUN pip3.4 install mysql-connector-python --allow-external mysql-connector-python

#Serving static files via sendfile and mounted directories causes cached file/corrupted file issues when one of those static files is updated.  This fixes that.
RUN sed -i s/'sendfile        on;'/'sendfile        off;'/g /etc/nginx/nginx.conf

RUN printf "\ncatch-exceptions = true \nenable-threads = true" >> /opt/docker/code/uwsgi.ini

EXPOSE 80
EXPOSE 8081

CMD ["supervisord", "-n"]