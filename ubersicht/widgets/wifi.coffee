command: '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk \'/ SSID/ {print substr($0, index($0, $2))}\''

# the refresh frequency in milliseconds
refreshFrequency: 1000

render: (output) -> "#{output}"

style: """
  /*color: #0E2C51*/
  color: #FFFFFF
  font-family: mononoki Nerd Font
  font-size: 11px
  font-smoothing: antialiased
  left: 5px
  padding: 0px
  margin: 0px
  bottom: 5px
"""
