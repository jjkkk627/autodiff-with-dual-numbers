import math

class Dual:
    def __init__(self, real, dual=0.0):
        """
        Initialize a dual number. 

        Dual numbers are numbers of the form `a + bε`, where `a` is the real part 
        and `b` is the dual part, with ε being an infinitesimal satisfying ε²=0.

        Args:
          real (float): Real part of the dual number.

          dual (float): Dual part of the dual number (set to a default of zero).
        """
        self.real = real
        self.dual = dual

    def __repr__(self):
        """ 
        Provides a string representation of the dual number.

        Returns:
           str: A string in the format "Dual(real=<real>, dual=<dual>)".
        """
        return f"Dual(real={self.real}, dual={self.dual})"

    def __add__(self, other):
        """
        Adds two dual numbers or a dual number and a scalar.

        For two dual numbers, their real and dual parts are added respectively.
        For a scalar, it is added only to the real part of the dual number.

        Args:
            other (Dual or scalar): The dual number or scalar to add.

        Returns:
            Dual: A new 'Dual' instance representing the result of the sum.
        """
        if isinstance(other, Dual):
            return Dual(self.real + other.real, self.dual + other.dual)
        return Dual(self.real + other, self.dual)
    
    def __radd__(self, other):
        """
        Implements the reflected addition operation for dual numbers and scalars.

        This method allows the commutative property of addition between scalars and dual numbers,
        ensuring that (scalar + Dual) works the same way as (Dual + scalar).

        Args:
            other (scalar): The left hand operand of the summation.

        Returns:
            Dual: A new 'Dual' instance representing the result of the sum.
        """
        return self.__add__(other)
    
    def __iadd__(self, other):
        """
        Perform in-place addition (+=) with another dual number or a scalar.

        Args:
          other (Dual or float): The other dual number or scalar to add.

        Returns:
          Dual: The current dual number updated after the addition.
        """
        if isinstance(other, Dual):
            self.real += other.real
            self.dual += other.dual
        else:  # Scalar addition
            self.real += other
        return self

    def __sub__(self, other):
        """
        Subtracts two dual numbers or a dual number and a scalar.

        For two dual numbers, their real parts and dual parts are subtracted repectively.
        For a scalar, it is subtracted only from the real part of the dual number.

        Args:
            other (Dual or scalar): The dual or scalar to subtract.
        
        Returns:
            Dual: A new 'Dual' instance representing the result of the subtraction.
        """
        if isinstance(other, Dual):
            return Dual(self.real - other.real, self.dual - other.dual)
        return Dual(self.real - other, self.dual)
    
    def __rsub__(self, other):
        """
        Implements the reflected subtraction operation for dual numbers and scalars.

        This method allows for the operation (scalar - Dual).

        Args:
            other (scalar): A scalar that is the left hand operand of the subtraction.

        Returns:
            Dual: A new 'Dual' instance representing the result of the subtraction.
               
        """
        return Dual(other - self.real, -self.dual)
    
    def __isub__(self, other):
        """
        Perform in-place subtraction (-=) with another dual number or a scalar.

        Args:
           other (Dual or float): The other dual number or scalar to subtract.

        Returns:
           Dual: The current dual number updated after the subtraction.
        """
        if isinstance(other, Dual):
            self.real -= other.real
            self.dual -= other.dual
        else:  # Scalar subtraction
            self.real -= other
        return self


    def __mul__(self, other):
        """
        Multiplies two dual numbers or a dual number and a scalar.

        Args:
            other (Dual or scalar): The other operand in the multiplication. 

        Returns:
            Dual: A new 'Dual' instance representing the result of the multiplication.
        
        Notes:
            - When `other` is a dual number:

                - The real part of the result is the product of the real parts 
                  of both dual numbers.

                - The dual part of the result is the sum of the product of the 
                  real part of the first number with the dual part of the second 
                  and the product of the dual part of the first number with the 
                  real part of the second.

            - When `other` is a scalar:

                - Both the real and dual parts of the dual number are multiplied 
                  by the scalar.

        """
        if isinstance(other, Dual):
            real = self.real * other.real
            dual = self.real * other.dual + self.dual * other.real
            return Dual(real, dual)
        return Dual(self.real * other, self.dual * other)
    
    def __rmul__(self, other):
        """
        Implements the reflected multiplication operation for dual numbers and scalars.

        This method allows for the operation (scalar * Dual).

        Args:
            other (scalar): The left hand operand of the multiplication.

        Returns:
            Dual: A new 'Dual' instance representing the result of the multiplication.
        
        """

        return self.__mul__(other)
    
    def __imul__(self, other):
        """
        Perform in-place multiplication (*=) with another dual number or a scalar.

        Args:
           other (Dual or float): The other dual number or scalar to multiply.

        Returns:
           Dual: The current dual number updated after the multiplication.
        """
        if isinstance(other, Dual):
            new_real = self.real * other.real
            new_dual = self.real * other.dual + self.dual * other.real
            self.real = new_real
            self.dual = new_dual
        else:  # Scalar multiplication
            self.real *= other
            self.dual *= other
        return self
    
    def __truediv__(self, other):
        """
        Divides a dual number by another dual number or a scalar.

        This method implements the division operation for dual numbers. The 
        division is defined for dual numbers `a + bε` and `c + dε` (where ε² = 0),
        as well as for dividing a dual number by a scalar.

        Args:
            other (Dual or scalar): The divisor, which can be another `Dual` 
            object or a scalar (int or float).

        Returns:
            Dual: A new `Dual` object representing the result of the division.

        Raises:
            ZeroDivisionError: If the real part of the divisor `other` is zero 
            (for dual number division) or if `other` is zero (for scalar division).

        Notes:
            - When `other` is a dual number:

                - The real part of the result is `self.real / other.real`.

                - The dual part of the result is calculated as:

                `(self.dual * other.real - self.real * other.dual) / (other.real ** 2)`.

            - When `other` is a scalar:

                - Both the real and dual parts of the dual number are divided 
                  by the scalar.
         """

        if isinstance(other, Dual):
            if other.real == 0:
                raise ZeroDivisionError("Real part of dividend cannot be zero")
            real = self.real / other.real
            dual = (self.dual * other.real - self.real * other.dual) / (other.real ** 2)
            return Dual(real, dual)
        
        if other == 0:
            raise ZeroDivisionError("Division by Zero!")
        return Dual(self.real/other, self.dual/other) 
    
    def __rtruediv__(self, other):
        """
        Implements reflected division for dual numbers and scalars.

        This method allows for the operation (scalar / dual).

        Args:
            other (scalar): The dividend of the division operation.
        
        Returns:
             Dual: A new `Dual` instance representing the result of the division.
        
        Raises:
             ZeroDivisionError: If the real part of the divisor (`self`) is zero.
        
        Notes:
            - The real part of the result is calculated as `other / self.real`.

            - The dual part of the result is calculated as `-other * self.dual / (self.real ** 2)`.
        """
        if self.real == 0:
            raise ZeroDivisionError("Real part of divisor cannot be zero")
        real = other / self.real
        dual = -other * self.dual / (self.real ** 2)
        return Dual(real, dual)  
    
    def __itruediv__(self, other):
        """
        Perform in-place division (/=) with another dual number or a scalar.

        Args:
           other (Dual or float): The other dual number or scalar to divide by.

        Returns:
           Dual: The current dual number updated after the division.

        Raises:
           ZeroDivisionError: If the real part of the divisor is zero.
        """
        if isinstance(other, Dual):
            if other.real == 0:
                raise ZeroDivisionError("Division by a dual number with zero real part is undefined.")
            real_div = self.real / other.real
            dual_div = (self.dual * other.real - self.real * other.dual) / (other.real ** 2)
            self.real = real_div
            self.dual = dual_div
        else:  # Scalar division
            if other == 0:
                raise ZeroDivisionError("Division by zero is undefined.")
            self.real /= other
            self.dual /= other
        return self

    
    def inverse(self):
        """
        Computes the multiplicative inverse of the dual number.

        Returns:
            Dual: The multiplicative inverse of the current dual number.

        Raises:

            ZeroDivisionError: If the real part of the dual number is zero, 
                           the multiplicative inverse does not exist.
        
        Notes:
            For a dual number x = a + bε, the inverse is given by:
            x⁻¹ = (1 / a) - (b / a²)ε, provided a ≠ 0.
        """
        if self.real == 0:
            raise ZeroDivisionError("Cannot compute the inverse of a dual number with zero real part.")
        
        real_inv = 1 / self.real
        dual_inv = -self.dual / (self.real ** 2)
        return Dual(real_inv, dual_inv)
    
    def __neg__(self):
        """
        Perform unary negation (-) on the dual number.

        Returns:
           Dual: A new dual number with both the real and dual parts negated,
                 such that x + (-x) = 0.
        """
        return Dual(-self.real, -self.dual)

    def sin(self):
        """
        Computes the sine of a dual number.

        This method calculates the sine of the real part of the dual number and 
        the corresponding dual part. For a dual number `x = a + bε`, the sine is 
        defined as:

            sin(x) = sin(a) + b * cos(a)ε

        Returns:
            Dual: A new `Dual` object representing the sine of the dual number.

        Notes:
            - The real part of the result is `sin(self.real)`.

            - The dual part of the result is `self.dual * cos(self.real)`.
            
        """
        return Dual(math.sin(self.real), self.dual * math.cos(self.real))

    def cos(self):
        """
        Computes the cosine of a dual number.

        This method calculates the cosine of the real part of the dual number and 
        the corresponding dual part. For a dual number `x = a + bε`, the cosine is 
        defined as:

            cos(x) = cos(a) - b * sin(a)ε

        Returns:
            Dual: A new `Dual` object representing the cosine of the dual number.

        Notes:
            - The real part of the result is `cos(self.real)`.
            
            - The dual part of the result is `-self.dual * sin(self.real)`.
        """
        return Dual(math.cos(self.real), -self.dual * math.sin(self.real))
    
    def tan(self):
        """
        Computes the tangent of a dual number.

        This method calculates the tangent of the real part of the dual number and 
        the corresponding dual part. For a dual number `x = a + bε`, the tangent is 
        defined as:

            tan(x) = tan(a) + b * sec^2(a)ε

        Returns:
            Dual: A new `Dual` instance representing the tangent of the dual number.

        Raises:
            ZeroDivionError: If the cosine of the real part is zero (tangent undefined).

        Notes:
           - The real part of the resul is `tan(self.real)`.

           - The dual part of the result is `self.dual * sec^2(self.real)`.

           - tan(self.real) is not defined for self.real = π/2 + nπ (n an integer), i.e when cos(self.real) = 0.
        """

        if math.isclose(math.cos(self.real), 0, abs_tol=1e-9):
            raise ZeroDivisionError("Tangent is undefined when cosine of the real part is 0.")
        return Dual(math.tan(self.real), self.dual * (1 / math.cos(self.real) ** 2))

    def exp(self):
        """
        Computes the exponential of a dual number.

        For a dual number `x = a + bε`, the exponential is defined as:

           exp(x) = exp(a) + b * exp(a)ε

        Returns: 
            Dual: A new `Dual` instance representing the exponential of the dual number.

        Notes:
           - The real part of the result is `exp(self.real)`.

           - The dual part of the result is `self.dual * exp(self.real)`.

        """
        return Dual(math.exp(self.real), self.dual * math.exp(self.real))
    
    def log(self):
        """
        Computes the natural logarithm of a dual number.

        For a dual number `x = a + bε`, the natural logarithm is defined as:

            log(x) = log(a) + (b / a)ε

        Returns:
            Dual: A new `Dual` instance representing the natural logarithm of the dual number.

        Raises:
            ZeroDivisionError: If the real part of the dual number is less than or equal to zero.

        Notes:
           - The real part of the result is `log(self.real)`.

           - The dual part of the result is `self.dual / self.real`.
        """
        if self.real <= 0:
            raise ZeroDivisionError("Logarithm defined only for strictly positive real part.")
        return Dual(math.log(self.real), self.dual / self.real)
    
    def pow(self, n):
        """
        Computes the power of a dual number.

        For a dual number `x = a + bε` and a scalar power `n`, the power is defined as:

            x^n = a^n + n * a^(n-1) * bε

        Args:
            n (int): The integer power to which the dual number is raised.

        Returns:
            Dual: A new `Dual` instance representing the result of raising the dual number to the given power.

        Raises:
            TypeError: If `n` is not an integer.

            ValueError: If the operation is undefined due to:

                
                - Zero real part with power n < 0.

        Notes:

           - The real part of the result is `self.real^n`.


           - The dual part of the result is `n * self.real^(n-1) * self.dual`.
        """ 

        if not isinstance(n, int):  # Check if n is an integer
            raise TypeError("Power n must be an integer.")

        if self.real == 0 and n < 0:
            raise ZeroDivisionError("Power operation undefined for zero real part when n < 0.")
        
        real_part = self.real ** n
        dual_part = n * (self.real ** (n - 1)) * self.dual

        return Dual(real_part, dual_part)
        
    def __ipow__(self, other):
        """
        Perform in-place exponentiation (**=) for dual numbers.

        Args:
            other (integer): The power to raise the dual number to (must be an integer).

        Returns:
            Dual: The current dual number updated after exponentiation.
        
        Raises:
            TypeError: If `n` is not an integer. 

        """
        if isinstance(other, Dual):
            raise TypeError("Exponentiation of dual numbers by dual numbers or floating point numbers is not defined.")
        real_pow = self.real ** other
        dual_pow = other * (self.real ** (other - 1)) * self.dual
        self.real = real_pow
        self.dual = dual_pow
        return self

    def __eq__(self, other):
        """ 
        Checks equality between two dual numbers or a dual number and a scalar.

        Equality is defined as follows:

        - Two dual numbers `x1 = a + bε` and `x2 = c + dε` are equal if and only if:
          both their real and dual parts are equal: `a == c` and `b == d`.

        - A dual number `x = a + bε` and a scalar `s` are equal if and only if:
          `a == s` and `b == 0`.

        Args:

            other (Dual or scalar): The value to compare the dual number against.

        Returns:
        
            bool: Returns `True` if the dual number and `other` (dual number or scalar) are equal, otherwise `False`.
        """
        if isinstance(other, Dual):
            return self.real == other.real and self.dual == other.dual
        else:
            # Comparing with a scalar
            return self.real == other and self.dual == 0
    
