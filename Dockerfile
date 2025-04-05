FROM python:3.9

# Install Chrome and dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    curl \
    apt-transport-https \
    ca-certificates \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && apt-get clean

# Install ChromeDriver 135 (matches Chrome 135 installed above)
RUN wget -q "https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.52/linux64/chromedriver-linux64.zip" \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver \
    && rm -rf chromedriver-linux64 chromedriver-linux64.zip


# Set working directory
WORKDIR /app

# Copy requirements and install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the full app
COPY . .

# Expose Railway's expected default port (just for reference)
EXPOSE 8000

# Launch FastAPI using Uvicorn, dynamically using Railway's $PORT
CMD ["python", "main.py"]

