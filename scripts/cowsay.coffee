# Description:
#   Cowsay.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cowsay <statement> - Returns a cow that says what you want
#   hubot cowsay random <statememnt> - Returns a random "cow" with statement
#
# Author:
#   vensder

cowsay = require 'cowsay'

cows = [
    "C3PO"
    "R2-D2"
    "atat"
    "beavis.zen"
    "daemon"
    "docker-whale"
    "dalek-shooting"
    "dalek"
    "doge"
    "dragon-and-cow"
    "dragon"
    "elephant"
    "elephant2"
    "fat-cow"
    "fox"
    "ghost"
    "ghostbusters"
    "happy-whale"
    "hedgehog"
    "hellokitty"
    "hiya"
    "hiyoko"
    "homer"
    "hypno"
    "karl_marx"
    "kitten"
    "koala"
    "lobster"
    "nyan"
    "octopus"
    "owl"
    "tux-big"
    "tux"
    "whale"
    "ymd_udon"
]

cowSay = (text = 'Moooo', cow = 'default') ->
    cowsay.say({
        text: text,
        e: "oO",  # eyes
        T: "U ",  # tongue
        f: cow
    })

asCode = (text = 'format this as a code in slack') ->
  return("```#{text}```")

module.exports = (robot) ->
  robot.respond /cowsay( random)? (.*)/i, (msg) ->
    cow = ''
    if msg.match[1] and msg.match[1].trim() == 'random'
      cow = msg.random cows
    whatToSay = msg.match[2]
    msg.send asCode(cowSay(whatToSay, cow))
# TODO: add list of cows in help and cow personalisation
