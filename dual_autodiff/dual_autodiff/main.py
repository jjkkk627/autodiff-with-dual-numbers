# main.py
from dual_autodiff.dual import Dual

def main():
    print("This is the dual_autodiff package.")
    # Initialize and display a Dual object for demonstration
    d = Dual(3, 4)
    print(f"Dual number: {d}")
