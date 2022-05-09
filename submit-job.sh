if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [classification_identification 폴더 내의 script 이름]"
    exit 1
fi

# 작업 스크립트 작성.
cat << EOF > ./job.sh
#!/bin/bash

echo "### START DATE=\$(date)"
echo "### HOSTNAME=\$(hostname)"
echo "### CUDA_VISIBLE_DEVICES=\$CUDA_VISIBLE_DEVICES"

# conda 환경 활성화.
source  ~/.bashrc
conda activate py38-torch

# cuda 11.0 환경 구성.
ml purge
ml load cuda/11.0

# 활성화된 환경에서 코드 실행.
cd classification_identification
bash $1

echo "###"
echo "### END DATE=\$(date)"
EOF

# 작성된 작업 스크립트 확인.
cat ./job.sh

## --time=일-시간:분:초
sbatch  --gres=gpu:1  --time=3:00:00  ./job.sh