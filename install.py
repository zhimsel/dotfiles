#!/usr/bin/env python3
"""install

Install symlinks for all specified files within this repo

Check for the existence of any ".filename.link" files, and links the
"$filename" file to the path specified in the contents of the .link file.

Usage:
    install --help
    install [options]

Options:
    -h --help       Show this screen
    -d --dry-run    Don't actually link anything, just pretend
"""

# Imports
import os
from os import path
import sys
import re
from docopt import docopt

# Make sure we're running python3
assert sys.version_info >= (3, 0), "Python 3 or newer required"

# Global objects
dotfiles_path = path.split(path.abspath(sys.argv[0]))[0]

# Dry run?
args = docopt(__doc__)
if args['--dry-run']:
    dry_run = True
    print("Detected '--dry-run', I won't actually change anything...")
else:
    dry_run = False


# Define our functions
def prompt(question):
    """
    Ask the given question.
    If the answer is Yes, continue
    If the answer is No, exit

    Args:
        question (string): Question to ask
    """
    assert isinstance(question, str)

    affirmatives = ('y', 'Y', 'yes', 'Yes', 'YES')
    negatives = ('n', 'N', 'no', 'No', 'NO')

    while True:
        answer = input(question + ' ')
        if answer in affirmatives:
            return True
        if answer in negatives:
            return False


def check_environment():
    """
    Check environment for dependencies and whatnot

    Returns:
        (bool): True if all checks pass
    """
    check_status = True

    # Make sure $HOME is not a git repo
    homedir = path.expanduser("~")
    if path.exists(homedir + '/.git'):
        check_status = False
        print('ERROR: Existing ~/.git repo detected! '
              'Please remove the old gitdir before proceeding.')

    return check_status


def get_link_list(root_path):
    """
    Get a list of .link files

    Args:
        root_path (str): path to start searching from

    Returns:
        (list): full paths to every .link file in the root_path
    """
    assert isinstance(root_path, str)
    assert path.isdir(root_path)

    links = list()

    for root, dirs, files in os.walk(dotfiles_path):
        for file in files:
            ext = path.splitext(file)[-1]
            if ext == '.link':
                links.append(path.join(root, file))

    return links


def backup_file(target):
    """
    Check if a file exists. If so, attempt to back it up.

    Args:
        target (str): target file path

    Return:
        (bool): True if successful
    """
    if path.exists(target):
        if path.exists(target + '~'):
            print(('{} (and its backup) already exist! ' +
                   'Ignoring. Please fix manually.').format(target))
            return False
        else:
            print('{} already exists! Backing up to {}...'
                  .format(target, (path.split(target)[-1] + "~")))
            if not dry_run:
                os.rename(target, (target + '~'))
    return True


def create_link(link):
    """
    Create the right links for each *.link file

    Args:
        link (str): path to *.link file
    """
    assert isinstance(link, str)
    assert path.isfile(link)

    # Get source file path
    source = (path.split(link)[0] + '/' +
              (re.sub(r'^(.*)\.link$', r'\1',
                      path.split(link)[-1])))
    assert path.exists(source)

    # Get target files' paths from contents of $link
    targets = list()
    with open(link) as f:
        for line in f.readlines():
            targets.append(path.expanduser(re.sub(r'\n', '', line)))

    # Iterate over target list from link file contents
    for target in targets:

        # Create target's parent dir if it doesn't exist
        target_basedir = path.split(target)[0]
        if backup_file(target_basedir):
            print('{} does not exist, creating...'.format(target_basedir))
            if not dry_run:
                os.makedirs(target_basedir)
        else:
            continue

        # Is our link already set up?
        if path.islink(target):
            if os.readlink(target) == source:
                print('Link for {} already exists, skipping...'.format(target))
                continue

        # If not, is a file there? Back it up!
        if not backup_file(target):
            continue

        # If we're still here, create our symlink
        print('Linking {} -> {}'.format(source, target))
        if not dry_run:
            os.symlink(source, target)


def main():
    """
    Stuff happens here
    """
    if not dry_run:
        if not prompt("Running this installer MAY alter existing files in "
                      "your home directory.\nYou can use --dry-run to try "
                      "see what will be changed first.\n"
                      "Do you wish to continue?"):
            sys.exit(0)

    if not check_environment():
        sys.exit(1)

    links = get_link_list(dotfiles_path)
    for link in links:
        create_link(link)

if __name__ == "__main__":
    main()
