def FlagsForFile(filename, **kwargs):
    return {'flags': ['-Wall',
                      '-Wextra',
                      '-Werror',
                      '-std=c11'],
            'do_cache': True}
