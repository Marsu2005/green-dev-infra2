# Imatge base
FROM python:3.11-alpine

# Directori de treball dins del container
WORKDIR /app

# Copiamos dependencias
COPY requirements.txt .

# Instalamos librerías
RUN pip install --no-cache-dir -r requirements.txt

# Copia els fitxers
COPY app.py .

# Creacio d'usuari running as non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && chown appuser:appgroup /app/app.py

# La app ya no corra com root
USER appuser

# Exposa el port
EXPOSE 8000

# Comanda per executar l'app
CMD ["python3", "app.py"]
