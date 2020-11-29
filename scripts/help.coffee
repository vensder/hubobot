# Description:
#   Generates help commands for Hubot.
#
# Dependencies:
#   None
#
# Configuration:
#  None
#
# Commands:
#   hubot help - Displays all of the help commands that this bot knows about.
#   hubot help <query> - Displays all help commands that match <query>.
#
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

# global renamedHelpCommands

getHelpCommands = (robot) ->
  helpCommands = robot.helpCommands()

  robotName = robot.alias || robot.name

  helpCommands = helpCommands.map((command) ->
    if (robotName.length == 1)
      command.replace(/^hubot\s*/i, robotName)

    command.replace(/^hubot/i, robotName)
  )

  helpCommands.sort()

module.exports = (robot) ->
  robot.respond(/help(?:\s+(.*))?$/i, (msg) ->
    cmds = getHelpCommands(robot)
    filter = msg.match[1]

    if (filter)
      cmds = cmds.filter (cmd) -> cmd.match(new RegExp(filter, 'i'))
      if (cmds.length == 0)
        msg.send("No available commands match #{filter}")

    emit = cmds.join('\n')

    if (!msg.message.thread_ts)
      msg.message.thread_ts = msg.message.rawMessage.ts  # to reply in thread

    if (msg.message && msg.message.user && msg.message.user.id)
      msg.reply('replied to you in private!')
      robot.send({ room: msg.message.user.id }, emit)  # send in private
    else
      msg.send(emit)
  )
