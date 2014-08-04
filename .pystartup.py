"""
This file is executed when the Python interactive shell is started if
$PYTHONSTARTUP is in your environment and points to this file.
It's just regular Python code, so do what you will.
Your ~/.inputrc file can greatly complement this file.
"""

from os import environ
from os.path import expanduser
from code import InteractiveConsole
from tempfile import NamedTemporaryFile
from itertools import count
from subprocess import check_call

import sys
import atexit

import readline
import rlcompleter
import curses


# TODO: Track last runnable code in last_buffer, or find out if
#       parent classes expose that service.
# TODO: Add pager function.
# Cleaned up http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/.
class EditableBufferInteractiveConsole(InteractiveConsole):
    EDITOR = environ.get("VISUAL", environ.get("EDITOR", "vi"))
    EDIT_CMD = r'\e'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def raw_input(self, *args):
        line = super().raw_input(*args)
        if line == self.EDIT_CMD:
            with NamedTemporaryFile(suffix='.py') as tmpfl:
                check_call([self.EDITOR, tmpfl.name])
                lines = tmpfl.read().decode().splitlines()
                for line in lines[:-1]:
                    self.push(line)
                try:
                    return lines[-1]
                except IndexError:
                    return ""
        else:
            return line


# Make this work properly in Darwin and Linux
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")

histfile = expanduser(environ["HOME"] + "/.pyhistory")
readline.read_history_file(histfile)
readline.set_history_length(300)
atexit.register(lambda hf=histfile: readline.write_history_file(hf))

curses.setupterm()
if curses.tigetnum("colors") >= 8:
    def sgr(colour=None, mode=None,
            _SGR_COLORS={k: v for k, v in zip(["black", "red",  "green",
                                               "brown", "blue", "purple",
                                               "cyan"],
                                              map(str, count(30)))},
            _SGR_MODIFIERS={"normal": "0",
                            "light":  "1"}):
        assert colour or mode, "must set either colour or mode"
        return ''.join(["\N{SOH}\N{ESC}[",
                        _SGR_MODIFIERS[mode or "normal"],
                        ';' if mode else '',
                        _SGR_COLORS[colour] if colour else "",
                        "m\N{STX}"])

    # Enable Color Prompts
    sys.ps1 = '>>> '.join([sgr("green"), sgr(mode="normal")])
    sys.ps2 = '... '.join([sgr("red"),   sgr(mode="normal")])

EditableBufferInteractiveConsole().interact('')
sys.exit()  # Normally no exit. Force it.
