#!/bin/sh
# Uso: docker run ... latex-exam-generator [gerar|compilar|tudo]
#   gerar    -> executa main.py e cria build/ com os .tex de cada aluno
#   compilar -> executa build/script.sh (PDFs + provas.zip)
#   tudo     -> gerar e depois compilar (padrão)
set -e

gerar() {
    python /app/main.py
}

compilar() {
    if [ ! -d build ]; then
        echo "Diretório build/ não encontrado. Rode 'gerar' primeiro." >&2
        exit 1
    fi
    cd build && sh script.sh
}

case "${1:-tudo}" in
    gerar)    gerar ;;
    compilar) compilar ;;
    tudo)     gerar && compilar ;;
    *)        exec "$@" ;;
esac
