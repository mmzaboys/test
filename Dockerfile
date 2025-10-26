FROM python:3.7-slim 

RUN pip install flask==1.0.2  

COPY app.py /app/app.py
WORKDIR /app

EXPOSE 5000
CMD ["python", "app.py"]
