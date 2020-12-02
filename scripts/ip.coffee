# Description:
#   Return Hubot's external IP address
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot ip - Returns Hubot server's external IP address
#
# Author:
#   vensder

cowsay = require 'cowsay'

cowSay = (text = 'Moooo') ->
    cowsay.say({
      text: text,
      f: "C3PO"
      })

asCode = (text) ->
  return("```#{text}```")

module.exports = (robot) ->
  robot.respond /ip/i, (msg) ->
    msg.send "Checking..."
    msg.http("http://whatismyip.akamai.com/")
      .get() (err, res, body) ->
        myIP = "My external IP: #{body.toString().trim()}"
        msg.send asCode(cowSay(myIP))
