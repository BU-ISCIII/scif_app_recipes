#!/bin/bash
set -e

find /scif/apps -maxdepth 2 -name "bin" | while read in; do echo "export PATH=\${PATH}:$in" >> /opt/path_export ;done
find /scif/apps -maxdepth 2 -name "lib" | while read in; do echo "export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:$in" >> /opt/ld_library_export ;done

source /opt/path_export
source /opt/ld_library_export

## Custom parameters needed for some software.
if [[ ":$PATH:" == *":/scif/apps/snppipeline:"* ]];then
	export CLASSPATH=~/scif/apps/varscan/varscan-2.3.9/varscan-2.3.9.jar:$CLASSPATH >> $SINGULARITY_ENVIRONMENT
	export CLASSPATH=~/scif/apps/picard/picard.jar:$CLASSPATH >> $SINGULARITY_ENVIRONMENT
	export CLASSPATH=~/scif/apps/gatk/gatk-3.8/GenomeAnalysisTK.jar:$CLASSPATH >> $SINGULARITY_ENVIRONMENT
fi

exec "$@"
