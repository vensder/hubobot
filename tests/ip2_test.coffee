Helper = require('hubot-test-helper')
expect = require('chai').expect
co = require('co')


# helper loads a specific script if it's a file
helper = new Helper('../scripts/ip.coffee')

describe 'ip test v.2', ->
  room = null

  beforeEach ->
    # Set up the room before running the test
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  context 'user says ip to hubot', ->
    beforeEach ->
      co (->
        yield room.user.say 'alice', 'hubot ip'
        yield room.user.say 'bob',   'hubot ip'
      ).bind(this)
    it 'should reply ip addr to user', ->
      expect(room.messages).to.eql [
        ['alice', 'hubot ip']
        ['hubot', 'Checking...']
        ['bob',   'hubot ip']
        ['hubot', 'Checking...']
      ]