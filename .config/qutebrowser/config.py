config.load_autoconfig()
from os import environ
environ['QT_SCALE_FACTOR'] = '1.65'

# Recovering from photorefractive kematography—PRK (laser eye surgery) means
# everything's blurry for weeks. However, the font hints do not scale with
# zoom.
#c.fonts.hints = '48px default_family'
#c.fonts.keyhint = '48px default_family'
#c.fonts.contextmenu = '32px default_family'
#c.fonts.prompts = '32px default_family'
#c.fonts.statusbar = '32px default_family'
#c.fonts.completion.category = '48px default_family'
#c.fonts.completion.entry = '32px default_family'
#c.zoom.default = '200%'
