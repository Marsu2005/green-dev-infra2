# Imatge base
FROM python:3.11-slim

# Directori de treball dins del container
WORKDIR /app

# Copia els fitxers
COPY app.py .

# Exposa el port
EXPOSE 8000

# Comanda per executar l'app
CMD ["python", "app.py"]
