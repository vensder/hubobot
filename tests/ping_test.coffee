Helper = require('hubot-test-helper')
expect = require('chai').expect

# helper loads a specific script if it's a file
helper = new Helper('./../scripts/ping.coffee')

describe 'ping', ->
  room = null

  beforeEach ->
    # Set up the room before running the test
    room = helper.createRoom()

  afterEach ->
    # Tear it down after the test to free up the listener.
    room.destroy()

  context 'user says ping to hubot', ->
    beforeEach ->
      room.user.say 'alice', 'hubot PING'
      room.user.say 'bob',   'hubot PING'

    it 'should reply pong to user', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot PING']
        ['hubot', 'PONG']
        ['bob',   'hubot PING']
        ['hubot', 'PONG']
      ]