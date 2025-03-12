# Use Miniconda as base image
FROM continuumio/miniconda3

# Set working directory
WORKDIR /app

# Copy environment files first
COPY environment.yml .
COPY requirements.txt .

# Create the conda environment
RUN conda env create -f environment.yml

# Activate the environment properly
SHELL ["conda", "run", "-n", "llm", "/bin/bash", "-c"]

# Set Conda environment path
ENV PATH="/opt/conda/envs/llm/bin:$PATH"

# Copy application files last (to optimize caching)
COPY . .

# Install additional dependencies via pip inside Conda environment
RUN conda run -n llm pip install --no-cache-dir -r requirements.txt

# Verify that dependencies are installed
RUN conda run -n llm python -c "import flask, gunicorn"

# Expose the port Flask/Gunicorn will run on
EXPOSE 1212

# Use bash -c to ensure environment activation
CMD ["bash", "-c", "conda run -n llm gunicorn -b 0.0.0.0:1212 src.app:app"]
