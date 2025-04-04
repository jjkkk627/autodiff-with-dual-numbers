import os
import sys
import sphinx_rtd_theme


project = 'Dual Numbers Package'
copyright = '2024, Haya Ejjawi'
author = 'Haya Ejjawi'
release = '0.1.0'



sys.path.insert(0, os.path.abspath(os.path.join("..")))


extensions = [
    'sphinx.ext.autodoc',           # Automatically extracts documentation from docstrings
    'sphinx.ext.napoleon',          # Supports Google and NumPy-style docstrings
    'sphinx.ext.viewcode',          # Links to source code
    'sphinx.ext.mathjax',           # Renders LaTeX math
    'nbsphinx',                     # Jupyter notebook support       
    #'myst-parser',      
    'sphinx_gallery.load_style'   # Gallery styling
]

napoleon_google_docstring = True
napoleon_numpy_docstring = True


templates_path = []
hhtml_static_path = []


exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']


html_theme = 'sphinx_rtd_theme'
html_theme_options = {
    'collapse_navigation': False, 
    'sticky_navigation': True,    
    'navigation_depth': 4,      
    'titles_only': False,         
}

autodoc_default_options = {
    'members': True,           
    'undoc-members': False,    
    'show-inheritance': True,  
}


nbsphinx_kernel_name = 'python3'  
highlight_language = 'python3'   
nbsphinx_execute_arguments = [
    "--InlineBackend.figure_formats={'svg', 'pdf'}",
    "--InlineBackend.rc={'figure.dpi': 96}",
]


myst_enable_extensions = [
    "dollarmath",    
    "amsmath",       
]


mathjax3_config = {
    'tex': {
        'macros': {
            'RR': '{\\mathbb{R}}',  
        }
    }
}


master_doc = 'index'  
secnumber_suffix = ''  
autodoc_default_flags = ['members', 
'undoc-members'
]
autodoc_default_options = {
    'members':True,       
# Includibng all Dual class members
    'special-members':
    '__init__,__repr__,__add__,__radd__,__iadd__,__sub__,__rsub__,__isub__,__mul__,__rmul__,__imul__,__truediv__,__rtruediv__,__itruediv__,inverse, __neg__,cos,sin,tan,__pow__,__ipow__,__eq__'
,  

    'undoc-members': True,   

    'show-inheritance': True 

}
autodoc_member_order = 'bysource'