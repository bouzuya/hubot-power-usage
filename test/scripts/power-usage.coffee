{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'power-usage', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      setTimeout done, 10 # wait for parseHelp()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    describe 'valid patterns', ->
      beforeEach ->
        @tests = [
          message: '@hubot power-usage hokkaido'
          matches: ['@hubot power-usage hokkaido', 'hokkaido']
        ,
          message: '@hubot power-usage tohoku'
          matches: ['@hubot power-usage tohoku', 'tohoku']
        ,
          message: '@hubot power-usage tokyo'
          matches: ['@hubot power-usage tokyo', 'tokyo']
        ,
          message: '@hubot power-usage chubu'
          matches: ['@hubot power-usage chubu', 'chubu']
        ,
          message: '@hubot power-usage kansai'
          matches: ['@hubot power-usage kansai', 'kansai']
        ,
          message: '@hubot power-usage kyushu'
          matches: ['@hubot power-usage kyushu', 'kyushu']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[0].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'robot.helpCommands()', ->
    it 'should be ["hubot power-usage <hokkaido|tohoku|tokyo|chubu|kansai|kyushu> - show power usage"]', ->
      assert.deepEqual @robot.helpCommands(), [
        'hubot power-usage <hokkaido|tohoku|tokyo|chubu|kansai|kyushu> - show power usage'
      ]
