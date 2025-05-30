# FROM ubuntu:latest
FROM python:3.10-slim

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHON_VERSION=3.8 

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    wget \
    gnupg \
    curl \
    software-properties-common \
    python${PYTHON_VERSION} \
    python3-pip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
# Set the working directory
WORKDIR /app


# Install the Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app


ARG DOWNLOAD_URL="https://ollama.com/install.sh"

RUN wget $DOWNLOAD_URL -O install1.sh && \
    chmod +x install1.sh && \
    ./install1.sh


# Command to run when the container starts
CMD [ "echo", "Successfully installed!!!!!" ]


######## STEPS ###############

# pip install --upgrade pip

#(main)> (option) pip install -r requirements.txt

#(main)> docker build -t drone_ai .
#(main)> docker run -it -p 11434:11434 drone_ai /bin/bash

#app> OLLAMA_HOST=0.0.0.0 ollama serve &
### WAIT for about 10 seconds before <press enter>

#app> ollama list
## should be empty

#app> ollama run deepseek-r1 --verbose

#app> ollama run llama3 --verbose

#> curl -X POST http://localhost:11434/api/generate -d '{  "model": "llama3",  "prompt":"What is water?"}'