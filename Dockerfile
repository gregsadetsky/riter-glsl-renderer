FROM ubuntu:24.04

WORKDIR /code

RUN apt update -y
RUN apt upgrade -y

ADD ./bin/install_glslviewer.sh /code/bin/install_glslviewer.sh
RUN chmod +x /code/bin/install_glslviewer.sh
RUN /code/bin/install_glslviewer.sh

RUN apt-get install -y python3-pip
RUN apt-get install -y python3-dev
RUN apt-get install -y python3

# docker will not re-pip install if requirements.txt doesn't change
ADD ./requirements.txt /code/requirements.txt
RUN pip install --break-system-packages -r requirements.txt

ADD . /code

CMD ["python3", "server.py"]
