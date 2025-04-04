from setuptools import setup, Extension
from Cython.Build import cythonize

# Define the extensions (Cython modules)
extensions = [
    Extension("dual_autodiff_x.dual", ["dual_autodiff_x/dual.pyx"]),
]

setup(
    ext_modules=cythonize(extensions,
    compiler_directives={'language_level': "3"}),
    package_dir={"": "./"},
    packages=["dual_autodiff_x"],
    package_data={"dual_autodiff_x": ["*.so", "*.pyd"]},
    zip_safe=False,
)