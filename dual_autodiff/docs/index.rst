dual_autodiff Package Documentation
========================================
| *Author*: `Haya Ejjawi`

The **dual_autodiff** package is designed for working with **dual numbers**, which are numbers of the form:

.. math::

    a + b\varepsilon

where:

- :math:`a`: The **real part**. 

- :math:`b`: The **dual part**. 

- :math:`\varepsilon`: An infinitesimal satisfying :math:`\varepsilon^2 = 0`.

The main `Dual` class in the package provides methods for:

- **Basic Arithmetic Operations**:

  - Addition, subtraction, multiplication, and division of dual numbers.

- **Trigonometric Functions**:

  - Sine, cosine, and tangent.

- **Other Mathematical Operations**:

  - Logarithms (base :math:`e`), exponentials, and integer powers of dual numbers.

- **Equality Testing**:

  - A method to check whether two dual numbers are equal.

In addition, the **dual_autodiff** package is a useful tool for **automatic differentiation**, a computational technique used to compute derivatives accurately and efficiently using the properties of dual numbers.


.. toctree::
   :maxdepth: 2
   :caption: Sections:

   rst/methods
   rst/example
   rst/notebook
     
Methods
-------
This section provides a detailed documentation for methods in the `Dual` class, including:

- Functionality.

- Examples of proper usage.

- Mathematical context, where applicable.

Each of the methods in the `Dual` class is documented as a subsection.

Tutorial
--------
This section includes a comprehensive tutorial notebook (`dual_autodiff.ipynb`) that demonstrates:

- Basic usage of the `dual_autodiff` package, covering a variety of cases, and a comparison between the performances of the pure python package and the cythonized package. 

Automatic Differentiation
-------------------------
Automatic differentiation is a computational technique used to compute derivatives efficiently and accurately. This section includes:

- Practical example illustrating the use of dual numbers for differentiation.

- Comparison between analytical, numerical, and automatic differentiation using dual numbers.

Example Usage
-------------
Here’s a quick example of how to use the `dual_autodiff` package:

.. code-block:: python

    from dual_autodiff.dual import Dual

    # Define a dual number
    x = Dual(2, 1)
    # Perform operations
    y = x * x + 3 * x + 5  # f(x) = x^2 + 3x + 5
    print(y.real)  # Output: 15 (function value)
    print(y.dual)  # Output: 7 (derivative f'(x) = 2x + 3 at x=2)

For more examples, check out the **Tutorial** and **Automatic Differentiation** sections.

Useful Resources and further reading
----------------------------------------
- `Wikipidea <https://en.wikipedia.org/wiki/Dual_number>`_

- `Automatic Differentiation <https://blog.demofox.org/2014/12/30/dual-numbers-automatic-differentiation/>`_

.. note::
  Research Computing Coursework - Mphil in Data Intensive Science.
  Department of Physics, University of Cambridge
