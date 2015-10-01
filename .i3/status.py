#! /usr/bin/env python3

from itertools import chain
from time import sleep
from datetime import datetime, timezone
import subprocess
import json

def time_widget(t_sep=' '):
    # Show timezone too. TODO: Does it show DST?
    #dt = datetime.now(tz=timezone.utc).astimezone()
    dt = datetime.now().replace(microsecond=0)
    t = dt.time()
    t_sep = ' '
    dt_fmt = dt.isoformat(t_sep)
    t_fmt = dt.isoformat(t_sep)

    yield {'full_text': dt_fmt, 'short_text': t_fmt}


def batt_widget():
    # TODO: color, urgent, short_text
    #plugged = subprocess.check_output(['acpi', '--ac-adapter']) \
    #                    .decode() \
    #                    .split()[-1] == 'on-line'
    batt = subprocess.check_output(['acpi', '-b']).decode().split()
    #batt_fmt = 'Plugged' if plugged else ' '.join(batt[4:]).strip()
    batt_fmt = ' '.join(batt[4:]).strip()

    if batt_fmt:
        yield {'full_text': batt_fmt}


if __name__ == '__main__':
    print(json.dumps({'version': 1}))
    print('[')
    while True:
        print(json.dumps(list(map(dict, chain(time_widget(),
                                              batt_widget())))),
              flush=True, end=',\n')
        sleep(1)
    print(']')
