module.exports = (robot) ->
  robot.respond /test$/i, (msg) ->
    msg.send "TOST"