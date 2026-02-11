# =============================================================================
# Makefile — Módulo Integrado de Dor
# Pipeline: Markdown → Pandoc → Typst/EPUB/HTML
# =============================================================================

# --- Configuração ---
BOOK_NAME    := modulo-integrado-de-dor
OUTPUT_DIR   := output
CONTENTS_DIR := contents
FRONT_DIR    := frontmatter
BACK_DIR     := backmatter
TEMPLATE     := templates/book.typ
METADATA     := metadata.yaml
BIB          := bibliography.bib

# --- Detectar arquivos fonte (ordenados por prefixo numérico) ---
FRONTMATTER := $(sort $(wildcard $(FRONT_DIR)/*.md))
CHAPTERS    := $(sort $(wildcard $(CONTENTS_DIR)/*.md))
BACKMATTER  := $(sort $(wildcard $(BACK_DIR)/*.md))
ALL_SOURCES := $(FRONTMATTER) $(CHAPTERS) $(BACKMATTER)
IMAGES      := $(wildcard img/*)

# --- Arquivos de saída ---
TYP_FILE  := $(OUTPUT_DIR)/$(BOOK_NAME).typ
PDF_FILE  := $(OUTPUT_DIR)/$(BOOK_NAME).pdf
EPUB_FILE := $(OUTPUT_DIR)/$(BOOK_NAME).epub
HTML_FILE := $(OUTPUT_DIR)/$(BOOK_NAME).html

# --- Argumentos comuns do Pandoc ---
PANDOC_ARGS := \
	--metadata-file=$(METADATA) \
	--resource-path=.:img \
	--citeproc \
	--bibliography=$(BIB)

# --- Argumentos Typst (PDF) ---
PANDOC_TYPST_ARGS := \
	--to=typst \
	-V template=$(TEMPLATE) \
	--number-sections

# --- Argumentos EPUB ---
PANDOC_EPUB_ARGS := \
	--to=epub3 \
	--toc \
	--toc-depth=3 \
	--number-sections \
	--epub-chapter-level=1

# --- Argumentos HTML ---
PANDOC_HTML_ARGS := \
	--to=html5 \
	--standalone \
	--toc \
	--toc-depth=3 \
	--number-sections \
	--katex

# =============================================================================
# Targets
# =============================================================================

.PHONY: all pdf epub html typ clean watch help

## Gerar todos os formatos
all: pdf epub html

## Gerar PDF via Typst
pdf: $(PDF_FILE)

## Gerar arquivo Typst intermediário
typ: $(TYP_FILE)

## Gerar EPUB
epub: $(EPUB_FILE)

## Gerar HTML
html: $(HTML_FILE)

# --- Regras de build ---

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Passo 1: Markdown → Typst (.typ) via Pandoc
$(TYP_FILE): $(ALL_SOURCES) $(METADATA) $(TEMPLATE) $(BIB) | $(OUTPUT_DIR)
	pandoc $(ALL_SOURCES) \
		$(PANDOC_ARGS) \
		$(PANDOC_TYPST_ARGS) \
		--output=$(TYP_FILE)
	@echo ">>> Typst gerado: $(TYP_FILE)"

# Passo 2: Typst (.typ) → PDF
$(PDF_FILE): $(TYP_FILE) $(IMAGES)
	typst compile $(TYP_FILE) $(PDF_FILE) --root .
	@echo ">>> PDF gerado: $(PDF_FILE)"

# EPUB: Markdown → EPUB via Pandoc
$(EPUB_FILE): $(ALL_SOURCES) $(METADATA) $(BIB) | $(OUTPUT_DIR)
	pandoc $(ALL_SOURCES) \
		$(PANDOC_ARGS) \
		$(PANDOC_EPUB_ARGS) \
		--output=$(EPUB_FILE)
	@echo ">>> EPUB gerado: $(EPUB_FILE)"

# HTML: Markdown → HTML via Pandoc
$(HTML_FILE): $(ALL_SOURCES) $(METADATA) $(BIB) | $(OUTPUT_DIR)
	pandoc $(ALL_SOURCES) \
		$(PANDOC_ARGS) \
		$(PANDOC_HTML_ARGS) \
		--output=$(HTML_FILE)
	@echo ">>> HTML gerado: $(HTML_FILE)"

## Remover artefatos de build
clean:
	rm -rf $(OUTPUT_DIR)
	@echo ">>> Diretório output/ removido"

## Observar mudanças e recompilar PDF automaticamente
watch:
	@echo "Observando mudanças... (Ctrl+C para parar)"
	@if command -v fswatch > /dev/null 2>&1; then \
		fswatch -o $(CONTENTS_DIR) $(FRONT_DIR) $(BACK_DIR) $(METADATA) $(TEMPLATE) $(BIB) \
		| while read; do \
			echo "--- Recompilando PDF ---"; \
			$(MAKE) pdf; \
		done; \
	elif command -v inotifywait > /dev/null 2>&1; then \
		while true; do \
			inotifywait -qre modify,create,delete \
				$(CONTENTS_DIR) $(FRONT_DIR) $(BACK_DIR) $(METADATA) $(TEMPLATE) $(BIB); \
			echo "--- Recompilando PDF ---"; \
			$(MAKE) pdf; \
		done; \
	else \
		echo "Erro: instale fswatch ou inotify-tools para o modo watch"; \
		exit 1; \
	fi

## Exibir targets disponíveis
help:
	@echo "Módulo Integrado de Dor — Build System"
	@echo "======================================="
	@echo ""
	@echo "Targets:"
	@echo "  make all     - Gerar PDF, EPUB e HTML"
	@echo "  make pdf     - Gerar PDF via Typst"
	@echo "  make epub    - Gerar EPUB"
	@echo "  make html    - Gerar HTML"
	@echo "  make typ     - Gerar arquivo .typ intermediário"
	@echo "  make clean   - Remover artefatos de build"
	@echo "  make watch   - Observar mudanças e recompilar PDF"
	@echo "  make help    - Exibir esta mensagem"
	@echo ""
	@echo "Pré-requisitos: pandoc (>=3.0), typst (>=0.12), make"
