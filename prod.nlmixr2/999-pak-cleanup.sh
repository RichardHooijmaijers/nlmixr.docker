#!/bin/bash
# Remove cache files
Rscript -e "pak::pak_cleanup(force = TRUE)"
