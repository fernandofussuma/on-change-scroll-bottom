module.exports =
class OnChangeScrollBottomView
  constructor: ->
    @disposables = []

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->

  active: ->
    # console.log disp for disp in @disposables
    editor = atom.workspace.getActiveTextEditor()
    true if editor and @disposables[editor.id]

  start: ->
    console.log 'start \\o/'
    editor = atom.workspace.getActiveTextEditor()
    if editor
      @disposables[editor.id] = editor.onDidStopChanging ->
        editor.setCursorScreenPosition([editor.getLastScreenRow(), 0])
        atom.beep()

  stop: ->
    console.log 'stop /o/'
    editor = atom.workspace.getActiveTextEditor()
    @disposables[editor.id].dispose() if @disposables[editor.id]
    @disposables[editor.id] = false
