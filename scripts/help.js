'use strict'

// Description:
//   Generates help commands for Hubot.
//
// Commands:
//   hubot help - Displays all of the help commands that this bot knows about.
//   hubot help <query> - Displays all help commands that match <query>.
//
// URLS:
//   /hubot/help
//
// Configuration:
//   HUBOT_HELP_HIDDEN_COMMANDS - comma-separated list of commands that will not be displayed in help
//
// Notes:
//   These commands are grabbed from comment blocks at the top of each file.

/* global renamedHelpCommands */

module.exports = (robot) => {
    robot.respond(/help(?:\s+(.*))?$/i, (msg) => {
        let cmds = getHelpCommands(robot)
        const filter = msg.match[1]

        if (filter) {
            cmds = cmds.filter(cmd => cmd.match(new RegExp(filter, 'i')))
            if (cmds.length === 0) {
                msg.send(`No available commands match ${filter}`)
                return
            }
        }

        const emit = cmds.join('\n')

        if (!msg.message.thread_ts) {
            msg.message.thread_ts = msg.message.rawMessage.ts  // to reply in thread
        }

        if (msg.message && msg.message.user && msg.message.user.id) {
            msg.reply('replied to you in private!')
            return robot.send({ room: msg.message.user.id }, emit)  // send in private
        } else {
            return msg.send(emit)
        }
    })

}

var getHelpCommands = function getHelpCommands(robot) {
    let helpCommands = robot.helpCommands()

    const robotName = robot.alias || robot.name

    if (hiddenCommandsPattern()) {
        helpCommands = helpCommands.filter(command => !hiddenCommandsPattern().test(command))
    }

    helpCommands = helpCommands.map((command) => {
        if (robotName.length === 1) {
            return command.replace(/^hubot\s*/i, robotName)
        }

        return command.replace(/^hubot/i, robotName)
    })

    return helpCommands.sort()
}

var hiddenCommandsPattern = function hiddenCommandsPattern() {
    const hiddenCommands = process.env.HUBOT_HELP_HIDDEN_COMMANDS != null ? process.env.HUBOT_HELP_HIDDEN_COMMANDS.split(',') : undefined
    if (hiddenCommands) {
        return new RegExp(`^hubot (?:${hiddenCommands != null ? hiddenCommands.join('|') : undefined}) - `)
    }
}
