// templates/book.typ
// Modelo Typst minimalista para livro acadêmico
// Compatível com Pandoc (exporta função `conf`)

#let conf(
  title: none,
  subtitle: none,
  authors: (),
  date: none,
  abstract: none,
  cols: 1,
  margin: (:),
  paper: "a4",
  lang: "pt",
  region: "BR",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  doc,
) = {

  // ---- Configuração da página ----
  set page(
    paper: paper,
    margin: if margin != (:) { margin } else {
      (left: 2.5cm, right: 2cm, top: 2.5cm, bottom: 2.5cm)
    },
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        let headings = query(heading.where(level: 1).before(here()))
        let current-chapter = if headings.len() > 0 {
          headings.last().body
        } else { none }

        if current-chapter != none {
          set text(size: 9pt, style: "italic", fill: luma(100))
          if calc.odd(page-num) {
            h(1fr) + current-chapter + h(0.5em)
          } else {
            h(0.5em) + current-chapter + h(1fr)
          }
          v(-0.3em)
          line(length: 100%, stroke: 0.4pt + luma(180))
        }
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        set text(size: 9pt, fill: luma(100))
        align(center)[#counter(page).display("1")]
      }
    },
  )

  // ---- Idioma e tipografia ----
  set text(
    lang: lang,
    region: region,
    font: if font != () { font } else { "Libertinus Serif" },
    size: fontsize,
    hyphenate: true,
  )

  // ---- Parágrafos ----
  set par(
    leading: 0.7em,
    first-line-indent: 1.5em,
    justify: true,
  )

  // ---- Estilos de heading ----

  // Nível 1: Capítulos
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(3cm)
    set text(size: 24pt, weight: "bold", fill: luma(40))
    if sectionnumbering != none {
      text(
        size: 14pt,
        weight: "regular",
        fill: luma(120),
      )[Capítulo #counter(heading).display()]
      v(0.3em)
    }
    it.body
    v(1.5cm)
  }

  // Nível 2: Seções
  show heading.where(level: 2): it => {
    v(1.2em)
    set text(size: 16pt, weight: "bold", fill: luma(50))
    if sectionnumbering != none {
      counter(heading).display(sectionnumbering)
      h(0.5em)
    }
    it.body
    v(0.6em)
  }

  // Nível 3: Subseções
  show heading.where(level: 3): it => {
    v(0.8em)
    set text(size: 13pt, weight: "bold", style: "italic", fill: luma(60))
    if sectionnumbering != none {
      counter(heading).display(sectionnumbering)
      h(0.5em)
    }
    it.body
    v(0.4em)
  }

  // ---- Numeração de seções ----
  if sectionnumbering != none {
    set heading(numbering: sectionnumbering)
  }

  // ---- Links ----
  show link: set text(fill: rgb("#2B579A"))

  // ---- Citações em bloco ----
  set quote(block: true)
  show quote: it => {
    set text(style: "italic", size: 10pt)
    block(
      width: 100%,
      inset: (left: 1.5em, y: 0.5em),
      stroke: (left: 2pt + luma(180)),
      it,
    )
  }

  // ---- Legendas de figuras ----
  show figure.caption: it => {
    set text(size: 9pt, style: "italic")
    it
  }

  // ---- Blocos de código ----
  show raw.where(block: true): it => {
    set text(size: 9pt)
    block(
      width: 100%,
      fill: luma(245),
      inset: 8pt,
      radius: 3pt,
      it,
    )
  }

  // ---- Tabelas ----
  set table(
    inset: 6pt,
    stroke: 0.5pt + luma(200),
  )
  show table.cell.where(y: 0): set text(weight: "bold")

  // ============================================
  // PÁGINA DE TÍTULO
  // ============================================
  {
    set page(header: none, footer: none, numbering: none)
    v(4cm)
    align(center)[
      #set text(size: 28pt, weight: "bold", fill: luma(30))
      #title
    ]
    if subtitle != none {
      v(0.5cm)
      align(center)[
        #set text(size: 16pt, style: "italic", fill: luma(80))
        #subtitle
      ]
    }
    v(2cm)
    if authors.len() > 0 {
      align(center)[
        #for author in authors {
          let name = if type(author) == dictionary { author.name } else { author }
          text(size: 14pt, fill: luma(60))[#name]
          linebreak()
          if type(author) == dictionary and "affiliation" in author {
            text(size: 11pt, style: "italic", fill: luma(100))[#author.affiliation]
            linebreak()
          }
        }
      ]
    }
    v(1fr)
    if date != none {
      align(center)[
        #set text(size: 12pt, fill: luma(100))
        #date
      ]
    }
    v(2cm)
  }

  // ============================================
  // SUMÁRIO
  // ============================================
  if toc {
    pagebreak()
    set page(header: none, footer: none)
    v(2cm)
    align(center)[
      #set text(size: 20pt, weight: "bold")
      #if toc_title != none { toc_title } else { "Sumário" }
    ]
    v(1cm)
    outline(
      depth: if toc_depth != none { toc_depth } else { 3 },
      indent: 1.5em,
    )
  }

  // ============================================
  // CORPO DO DOCUMENTO
  // ============================================
  counter(page).update(1)

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
