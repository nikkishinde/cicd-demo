FROM python:3.9-slim

# Update and install necessary system dependencies
RUN apt-get update -y && apt-get install -y \
    python3-distutils python3-venv \
    && apt-get clean

# Create and enable the virtual environment
RUN python3 -m venv /opt/env
ENV PATH="/opt/env/bin:$PATH"

# Upgrade pip inside the virtual environment
RUN pip install --upgrade pip

# Install Django in the virtual environment
RUN pip install django==3.2

# Set the working directory
WORKDIR /app

# Copy application files to the container
COPY . .

# Perform Django migrations
RUN python manage.py migrate

# Expose the application port
EXPOSE 8000

# Set the default command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

