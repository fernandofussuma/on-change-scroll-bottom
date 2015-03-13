OnChangeScrollBottomView = require './on-change-scroll-bottom-view'
{CompositeDisposable} = require 'atom'

module.exports = OnChangeScrollBottom =
  onChangeScrollBottomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @onChangeScrollBottomView = new OnChangeScrollBottomView(state.onChangeScrollBottomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @onChangeScrollBottomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'on-change-scroll-bottom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @onChangeScrollBottomView.destroy()

  serialize: ->
    onChangeScrollBottomViewState: @onChangeScrollBottomView.serialize()

  toggle: ->
    console.log 'OnChangeScrollBottom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
