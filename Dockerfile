# 1. Use a lightweight Python image
FROM python:3.12-slim

# 2. Set environment variables
# Prevents Python from writing pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Set working directory
WORKDIR /app

# 4. Install dependencies
# We copy this first to leverage Docker's cache layer

# Update package list and install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy project files
COPY . /app/

# 6. Expose the port Django runs on
EXPOSE 8000

# 7. Start the server using Gunicorn (standard for production)
# Replace 'myproject' with your actual project folder name (where wsgi.py is)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "mysite.wsgi:application"]
