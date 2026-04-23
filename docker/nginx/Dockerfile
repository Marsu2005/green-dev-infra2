# Partim de la imatge oficial de Nginx
FROM nginx:alpine

# Copiem la nostra pàgina HTML dins el contenidor
COPY index.html /usr/share/nginx/html/index.html

# Nginx serivar la pàgina HTML i a mes reenviara les peticions al backend
COPY default.conf /etc/nginx/conf.d/default.conf
