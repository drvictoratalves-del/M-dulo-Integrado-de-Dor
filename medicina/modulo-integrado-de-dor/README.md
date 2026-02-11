# Módulo Integrado de Dor

Módulo educacional integrado sobre o manejo da dor, utilizando abordagem
multidisciplinar. Este repositório contém o texto-fonte do livro em
Markdown, com pipeline automatizado de compilação para PDF, EPUB e HTML.

## Pré-requisitos

- [Pandoc](https://pandoc.org/) >= 3.0
- [Typst](https://typst.app/) >= 0.12
- [GNU Make](https://www.gnu.org/software/make/)
- Fontes: Libertinus Serif, Libertinus Sans (recomendadas)

### Instalação rápida

```bash
# Pandoc (Ubuntu/Debian)
sudo apt install pandoc

# Typst
curl -fsSL https://typst.community/typst-install/install.sh | bash

# Fontes Libertinus (Ubuntu/Debian)
sudo apt install fonts-libertinus
```

## Estrutura do Projeto

```
├── contents/           Capítulos em Markdown (001-xxx.md, 002-xxx.md, ...)
├── frontmatter/        Material preliminar (dedicatória, prefácio)
├── backmatter/         Material complementar (apêndices)
├── img/                Imagens e figuras
├── templates/          Template Typst para o livro
│   └── book.typ
├── output/             Artefatos compilados (PDF, EPUB, HTML)
├── Makefile            Automação de build
├── metadata.yaml       Metadados do livro
└── bibliography.bib    Referências bibliográficas (BibTeX)
```

## Como Usar

### Compilar o livro

```bash
make all          # Gera PDF, EPUB e HTML
make pdf          # Apenas PDF
make epub         # Apenas EPUB
make html         # Apenas HTML
```

### Modo de observação (auto-rebuild)

```bash
make watch        # Recompila o PDF automaticamente ao salvar
```

### Limpar artefatos

```bash
make clean
```

## Escrevendo Conteúdo

### Adicionando capítulos

Crie arquivos Markdown em `contents/` com prefixo numérico:

```
contents/001-introducao.md
contents/002-fundamentos.md
contents/003-avaliacao.md
contents/004-tratamento-farmacologico.md
```

Os arquivos são ordenados automaticamente pelo prefixo numérico.

### Citações bibliográficas

Adicione referências em `bibliography.bib` e cite no texto:

```markdown
A dor crônica afeta milhões de pessoas [@desouza2017].
```

### Imagens

Coloque imagens em `img/` e referencie no Markdown:

```markdown
![Descrição da figura](img/nome-do-arquivo.png){width=80%}
```

### Material preliminar e complementar

- Dedicatória, prefácio: adicione em `frontmatter/` com prefixo numérico
- Apêndices, glossário: adicione em `backmatter/` com prefixo numérico

Use `{.unnumbered}` para seções sem numeração:

```markdown
::: {.unnumbered}
# Prefácio
Texto do prefácio...
:::
```

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).
