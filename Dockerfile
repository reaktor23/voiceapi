FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get -y update && \
    apt-get install -y nginx supervisor mpg123

RUN addgroup --system --gid 123 nginx && \
    adduser  --system --disabled-login --ingroup nginx --no-create-home --gecos "nginx user" --shell /bin/false --uid 123 nginx 
RUN mkdir /www /run/nginx && \
    chown -R nginx:nginx /var/lib/nginx  && \
    chown -R nginx:nginx /www

RUN pip install flask gunicorn gTTS

RUN mkdir /app
WORKDIR /app

COPY __init__.py /app
COPY api.py /app
COPY wsgi.py /app
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 
COPY nginx.conf /etc/nginx/

EXPOSE 80

CMD ["/usr/bin/supervisord"]
