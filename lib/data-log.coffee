Configuration = require('./configuration.coffee')
{CompositeDisposable} = require 'atom'
dateformat = require('dateformat')

module.exports = DataLog =
  config: Configuration.config
  constructor: ->
    @subscriptions = null
    @format = @config.format.default

  activate: (state) ->
    atom.config.observe 'data-log.format', (value) =>
      @format = value

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-text-editor', 'data-log:toggle': => @toggle()


  deactivate: ->
    @subscriptions?.dispose()

  serialize: ->
    # dataLogViewState: @dataLogView.serialize()

  toggle: ->
    console.log 'DataLog was toggled!'
    editor = atom.workspace.getActiveTextEditor()
    date = new Date()

    # y = date.getFullYear()
    # m = (Number(date.getMonth()) + 1).toString()
    # d = date.getDay()
    #
    # h = date.getHours()
    # min = date.getMinutes()

    editor.insertText dateformat date, @format
