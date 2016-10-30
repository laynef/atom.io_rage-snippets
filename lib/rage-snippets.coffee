RageSnippetsView = require './rage-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = RageSnippets =
  rageSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @rageSnippetsView = new RageSnippetsView(state.rageSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @rageSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'rage-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rageSnippetsView.destroy()

  serialize: ->
    rageSnippetsViewState: @rageSnippetsView.serialize()

  toggle: ->
    console.log 'RageSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
