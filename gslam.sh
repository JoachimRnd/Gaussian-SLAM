#!/bin/bash
#SBATCH --job-name=GSLAM
#SBATCH --output=output/GSLAM.log
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=0-05:00:00
#SBATCH --partition=gpu
#SBATCH --gres=gpu:GeForceRTX3090:1

module load Python/3.10.8-GCCcore-12.2.0
module load CUDA/12.1.0
source ./venv-gslam/bin/activate

git clone https://github.com/eriksandstroem/evaluate_3d_reconstruction_lib.git Gaussian-SLAM/evaluate_3d_reconstruction_lib
pip install Gaussian-SLAM/evaluate_3d_reconstruction_lib

git clone https://github.com/JoachimRnd/simple-knn-Gaussian-SLAM.git Gaussian-SLAM/simple-knn-Gaussian-SLAM
pip install Gaussian-SLAM/simple-knn-Gaussian-SLAM

git clone https://github.com/VladimirYugay/gaussian_rasterizer.git Gaussian-SLAM/gaussian_rasterizer
pip install Gaussian-SLAM/gaussian_rasterizer

python Gaussian-SLAM/run_slam.py configs/Replica/room0.yaml --input_path ./data/Replica-SLAM/room0 --output_path output/Replica/room0
