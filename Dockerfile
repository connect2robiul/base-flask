# Use Miniconda as base image
FROM continuumio/miniconda3

# Set working directory
WORKDIR /app

# Copy environment files first
COPY environment.yml .
COPY requirements.txt .

# Create the conda environment
RUN conda env create -f environment.yml

# Activate the environment and set it as default
RUN echo "conda activate llm" >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

# Copy application files last (to optimize caching)
COPY . .

# Install any additional dependencies via pip
RUN pip install --no-cache-dir -r requirements.txt

# Set the default command
CMD ["bash"]
