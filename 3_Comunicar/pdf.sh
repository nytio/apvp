#!/bin/bash
#
# pdf.sh
# Genera documento pdf

pandoc \
    -f gfm \
    -t pdf \
    --dpi=300 \
    -V linkcolor:blue \
    -V geometry:letterpaper \
    -V geometry:margin=2cm \
    -V mainfont="DejaVu Serif" \
    -V monofont="DejaVu Sans Mono" \
    -o borrador`date +%y%m%d`.pdf \
    README.md

# Archivo de trabajo obtenido de:
# pandoc -f docx -t markdown borrador.docx -o borrador.md

# Otro formato de salida
# pandoc -s README.md -o tmp.odt