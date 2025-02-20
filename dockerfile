# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for Prophet, ARIMA, and other libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libatlas-base-dev \
    libfreetype6-dev \
    libpng-dev \
    libopenblas-dev \
    liblapack-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Install matplotlib dependencies
RUN apt-get update && apt-get install -y \
    libjpeg-dev zlib1g-dev

# Copy the requirements.txt file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Expose the port Streamlit will run on (default is 8501)
EXPOSE 8501

# Define environment variable to prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Run the Streamlit app
CMD ["streamlit", "run", "tin.py", "--server.port=8501", "--server.address=0.0.0.0"]
