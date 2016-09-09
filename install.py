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
        answer = input(question + ' (y/n) ')
        if answer in affirmatives:
            return True
        if answer in negatives:
            return False

def changelog(prefix, filename, comment=None):
    """
    Format and print a proposed change to stdout

    Args:
        prefix (str): message prefix
        filename (str): filename of the change
        comment (str): optional postfix comment
    """
    assert isinstance(prefix, str)
    assert isinstance(filename, str)
    assert isinstance(comment, (str, None))

    valid_prefixes = frozenset(['ERROR',
                                'BACKUP',
                                'LINK'])
    assert prefix in valid_prefixes

    if comment is not None:
        postfix = '  ({})'.format(comment)

    spaces = (' ' * (len(max(valid_prefixes, key=len)) - len(prefix) - 1))

    msg = (prefix + ':' + spaces + filename + postfix)

    print(msg)


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


def get_linkfile_list(root_path):
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


def backup_target_file(target, report=False):
    """
    Check if a file exists. If so, attempt to back it up.

    Args:
        target (str): target file path
        report (bool): should we actually do it, or just report changes?

    Return:
        (bool): True if backup was successful or unnecessary
    """
    if path.lexists(target):
        if path.lexists(target + '~'):
            if report:
                changelog('ERROR', target, ('Cannot back up: backup already ' +
                                            'exists! Please fix manually.'))
            return False
        else:
            if report:
                changelog('BACKUP', target, 'backing up existing file to {}'
                          .format(target, (path.split(target)[-1] + "~")))
            else:
                print('backing up')
                os.rename(target, (target + '~'))
    return True


def create_link(link, report=False):
    """
    Create the right links for each *.link file

    Args:
        link (str): path to *.link file
        report (bool): should we actually link, or just report changes?
    """
    assert isinstance(link, str)
    assert isinstance(report, bool)
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
        if path.islink(target_basedir):
            if not backup_target_file(target_basedir, report):
                continue
        if not path.isdir(target_basedir):
            if not report:
                print('mkdir')
                os.makedirs(target_basedir)

        # Is our link already set up?
        if path.islink(target):
            if os.readlink(target) == source:
                continue

        # If not, is a file there? Back it up!
        if not backup_target_file(target, report):
            continue

        # If we're still here, create our symlink
        if report:
            changelog('LINK', target, 'to {}'.format(source))
        else:
            os.symlink(source, target)


def main():
    docopt(__doc__, argv=None, help=True)

    if not check_environment():
        sys.exit(1)

    linkfile_list = get_linkfile_list(dotfiles_path)

    print('The following changes will be made:')
    for link in linkfile_list:
        create_link(link, report=True)

    if prompt('\nDo you wish to continue?'):
        for link in linkfile_list:
            create_link(link)
        print('Done.')
    else:
        print('Aborting...')
        sys.exit(0)

if __name__ == "__main__":
    main()
