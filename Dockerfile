FROM python:3.10-slim
LABEL authors="jriofrio"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY MLproject conda.taml README.md ./

ENTRYPOINT ["python", "src/train.py"]
CMD ["--C","1.0", "--max_iter", "200", "--test_size", "0.2", "--random_state", "42"]