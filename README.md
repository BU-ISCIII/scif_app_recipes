# SCIF APP RECIPES
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Scif](https://img.shields.io/badge/Filesystem-Scientific-brightgreen.svg)](https://sci-f.github.io)

This repository contains installation recipes for software usually used by BU-ISCIII. This recipes are meant to be used with Singularity/Docker recipe and [Scientific Filesystem](https://sci-f.github.io) (SCIF).

## How to develop a new recipe.

- **Mandatory fields** in scif recipe, the fields must contain as much information as possible:
  - %appinstall: use ENV variables with version for easy reading.
  - %apphelp
  - %applabel
  - %apprun
  - %apptest: in most of the cases just a installation comprobation with the version of the program.

- **Nomenclature:** each recipe must be named with ```{SOFTWARE_NAME}_{VERSION}_{SO_VERSION}.scif```
