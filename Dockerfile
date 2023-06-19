FROM nginx
COPY ./ /usr/share/nginx/html
VOLUME /data:/data
RUN sed -i 's/user  nginx;/#user nginx;/g' /etc/nginx/nginx.conf
#RUN usermod -aG adm nginx
CMD [ "nginx", "-g", "daemon off;" ]