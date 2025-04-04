# Dual Automatic Differentiation Package 

The **dual_autodiff** is a Python package that performs operations on dual numbers and can be leveraged to perform automatic differentiation using dual numbers.

The **dual_autodiff_x** is the Cythonized version of the **dual_autodiff** package, to which two wheels are provided in the `wheels`folder.
- The wheels are for Python versions 3.10 and 3.11 on a 64-bit Linux platform.

## First Step 

Install the required packages for running tests and building documentation in the `requirements.txt` file with:

 ```bash
 pip install -r requirements.txt
 ```


## Installation

To install the package, follow these steps. Ensure you have Python 3.9 or higher installed. 

1- **Upgrade `pip`**: Ensure you have the latest version of pip 24.3.1 installed in your environment.
    You can upgrade pip by running the command:

 ```bash
 pip install --upgrade pip
 ```

2- **Install the Package**: Install the package in editable mode and all its dependencies from inside package folder by running:

 ```bash
 pip install -e .
 ```
3- **Verify Installation**: Open a Python 3.9 (or higher) session and import the package: 
 ```python 
 import dual_autodiff as df 
 ```
 Or 
 ```python 
 from dual_autodiff.dual import Dual
 ```

You can install the dual_autodiff_x from within the `wheels` folder with:

```bash 
pip install dual_autodiff_x_ <name_of_wheel>.whl
```

## Tests 

The file `test_dual.py` located in the `tests` folder contains a number of tests. To run tests, run the following command from the `dual_autodiff` package folder:

```bash
pytest -s tests/*
```

## Documentation

A Sphinx documentation was used to generate the documentation for the `dual_autodiff` package. After having installed the package, you can view documentation by unzipping the `build` folder inside the `dual_autodiff` package or by directly generating the html documentation page by running the following command from the `docs` folder (within `dual_autodiff` package folder): 

```bash
make clean
make html
```

The documentation can be viewed by opening `docs/build/html/index.html` in a web browser. Additionally, Pandoc is required to convert `.ipynb` Jupyter notebooks into documentation format.

## Tutorial notebook

The `dual_autodiff.ipynb` Jupyter notebook located in `docs` folder, includes a tutorial on how to use the `dual_autodiff` package, as well as a comparison between the pure Python package and its Cythonized version `dual_autodiff_x`.

## Question_5 Notebook

The Jupyter notebook `Question_5.ipynb` located in `docs` folder provides a worked example on how to use dual numbers in automatic differentiation. It offers a comparison between the analytical derivative, numerical derivative, and automatic differentiation using dual numbers.

## Report 

- The report is located in the `report` folder.

## Usage
The package allows you to define dual numbers and perform various operations. Here is an example:

```python
from dual_autodiff.dual import Dual

x = Dual(2, 1)    # Dual number: real=2, dual=1
y = Dual(3, 2)    # Dual number: real=3, dual=2

print(x)          # Dual(real=2, dual=1)
print(x.real)     # Output: 2
print(x + y)      # Addition: Dual(real=5, dual=3)
print(x * y)      # Multiplication: Dual(real=6, dual=7)
print(x.sin())    # Output: Dual(real=0.909297, dual=-0.416147)

```
## Declaration of Use of AI Tools

No auto-generation tools were used for developing code in this project. 