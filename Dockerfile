FROM python:3.5.2

ENV TZ=Asia/Shanghai
#RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

#COPY cmd.sh /
#RUN chmod +x /cmd.sh

COPY requirement.txt /requirement.txt
#COPY source.list /etc/apt/sources.list		for mirror in China
#COPY pip.conf /root/.pip/pip.conf 			for mirror in CHina


RUN cd /usr/local/lib/python3.5/site-packages \
	&& wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
	&& tar xvf ta-lib-0.4.0-src.tar.gz \
	&& cd ta-lib \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install \
	&& cd .. \
	&& pip install -r /requirement.txt \
	&& rm -rf ta-lib \
	&& rm ta-lib-0.4.0-src.tar.gz

WORKDIR app
COPY app /app

#EXPOSE 9090 9191
#USER uwsgi
EXPOSE 5000

#CMD ["/cmd.sh"]
CMD ["python", "/app/app.py"]
