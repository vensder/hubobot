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
#   hubot cowsay2 <statement> - Returns a cow that says what you want
#   hubot cowsay2 random <statement> - Returns a random "cow" with statement
#
# Author:
#   vensder

# TODO: add list of cows in help and cow personalisation

cowsay = require 'cowsay2'

favoriteCows = [
  "C3PO"
  "R2-D2"
  "atat"
  "beavis.zen"
  "daemon"
  "docker-whale"
  "dalek-shooting"
  "dalek"
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
  "turkey"
  "tux-big"
  "tux"
  "whale"
  "ymd_udon"
]

cowSay = (text = 'Moooo', cow = 'default') ->
  current_cow = require("cowsay2/cows/#{cow}.js")
  cowsay.say(text,
  {
    e: "oO", # eyes
    T: "U ", # tongue
    cow: current_cow
  })

asCode = (text = 'format this as a code in slack') ->
  return("```#{text}```")

module.exports = (robot) ->
  robot.respond /cowsay2( random)? (.*)/i, (msg) ->
    cow = 'default'
    if msg.match[1] and msg.match[1].trim() == 'random'
      cow = msg.random favoriteCows
    whatToSay = msg.match[2]
    msg.send asCode(cowSay(whatToSay, cow))
