FROM rockylinux:9-minimal

# Install Node.js (LTS) and Python 3
# microdnf is the package manager in rockylinux:9-minimal
RUN microdnf install -y \
        tar \
        nodejs \
        npm \
        python3 \
        python3-pip \
        curl \
        ca-certificates \
    && microdnf clean all

# Install uv (provides uvx)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Make uv/uvx available system-wide
ENV PATH="/root/.local/bin:${PATH}"

# Install semgrep MCP
RUN python3 -m pip install semgrep --quiet --no-input

# Verify installations
RUN node --version \
    && npm --version \
    && npx --version \
    && python3 --version \
    && uvx --version
