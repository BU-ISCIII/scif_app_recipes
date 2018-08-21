# SCIF APP RECIPES
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Scif](https://img.shields.io/badge/Filesystem-Scientific-brightgreen.svg)](https://sci-f.github.io)

This repository contains installation recipes for software usually used by BU-ISCIII. This recipes are meant to be used with Singularity/Docker recipe and [Scientific Filesystem](https://sci-f.github.io) (SCIF).

## Singularity/Docker base SO image
Each recipe has been build to work with only one base OS image. When choosing a base OS, keep in mind that newer OS versions may not be compatible with old kernels, and vice versa. For this reason, we recommend checking that the base OS image works on the systems you intent to use it on before starting developing repices for it.

Here we list all the images we have recipes for, followed by the command to download them. If you want to upload recipes for a new base, please add it to the list:
  - Centos 7: `singularity pull docker://centos:7
`

## How to develop a new recipe.

- **Mandatory fields** in scif recipe, the fields must contain as much information as possible:
  - %appinstall: use ENV variables with version for easy reading.
  - %apphelp
  - %applabel
  - %apprun
  - %apptest: in most of the cases just a installation comprobation with the version of the program.

- **Nomenclature:** each recipe must be named with ```{SOFTWARE_NAME}_{VERSION}_{SO_VERSION}.scif```
