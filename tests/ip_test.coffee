Helper = require('hubot-test-helper')
expect = require('chai').expect

# helper loads a specific script if it's a file
helper = new Helper('../scripts/ip.coffee')
console.log('ip test')
describe 'ip', ->
  room = null

  beforeEach ->
    # Set up the room before running the test
    room = helper.createRoom()

  afterEach ->
    # Tear it down after the test to free up the listener.
    room.destroy()

  context 'user says ip to hubot', ->
    beforeEach ->
      room.user.say 'alice', 'hubot ip'
      room.user.say 'bob',   'hubot ip'

    it 'should reply ip addr to user', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot ip']
        ['bob',   'hubot ip']
        ['hubot', 'Checking...']
        ['hubot', 'Checking...']
      ]