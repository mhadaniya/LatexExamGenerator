FROM python:3.13-slim-trixie

COPY --from=ghcr.io/astral-sh/uv:0.11.21 /uv /uvx /usr/local/bin/

# TeX Live para compilar as provas (xelatex + exam, minted, mdframed, babel pt-BR)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      texlive-xetex \
      texlive-latex-extra \
      texlive-lang-portuguese \
      texlive-fonts-recommended \
      lmodern \
      make \
      zip \
 && rm -rf /var/lib/apt/lists/*

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/opt/venv \
    PATH="/opt/venv/bin:$PATH" \
    HOME=/tmp

WORKDIR /app

# Dependências primeiro, para aproveitar o cache de camadas
COPY pyproject.toml uv.lock .python-version ./
RUN uv sync --locked --no-install-project --no-dev

COPY main.py script.sh docker-entrypoint.sh ./
COPY dominio ./dominio
RUN chmod +x docker-entrypoint.sh

# O template da prova (exam.tex, alunos.txt, question.N/...) é montado aqui
WORKDIR /prova
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["tudo"]
