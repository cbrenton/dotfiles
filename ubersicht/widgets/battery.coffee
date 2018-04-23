command: 'pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d";"'

# the refresh frequency in milliseconds
refreshFrequency: 1000

render: (output) -> "#{output}"

style: """
  /*color: #0E2C51*/
  color: #FFFFFF
  font-family: mononoki Nerd Font
  font-size: 11px
  font-smoothing: antialiased
  bottom: 5px
  width: 100%
  text-align: center
"""
