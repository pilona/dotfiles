"""
This file is executed when the Python interactive shell is started if
$PYTHONSTARTUP is in your environment and points to this file.
It's just regular Python code, so do what you will.
Your ~/.inputrc file can greatly complement this file.
"""

from os import environ
from os.path import expanduser

import atexit

import readline


histfile = expanduser(environ["HOME"] + "/.pyhistory")
readline.read_history_file(histfile)
readline.set_history_length(300)
atexit.register(lambda hf=histfile: readline.write_history_file(hf))
