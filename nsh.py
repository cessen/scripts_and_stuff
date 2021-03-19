#!/usr/bin/env python3

import os
import sys
import os.path
import glob
import optparse
import subprocess
import re
import errno


def find_files_upward(filenames):
    # Calculate the current directory depth.  This is an obvious overestimate,
    # but that's okay.
    depth = len(os.path.abspath(".").split("/"))

    # Search upwards through each parent directory for the files, giving
    # priority first to closest depth and second to the order the files are
    # listed in `filenames`.
    paths = filenames
    for d in range(depth):
        for i in range(len(paths)):
            if os.path.isfile(paths[i]):
                return paths[i]
            else:
                paths[i] = "../" + paths[i]
    return None


if __name__ == "__main__":
    # Search for either "shell.nix" or "default.nix"
    nix_file_path = find_files_upward(["shell.nix", "default.nix", ".shell.nix", ".default.nix"])

    # If we found a file, start the shell with it.
    if nix_file_path != None:
        print("Starting nix-shell with '{}'".format(os.path.abspath(nix_file_path)))
        completed_process = subprocess.run(["nix-shell", nix_file_path])
        exit(completed_process.returncode)
    else:
        print("Couldn't find 'shell.nix' or 'default.nix' file in current or any parent directories.")
        exit(1)
