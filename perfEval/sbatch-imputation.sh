#!/bin/sh

#SBATCH -A hyperbio
#SBATCH -t 168:00:00
#SBATCH -N 1
#SBATCH -n 24
#SBATCH -p slurm7
#SBATCH -J imput
#SBATCH -o imput.log
#SBATCH -e imput.err


module purge
module load python/anaconda3.2019.3
source /share/apps/python/anaconda3.2019.3/etc/profile.d/conda.sh
conda init zsh
conda activate omics

export PATH=/people/feng626/.conda/envs/omics/bin:$PATH

export PATH=/people/feng626/.nvm/versions/node/v15.8.0/bin:$PATH

module load singularity/3.6.3

export SINGULARITY_HOME=/pic/scratch/feng626/.singularity
export SINGULARITYENV_HOME=/pic/scratch/feng626/.singularity
export SINGULARITY_CACHEDIR=/pic/scratch/feng626/.singularity/cache
export SINGULARITYENV_CACHEDIR=/pic/scratch/feng626/.singularity/cache
export SINGULARITY_TMPDIR=/pic/scratch/feng626/.singularity/tmp
export SINGULARITYENV_TMPDIR=/pic/scratch/feng626/.singularity/tmp
export CWL_SINGULARITY_CACHE=/pic/scratch/feng626/.singularity/cwl

export XDG_RUNTIME_DIR=/pic/scratch/feng626/tmp

cd /pic/scratch/feng626/proteomicsTumorDeconv/perfEval

#toil-cwl-runner --singularity --outdir ./fig4-3 --workDir /pic/scratch/feng626/proteomicsTumorDeconv/perfEval/working --tmpdir-prefix /pic/scratch/feng626/proteomicsTumorDeconv/perfEval/tmp/runtime  scatter-imputation.cwl fig4-eval.yml
cwltool --singularity --outdir /pic/scratch/feng626/proteomicsTumorDeconv/perfEval/fig4 --tmpdir-prefix /pic/scratch/feng626/proteomicsTumorDeconv/perfEval/tmp/runtime --basedir /pic/scratch/feng626/proteomicsTumorDeconv/perfEval --cachedir .cache scatter-imputation.cwl fig4-test.yml

