#!/bin/bash

echo "Creating Conda environment: NVSExtracter"
conda create -n NVSExtracter python=3.10 -y
conda activate NVSExtracter

echo "Installing NumPy (compatible version)"
pip install numpy==1.26.4

echo "Installing PyTorch with hardware detection..."

# Detect MPS (Apple Silicon)
if python - <<EOF
import torch
import platform
import sys
is_mac = sys.platform == "darwin"
is_arm = platform.machine() == "arm64"
print("YES" if is_mac and is_arm else "NO")
EOF
then
    echo "Apple Silicon detected → Installing torch with MPS support"
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu-mps
else
    echo "Installing CPU-only PyTorch"
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
fi

echo "Installing Ultralytics YOLO..."
pip install ultralytics==8.3.0

echo "Installing tracking + utilities..."
pip install deep-sort-realtime opencv-python pandas matplotlib tqdm scikit-image

echo "Done! Activate environment using:"
echo "    conda activate NVSExtracter"


# chmod +x install_env.sh
# ./install_env.sh