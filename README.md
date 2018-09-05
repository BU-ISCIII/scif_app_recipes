# SCIF APP RECIPES
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Scif](https://img.shields.io/badge/Filesystem-Scientific-brightgreen.svg)](https://sci-f.github.io)

This repository contains installation recipes for software usually used by BU-ISCIII. This recipes are meant to be used with Singularity/Docker recipe and [Scientific Filesystem](https://sci-f.github.io) (SCIF).

## Singularity/Docker base SO image
Each recipe has been build to work with only one base OS image. When choosing a base OS, keep in mind that newer OS versions may not be compatible with old kernels, and vice versa. For this reason, we recommend checking that the base OS image works on the systems you intent to use it on before starting developing repices for it.

Here we list all the images we have recipes for, followed by the command to download them. If you want to upload recipes for a new base, please add it to the list:
  - Centos 7: `docker://centos:7`

To work on a base image and test your installation steps while writting a recipe, you can download an interactive temporal image. For example, for Centos 7 you can achieve that with: `sudo singularity run -w docker://centos:7`

## How to develop a new recipe.

- **Mandatory fields** in scif recipe, the fields must contain as much information as possible:
  - %appinstall: use ENV variables with version for easy reading.
  - %apphelp
  - %applabel
  - %apprun
  - %apptest: in most of the cases just a installation comprobation with the version of the program.
  - %appfiles: scif recipes dependencies for software to be installed. All scif recipes will be located in ```/opt```

- **Nomenclature:** each recipe must be named with ```{SOFTWARE_NAME}_{VERSION}_{SO_VERSION}.scif```

- **Dependency check:** as software can share dependencies each time a new software is installed with ```scif install``` we have to check if the software has been already installed with another dependency or not. Also we have to check if lower, same or greater version has already installed.
In order to achieve this we have to include the below function in all software that need to install any dependency with scif:

```Bash
check_version() {
	RED='\033[0;31m'
	NC='\033[0m'
	GREEN='\033[0;32m'
	version=$1
	version_installed=$2
	program=$3
	if [[ "$version" > "$version_installed" ]];then
		echo -e "\n----------------------------------------------------------------------\n"
		echo -e "${RED}WARNING:${NC} $program version installed is lower than required for plasmidID. Check dependencies recipes, and/or change installation order. Omitting installation."
		echo -e "\n----------------------------------------------------------------------\n"
	elif [[ "$version" == "$version_installed" ]];then
		echo -e "\n----------------------------------------------------------------------\n"
		echo -e "${GREEN}INFO:${NC} Version of $program is already installed with same version, omitting."
		echo -e "\n----------------------------------------------------------------------\n"
	else
		echo -e "\n----------------------------------------------------------------------\n"
		echo -e "${GREEN}INFO:${NC} Version greater of $program is already installed, omitting."
		echo -e "\n----------------------------------------------------------------------\n"
	fi

}
```
Function accepts 3 arguments:
- Version of the software needed, you can find this information in the name of the recipe.
- Version already installed in the container.
- Name of the program for the warning message.

And we will used it this way in our %appinstall section:
```Bash
echo "Install samtools"
if [ ! -d /scif/apps/samtools ]; then
	scif install samtools_v1.9_centos7.scif
else
	ver=$(samtools --version | awk '/samtools/{print $2}')
	check_version "1.9" $ver "Samtools"
fi
```

Some times software does not provide a --version parameter, and the version is not included in the help. In those cases we can simply warn this situation like this:
```Bash
	if [ ! -d /scif/apps/trimmomatic ]; then
		scif install trimmomatic_v0.38_centos7.scif
	else
		echo "${RED}WARNING:${NC}There is a trimmomatic version already installed. You should check the other dependencies installed in order to check which version is installed."
	fi
```

>**NOTE**: dependency checks can fail when you compare version like this v2.7 > 2.8, you MUST check how --version outputs the version information and use equivalent comparison: pe. 2.7 > 2.6 or v2.7 > v2.6.
