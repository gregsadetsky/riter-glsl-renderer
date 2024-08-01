FROM python:3.12.1

RUN bin/install_glslviewer.sh

# docker will not re-pip install if requirements.txt doesn't change
WORKDIR /code
ADD ./requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt

ADD . /code

CMD ["python", "server.py"]