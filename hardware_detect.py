import torch
import platform
import sys

print("\n===== HARDWARE DETECTION =====\n")

# Check CUDA
if torch.cuda.is_available():
    print("CUDA GPU detected!")
    print("→ Use device='cuda'")
else:
    print("No CUDA GPU available.")

# Check for Apple Silicon M1/M2/M3
is_mac = sys.platform == "darwin"
is_arm = platform.machine() == "arm64"

if is_mac and is_arm:
    if torch.backends.mps.is_available():
        print("Apple Silicon MPS detected!")
        print("→ Use device='mps'")
    else:
        print("Mac ARM detected, but MPS is not available.")
else:
    print("Not running on Apple Silicon.")

# Fallback
print("\nIf neither CUDA nor MPS is available:")
print("→ Use device='cpu'")

print("\nRecommended device for your system is above.\n")

# python hardware_detect.py