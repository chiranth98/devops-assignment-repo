FROM python:3.10-slim AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y build-essential
COPY requirements.txt .

RUN python -m venv /install && \
    /install/bin/pip install --upgrade pip && \
    /install/bin/pip install --no-cache-dir -r requirements.txt
    
COPY . .

FROM python:3.10-slim

WORKDIR /app

COPY --from=builder /install /install
COPY --from=builder /app /app

ENV PATH="/install/bin:$PATH"

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
