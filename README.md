# Gerador de provas em Latex (LatexExamGenerator)
O gerador de provas é uma ferramenta para auxiliar a geração de provas customizadas e individuais por aluno.
O prof. tem em suas mãos uma ferramenta capaz de receber um conjunto de questões pré-definidas e transformá-las em avaliações individuais facilitando o processo de geração, edição e preparação para impressão.
### Funcionalidades:
 - Gerador de provas automatizados
 - Provas individuais por alunos
 - Gabarito individualizado por prova
 - Gerar o embaralhamento aleatório do gabarito por questão
 - Gerar o embaralhamento aleatório das questões por prova

# Como funciona?
O programa funciona utilizando um **template/modelo** do documento, uma das vantagens da linguagem de edição de texto Latex.
O processo:
 - Gerar uma folha de rosto
 - Definir quantas questões a prova irá conter
 - Inserir as questões na estrutura de diretórios
 - Incluir um arquivo com o nome dos alunos
 - Executar o programa main.py no diretório do **template**
 
# Resultado 
Como resultado obtem-se um novo diretório criado dentro de **template** chamado build. Isso garante que o prof. possa realizar uma checagem e conferir gabaritos e número de provas.
Pode-se observar que cada prova gerada, contém a estrutura número_nome_do_aluno, o que facilita a identificação e a estrutura gerada pelo programa principal main.py. 
Cada vez que o programa main.py for executado a pasta build será inteiramente refeita e cada uma das provas criadas terá uma nova estrutura.

# A estrutura (arquivos)
```sh
template/exam.tex # Folha de rosto da prova
template/alunos.txt # Alunos participantes
template/Makefile # Ferramenta de ajuda na compilação do exam.text
template/question.X/exercise.0.tex # Cada questão da prova
```

# Requisitos
O projeto usa **Python 3.13** gerenciado pelo [uv](https://docs.astral.sh/uv/). Há duas formas de rodar:

- **Docker (recomendado):** a imagem já traz Python, as dependências e o TeX Live (xelatex, `exam`, `minted`, babel pt-BR). Não é preciso instalar nada além do Docker.
- **Local:** requer `uv` e, para compilar os PDFs, uma instalação do TeX Live com `xelatex`, `make` e `zip`.

# Como gerar as provas com Docker
Construa a imagem uma vez, na raiz do projeto:
```sh
docker build -t latex-exam-generator .
```

Depois rode a partir do diretório que contém o template da prova (`exam.tex`, `alunos.txt`, `question.N/`):
```sh
cd template
docker run --rm --user "$(id -u):$(id -g)" -v "$PWD:/prova:Z" latex-exam-generator
```

Esse comando gera o diretório `build/`, compila os PDFs e cria `build/provas.zip`. Para executar só uma etapa, passe `gerar` ou `compilar` no final do comando:
```sh
docker run --rm --user "$(id -u):$(id -g)" -v "$PWD:/prova:Z" latex-exam-generator gerar
docker run --rm --user "$(id -u):$(id -g)" -v "$PWD:/prova:Z" latex-exam-generator compilar
```

O `--user` faz os arquivos gerados pertencerem ao seu usuário; o sufixo `:Z` só é necessário em sistemas com SELinux (Fedora, RHEL).

# Como gerar o diretório build localmente
```sh
uv sync
cd template
uv run --project .. python ../main.py
```

Ou seja, executar o programa main.py dentro do diretório template.
Depois de executar o programa o diretório build vai conter todas as provas prontas para serem geradas individualmente.

# Script.sh
Dentro do diretório build é possível encontrar o arquivo script.sh que é responsável por gerar as provas no formato PDF e também incluir cada uma das provas para um arquivo ZIP, chamado provas.zip . O arquivo provas.zip está no melhor formato para ser compartilhado, ou transportado até uma impressora.

# Como corrigir as provas?
Todas as provas são diferentes, mas para cada prova existe um arquivo chamado assinatura, que representa o gabarito para cada prova.
Exemplo de uso para correção de prova:

[![N|Solid](https://raw.githubusercontent.com/marc-queiroz/LatexExamGenerator/master/assinatura.png)](Exemplo)

# Conclusão
Com a geração de provas personalizadas utilizando Latex procura-se diminuir a fricção em termos de edição, melhorias incrementais, adição de biblioteca de questões, tudo isso aliado a facilidade de gerar novas provas.
No dia a dia também é possível salvar cada uma das provas e criar um repositório para cada uma de suas provas, sem o risco de perder qualquer informação.
