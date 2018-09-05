# This is a simple example Widget, written in CoffeeScript, to get you started
# with Übersicht. For the full documentation please visit:
#
# https://github.com/felixhageloh/uebersicht
#
# You can modify this widget as you see fit, or simply delete this file to
# remove it.

# this is the shell command that gets executed every time this widget refreshes
command: 'echo `date "+%l:%M %p"` "/" `TZ=":Asia/Hong_Kong" date "+%l:%M %p %a"`'

# the refresh frequency in milliseconds
refreshFrequency: '1s'

# render gets called after the shell command has executed. The command's output
# is passed in as a string. Whatever it returns will get rendered as HTML.
render: (output) -> "#{output}"

# the CSS style for this widget, written using Stylus
# (http://learnboost.github.io/stylus/)
style: """
  /*color: #0E2C51*/
  color: #FFFFFF
  font-family: mononoki Nerd Font
  font-size: 11px
  font-smoothing: antialiased
  right: 5px
  padding: 0px
  margin: 0px
  bottom: 5px
"""
