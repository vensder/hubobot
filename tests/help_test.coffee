Helper = require('hubot-test-helper')
expect = require('chai').expect
co     = require('co')

# helper loads a specific script if it's a file
helper = new Helper('../scripts')

describe 'help', ->
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
        yield room.user.say 'alice', '@hubot help'
        yield room.user.say 'bob', '@hubot help non-existing-command'
      ).bind(this)

    it 'should reply help to user', ->
      expect(room.messages).to.eql [
        ['alice', '@hubot help']
        # ['hubot', 'help messages']
        ['bob', '@hubot help non-existing-command']
        ['hubot', 'No available commands match non-existing-command']
      ]
