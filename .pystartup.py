"""
This file is executed when the Python interactive shell is started if
$PYTHONSTARTUP is in your environment and points to this file.
It's just regular Python code, so do what you will.
Your ~/.inputrc file can greatly complement this file.
"""

from os import environ
from os.path import expanduser
from code import InteractiveConsole
from pprint import pprint
from tempfile import NamedTemporaryFile
from itertools import count
from traceback import format_exception
from subprocess import check_call

import sys
import atexit

import readline
import rlcompleter
import curses


# http://code.activestate.com/recipes/410692-readable-switch-construction-without-lambdas-or-di/:
# This class provides the functionality we want. You only need to look at
# this if you want to know how this works. It only needs to be defined
# once, no need to muck around with its internals.
class switch:
    """
    # The following example is pretty much the exact use-case of a dictionary,
    # but is included for its simplicity. Note that you can include statements
    # in each suite.
    v = 'ten'
    for case in switch(v):
        if case('one'):
            print(1)
            break
        if case('two'):
            print(2)
            break
        if case('ten'):
            print(10)
            break
        if case('eleven'):
            print(11)
            break
        if case(): # default, could also just omit condition or 'if True'
            print("something else!")
            # No need to break here, it'll stop anyway

    # break is used here to look as much like the real thing as possible, but
    # elif is generally just as good and more concise.

    # Empty suites are considered syntax errors, so intentional fall-throughs
    # should contain 'pass'
    c = 'z'
    for case in switch(c):
        if case('a'): pass # only necessary if the rest of the suite is empty
        if case('b'): pass
        # ...
        if case('y'): pass
        if case('z'):
            print("c is lowercase!")
            break
        if case('A'): pass
        # ...
        if case('Z'):
            print("c is uppercase!")
            break
        if case(): # default
            print("I dunno what c was!")

    # As suggested by Pierre Quentel, you can even expand upon the
    # functionality of the classic 'case' statement by matching multiple cases
    # in a single shot. This greatly benefits operations such as the
    # uppercase/lowercase example above:
    import string
    c = 'A'
    for case in switch(c):
        if case(*string.lowercase): # note the * for unpacking as arguments
            print("c is lowercase!")
            break
        if case(*string.uppercase):
            print("c is uppercase!")
            break
        if case('!', '?', '.'): # normal argument passing style also applies
            print("c is a sentence terminator!")
            break
        if case(): # default
            print("I dunno what c was!")

    # Since Pierre's suggestion is backward-compatible with the original
    # recipe, I have made the necessary modification to allow for the above
    # usage.
    """
    def __init__(self, value):
        self.value = value
        self.fall = False

    def __iter__(self):
        """Return the match method once, then stop"""
        yield self._match
        raise StopIteration

    def _match(self, *args):
        """Indicate whether or not to enter a case suite"""
        if self.fall or not args:
            return True
        elif self.value in args:  # changed for v1.5, see below
            self.fall = True
            return True
        else:
            return False


# TODO: Track last runnable code in last_buffer, or find out if
#       parent classes expose that service.
#       Better yet, see if the last complete statement is tracked (.e.g, single
#       line immediately evaluatable, while loop, for loop, etc).
# TODO: History searching with bang.
# TODO: Add pager function.
# TODO: Class name shortening?
# TODO: Move comment to pydoc?
# Cleaned up http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/.
class EditableBufferInteractiveConsole(InteractiveConsole):
    EDITOR = environ.get("VISUAL", environ.get("EDITOR", "vi"))
    EDIT_CMD = r'\e'

    def __init__(self, *args, **kwargs):
        self.last_buffer = []  # This holds the last executed statement
        super().__init__(*args, **kwargs)

    def raw_input(self, *args):
        line = super().raw_input(*args)
        if line == self.EDIT_CMD:
            with NamedTemporaryFile(suffix='.py') as tmpfl:
                tmpfl.write(b'\n'.join(self.last_buffer))
                tmpfl.flush()
                check_call([self.EDITOR, tmpfl.name])
                tmpfl.seek(0)
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

# FIXME: Pretty-printing doesn't result in very readable lists. They should
#        be columnized, not span hundreds of lines when they contain hundreds
#        of items.
# TODO: Limit number of items to print in collections to one screen height
sys.displayhook = pprint

# TODO: Retroactively apply this refactoring?
console_mixins = [EditableBufferInteractiveConsole]
# FIXME: Doesn't colour much of the traceback.
try:
    from pygments import highlight
    from pygments.lexers.agile import Python3TracebackLexer
    from pygments.formatters import Terminal256Formatter
    from pygments.styles.monokai import MonokaiStyle
except ImportError:
    pass
else:
    class ColourizingInteractiveConsole(InteractiveConsole):
        def showtraceback(self):
            print(highlight(''.join(format_exception(*sys.exc_info())),
                            Python3TracebackLexer(),
                            Terminal256Formatter(style=MonokaiStyle)),
                  file=sys.stderr)
    console_mixins.append(ColourizingInteractiveConsole)
try:
    from flake8.main import check_code
except ImportError:
    pass
else:
    # TODO: check_code() on every line.
    #       May need to sub subclass to get hook right.
    pass
class MyConsole(*console_mixins):
    pass
console = MyConsole()
console.interact('')
sys.exit()  # Normally no exit. Force it.
