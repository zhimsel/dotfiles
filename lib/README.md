# Dependent git projects

This directory contains all the remote dependencies that these config files depends on.

To manage these dependencies, they are placed here as [git submodules](https://git-scm.com/docs/git-submodule). This requires an extra step for a user, which is simply to run `git submodule update --init --recursive` (this is also done by the `install.py` script).
