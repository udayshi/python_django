FROM debian:buster-slim
RUN apt-get update \
&& apt-get install -y \
	        bash \
	        wget \
            curl \
            git \
            vim \
	        supervisor \
	        nginx

RUN apt-get install -y \
            python3 \
            python3-pip \
            python-pip

WORKDIR /usr/bin
#RUN ln -sf python3.6 python && ln -sf pip3 pip





ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY manifest/config/nginx.conf /etc/nginx/nginx.conf
COPY manifest/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


COPY app /app
RUN mkdir -p /run/nginx/
WORKDIR /app
RUN pip3 install -r requirements.txt
EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]