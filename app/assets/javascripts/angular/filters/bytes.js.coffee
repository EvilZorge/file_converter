@mainApp.filter 'bytes', [ ->
  (bytes, precision) ->
    if isNaN(parseFloat(bytes)) or !isFinite(bytes)
      return '-'
    if typeof precision == 'undefined'
      precision = 1
    if bytes == 0
      return "0 bytes"
    units = [
      'bytes'
      'kB'
      'MB'
      'GB'
      'TB'
      'PB'
    ]
    number = Math.floor(Math.log(bytes) / Math.log(1024))
    (bytes / 1024 ** Math.floor(number)).toFixed(precision) + ' ' + units[number]
]
