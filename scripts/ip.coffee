# Description:
#   Return Hubot's external IP address
#
# Dependencies:
#   None
#
# Configuration:
#  None
#
# Commands:
#   hubot ip - Returns Hubot server's external IP address
#
# Author:
#   unknown

asCode = (text) ->
  return("```#{text}```")

http = require 'http'
# curl http://cowsay.morecode.org/say?message=hello&format=text
cowSay = (text = "Moooo") ->
  return new Promise (resolve, reject) ->
    url = "http://cowsay.morecode.org/say?message=" + text + "&format=text"
    req = http.get url, (res) ->
      data = ''
      res.on 'data', (chunk) ->
          data += chunk.toString()
      res.on 'end', () ->
        success = true
        if success and res.statusCode == 200
          resolve (asCode(data))
        else
          reject Error "Something wrong with cowSay. Status Code: #{res.statusCode}"

module.exports = (robot) ->
  robot.respond /ip/i, (msg) ->
    msg.http("http://whatismyip.akamai.com/")
      .get() (err, res, body) ->
        myIP = body.toString().trim()
        cowSay(myIP).then (response) ->
          msg.send response
        .catch (error) ->
          console.error 'failed', error
