FROM python:3.12.1

WORKDIR /code

ADD ./bin/install_glslviewer.sh /code/bin/install_glslviewer.sh
RUN chmod +x /code/bin/install_glslviewer.sh
RUN /code/bin/install_glslviewer.sh

# docker will not re-pip install if requirements.txt doesn't change
ADD ./requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt

ADD . /code

CMD ["python", "server.py"]