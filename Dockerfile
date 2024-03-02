# Flask
FROM python:3.8-slim as builder
WORKDIR /app
COPY app/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY app /app

# Nginx.uWSGI
FROM nginx:stable
# uWSGI
RUN apt-get update && apt-get install -y python3-pip && pip3 install uwsgi
COPY --from=builder /app /app
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY app/uwsgi.ini /app/uwsgi.ini

COPY start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 80
CMD ["/start.sh"]