import pytest
import math
from dual_autodiff.dual import Dual  # Import the Dual class

# Test initialization
def test_dual_initialization():
    # Test case 1: Integer initialization
    x = Dual(2, 3)
    assert x.real == 2, f"Expected real part to be 2, but got {x.real}"
    assert x.dual == 3, f"Expected dual part to be 3, but got {x.dual}"

    # Test case 2: Floating-point initialization
    y = Dual(2.5, -1.5)
    assert y.real == 2.5, f"Expected real part to be 2.5, but got {y.real}"
    assert y.dual == -1.5, f"Expected dual part to be -1.5, but got {y.dual}"

    # Test case 3: Default dual part (zero)
    z = Dual(4)
    assert z.real == 4, f"Expected real part to be 4, but got {z.real}"
    assert z.dual == 0.0, f"Expected dual part to be 0.0, but got {z.dual}"

    # Test case 4: Zero initialization
    w = Dual(0, 0)
    assert w.real == 0, f"Expected real part to be 0, but got {w.real}"
    assert w.dual == 0, f"Expected dual part to be 0, but got {w.dual}"

# Test representation
def test_dual_representation():
    # Test case 1: Integer real and dual parts
    x = Dual(2, 3)
    assert repr(x) == "Dual(real=2, dual=3)", f"Expected 'Dual(real=2, dual=3)', got {repr(x)}"

    # Test case 2: Floating-point real and dual parts
    y = Dual(2.5, -1.5)
    assert repr(y) == "Dual(real=2.5, dual=-1.5)", f"Expected 'Dual(real=2.5, dual=-1.5)', got {repr(y)}"

    # Test case 3: Zero dual part
    z = Dual(4.0, 0.0)
    assert repr(z) == "Dual(real=4.0, dual=0.0)", f"Expected 'Dual(real=4.0, dual=0.0)', got {repr(z)}"

# Test addition
def test_dual_add_sub():
    # Test case 1: Addition of two dual numbers 
    x = Dual(2, 3)
    y = Dual(4, 5)
    result = x + y
    assert result.real == 6, f"Expected real part to be 6, but got {result.real}"
    assert result.dual == 8, f"Expected dual part to be 8, but got {result.dual}"

    # Test case 2: Addition of a dual number with a scalar
    z = Dual(5, 3)
    scalar = 10
    result = z + scalar
    assert result.real == 15, f"Expected real part to be 15, but got {result.real}"
    assert result.dual == 3, f"Expected dual part to be 3, but got {result.dual}"

    # Test case 3: Scalar on the left side
    result = scalar + z
    assert result.real == 15, f"Expected real part to be 15, but got {result.real}"
    assert result.dual == 3, f"Expected dual part to be 3, but got {result.dual}"

    # Test case 4: Addition of two dual numbers with zero dual part
    x_zero = Dual(7, 0)
    y_zero = Dual(3, 0)
    result = x_zero + y_zero
    assert result.real == 10, f"Expected real part to be 10, but got {result.real}"
    assert result.dual == 0, f"Expected dual part to be 0, but got {result.dual}"

    # Test case 6: Subtraction of two dual numbers
    result = x-y 
    assert result.real == -2, f"Expected real part to be -2, but got {result.real}"
    assert result.dual == -2, f"Expected dual part to be -2, but got {result.dual}"

# Test multiplication
def test_dual_mult_div():
    # Test case 1: Multiplication of two dual numbers
    x = Dual(2, 4)
    y = Dual(3, 5)
    result = x * y
    assert result.real == 6, f"Expected real part to be 6, but got {result.real}"
    assert result.dual == 22, f"Expected dual part to be 22, but got {result.dual}"

    # Test case 2: Multiplication of a dual number with a scalar
    z = Dual(2, 3)
    scalar = 5
    result = z * scalar
    assert result.real == 10, f"Expected real part to be 10, but got {result.real}"
    assert result.dual == 15, f"Expected dual part to be 15, but got {result.dual}"

    # Test case 3: Scalar multiplication (commutative property)
    result = scalar * z
    assert result.real == 10, f"Expected real part to be 10, but got {result.real}"
    assert result.dual == 15, f"Expected dual part to be 15, but got {result.dual}"

    # Test case 4: Multiplication with zero 
    zero_dual = Dual(0, 0)
    result = x * zero_dual
    assert result.real == 0, f"Expected real part to be 0, but got {result.real}"
    assert result.dual == 0, f"Expected dual part to be 0, but got {result.dual}"

    # Test case 5: Division of two dual numbers
    result = x/y
    # Check real part
    assert math.isclose(result.real, 2/3, abs_tol=1e-10), (f"Expected real part to be 2/3, but got {result.real}")
    
    # Check dual part
    expected_dual = (x.dual * y.real - x.real * y.dual) / (y.real ** 2)
    assert math.isclose(result.dual, expected_dual, abs_tol=1e-10), (f"Expected dual part to be {expected_dual}, but got {result.dual}")

    # Test case 6: Division by zero raises ZeroDivisionError
    with pytest.raises(ZeroDivisionError):
        x / Dual(0, 0)

    with pytest.raises(ZeroDivisionError):
        z / 0

# Test sine function
def test_dual_sin():
    # Test case 1: Standard dual number
    x = Dual(1, 2)
    result = x.sin()
    assert math.isclose(result.real, math.sin(1), abs_tol=1e-10), (
        f"Expected real part to be {math.sin(1)}, but got {result.real}"
    )
    assert math.isclose(result.dual, 2 * math.cos(1), abs_tol=1e-10), (
        f"Expected dual part to be {2*math.cos(1)}, but got {result.dual}"
    )

    # Test case 2: Zero real part
    dual_zero = Dual(0, 1)
    sin_zero = dual_zero.sin()
    assert math.isclose(sin_zero.real, 0.0, abs_tol=1e-10), (
        f"Expected real part to be 0.0, but got {sin_zero.real}"
    )
    assert math.isclose(sin_zero.dual, 1.0, abs_tol=1e-10), (
        f"Expected dual part to be 1.0, but got {sin_zero.dual}"
    )

    # Test case 3: Negative real part
    dual_negative = Dual(-1, 1)
    sin_negative = dual_negative.sin()
    assert math.isclose(sin_negative.real, math.sin(-1), abs_tol=1e-10), (
        f"Expected real part to be {math.sin(-1)}, but got {sin_negative.real}"
    )
    assert math.isclose(sin_negative.dual, math.cos(-1), abs_tol=1e-10), (
        f"Expected dual part to be {math.cos(-1)}, but got {sin_negative.dual}"
    )

# Test cosine function
def test_dual_cos():
    # Test case 1: Standard dual number
    x = Dual(1, 2)
    result = x.cos()
    assert math.isclose(result.real, math.cos(1), abs_tol=1e-10), (
        f"Expected real part to be {math.cos(1)}, but got {result.real}"
    )
    assert math.isclose(result.dual,2 * -math.sin(1), abs_tol=1e-10), (
        f"Expected dual part to be {2 * -math.sin(1)}, but got {result.dual}"
    )
    

# Test natural logarithm function
def test_dual_log():
    # Test Case 1: Standard dual number
    x = Dual(2, 1)
    result = x.log()
    assert math.isclose(result.real, math.log(2), abs_tol=1e-10)
    assert math.isclose(result.dual, 1 / 2, abs_tol=1e-10)

    # Test case 2: Undefined Case: Zero real part
    with pytest.raises(ZeroDivisionError):
        x_zero = Dual(0, 1)  # A Dual number where the real part is 0
        x_zero.log()

def test_dual_inplace():
    # Test case 1: Addition assignment operator (+=)
    x = Dual(2, 3)
    x += Dual(1, 2)
    assert x.real == 3, f"Expected real part to be 3, but got {x.real}"
    assert x.dual == 5, f"Expected dual part to be 5, but got {x.dual}"

    # Test case 2: Subtraction assignment operator (-=)
    x = Dual(2, 3)
    x -= Dual(1, 2)
    assert x.real == 1, f"Expected real part to be 1, but got {x.real}"
    assert x.dual == 1, f"Expected dual part to be 1, but got {x.dual}"

    # Test case 3: Multiplication assignment operator (*=)
    x = Dual(2, 3)
    x *= 2
    assert x.real == 4, f"Expected real part to be 4, but got {x.real}"
    assert x.dual == 6, f"Expected dual part to be 6, but got {x.dual}"

    # Test case 4: Division assignment operator (/=)
    x = Dual(2, 3)
    x /= 2
    assert x.real == 1, f"Expected real part to be 1, but got {x.real}"
    assert x.dual == 1.5, f"Expected dual part to be 1.5, but got {x.dual}"

    # Test case 5: In-place power (**=)
    x = Dual(2, 3)
    x **= 3  # Raise x to the power of 3
    assert x.real == 8, f"Expected real part to be 8, but got {x.real}"
    assert x.dual == 36, f"Expected dual part to be 24, but got {x.dual}"

    # Test case 6: In-place power with negative exponent
    x = Dual(2, 3)
    x **= -1  # Raise x to the power of -1
    assert math.isclose(x.real, 1/2, abs_tol=1e-10), f"Expected real part to be 1/2, but got {x.real}"
    assert math.isclose(x.dual, -3/4, abs_tol=1e-10), f"Expected dual part to be -3/4, but got {x.dual}"
    

    # Test case 9: Exponentiation with zero real part and negative exponent raises ZeroDivisionError
    x = Dual(0, 3)
    
    # Expecting ZeroDivisionError when exponentiating with a zero real part
    with pytest.raises(ZeroDivisionError):
        x **= -1

def test_final():
    print("All tests passed successfully.")



