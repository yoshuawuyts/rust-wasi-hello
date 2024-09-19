ARG TAG="latest"
FROM mcr.microsoft.com/devcontainers/rust:${TAG}

USER vscode

COPY ./scripts /tmp/scripts/
RUN bash /tmp/scripts/install.sh
