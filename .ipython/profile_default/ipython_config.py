# Configuration file for ipython.

# A list of dotted module names of IPython extensions to load.
c.InteractiveShellApp.extensions = [
    'autoreload'
]
# Set default autoreload to mode '1' (autoreload anything loaded with aimport)
c.InteractiveShellApp.exec_lines = [
    '%autoreload 1'
]
