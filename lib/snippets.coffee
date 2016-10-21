SnippetsView = require './snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = Snippets =
  snippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @snippetsView = new SnippetsView(state.snippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @snippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @snippetsView.destroy()

  serialize: ->
    snippetsViewState: @snippetsView.serialize()

  toggle: ->
    console.log 'Snippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
