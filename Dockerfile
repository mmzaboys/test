FROM python:3.7-slim 

RUN pip install flask==1.0.2  

COPY app.py /app/app.py
WORKDIR /app
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:5000/health || exit 1
USER 1001
EXPOSE 5000
CMD ["python", "app.py"]
