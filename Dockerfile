FROM ubuntu:24.04

WORKDIR /code

ADD ./bin/install_glslviewer.sh /code/bin/install_glslviewer.sh
RUN chmod +x /code/bin/install_glslviewer.sh
RUN /code/bin/install_glslviewer.sh

RUN apt-get install -y python3-pip
RUN apt-get install -y python3-dev

# docker will not re-pip install if requirements.txt doesn't change
ADD ./requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt

ADD . /code

CMD ["python", "server.py"]