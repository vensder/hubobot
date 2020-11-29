Helper = require('hubot-test-helper')
expect = require('chai').expect
co     = require('co')

# helper loads a specific script if it's a file
helper = new Helper('../scripts/test.coffee')

describe 'test', ->
  room = null

  beforeEach ->
    # Set up the room before running the test
    room = helper.createRoom()

  afterEach ->
    # Tear it down after the test to free up the listener.
    room.destroy()

  context 'user says test to hubot', ->
    beforeEach ->
      co (->
        yield room.user.say 'alice', '@hubot test'
        yield room.user.say 'bob', '@hubot test'
      ).bind(this)

    it 'should reply TOST to user', ->
      expect(room.messages).to.eql [
        ['alice', '@hubot test']
        ['hubot', 'TOST']
        ['bob', '@hubot test']
        ['hubot', 'TOST']
      ]
