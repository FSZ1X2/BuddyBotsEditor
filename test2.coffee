# Droplet config editor
unless window.ALREADY_LOADED
  window.ALREADY_LOADED = true
  dropletConfig = ace.edit 'droplet-config'
  dropletConfig.setTheme 'ace/theme/terminal'
  dropletConfig.getSession().setMode 'ace/mode/python'

  dropletConfig.setValue localStorage.getItem('config') ? '''
    ({
    mode: 'python',
    modeOptions: {
      functions: {

        newLine: {
          'color': 'blue' }
       }
     },

    palette: [
      {
        name: 'Imports',
        color: 'red',
        blocks: [
          { block: 'import library_name' },
          { block: 'from library_name import library_package' }
        ]
      },

      {
        name: 'Variables',
        color: 'orange',
        blocks: [
          { block: 'intVariable = 1' },
          { block: 'floatVariable = 1.0' },
          { block: 'stringVariable = \\'This is a string!\\'' },
          { block: 'boolVariable = True' },
          { block: 'listVariable = [0, 1, 2, 3, 4, 5, 6]' },
          { block: 'tupleVariable = (\\'ABCD\\', 12345, 6.0)' },
          { block: 'dictVariable = {\\'Red\\', \\'Orange\\', \\'Yellow\\', \\'Green\\', \\'Blue\\', \\'Indigo\\', \\'Violet\\'}'  }
        ]
      },

      {
        name: 'Operators',
        color: 'yellow',
        blocks: [
          { block: 'a + b' },
          { block: 'a - b' },
          { block: 'a * b' },
          { block: 'a / b' },
          { block: 'a % b' },
          { block: 'a ** b' },
          { block: 'a // b' },
          { block: '(a + b)' },
          

          { block: 'a == b' },
          { block: 'a != b' },
          { block: 'a <> b' },
          { block: 'a > b' },
          { block: 'a < b' },
          { block: 'a >= b' },
          { block: 'a <= b' },
                 
          { block: 'a += b' },
          { block: 'a -= b' },
          { block: 'a *= b' },
          { block: 'a /= b' },
          { block: 'a %= b' },
          { block: 'a **= b' },
          { block: 'a //= b' },
                 
          { block: 'a \& b' },
          { block: 'a \| b' },
          { block: 'a \^ b' },
          { block: '\~a = b' },
          { block: 'a << 1' },
          { block: 'a >> 1' },
                      
          { block: 'a and b' },
          { block: 'a or b' },
          { block: 'not(a and b)' },
                 
          { block: 'a in b' },
          { block: 'a not in b' },
                 
          { block: 'a is b' },
          { block: 'a is not b' },
                 
          { block: 'True' },
          { block: 'False' }
        ]
      },

      {
        name: 'Controls',
        color: 'green',
        blocks: [
          { block: 'if a == b:\\n  print (\\'This is a conditional statement!\\')' },
          { block: 'while a == b:\\n  print (\\'This is a conditional loop!\\')' },
          { block: 'for i in list_variable:\\n  print (i)' },
          { block: 'break' },
          { block: 'continue' },
          { block: 'pass' }
        ]
      },

      {
        name: 'Functions',
        color: 'blue',
        blocks: [
          { block: 'def FunctionName(args):\\n  return' },
          { block: 'FunctionName(args)' },
          { block: 'lambda_variable = lambda args: args * 2' },
          { block: 'return return_value' },
          { block: 'return' }
        ]
      },

      {
        name: 'Classes',
        color: 'purple',
        blocks: [
          { block: 'class ClassName:\\n def __init__(self, args):\\n  self.args = args\\n  print(\\'NOTE: The self parameter is the instance that the method is called on!\\')\\n def __del__(self):\\n  class_name = self.__class__.__name__\\n  print(class_name + \\' was destroyed!\\')' },
          { block: 'class_object = ClassName(\\'This is the default constructors args parameter!\\')' },
          { block: 'class_object.__init__()' }
        ]
      },

      {
        name: 'PyGame',
        color: 'amber',
        blocks: [
          { block: 'import pyjsdl as pygame' },
          { block: 'pygame.init()' },
          { block: 'screen = pygame.display.set_mode([640,480])' },
          { block: 'screen.fill(WHITE)' },
          { block: 'pygame.draw.rect(screen, (255,255,0), [150, 10, 50, 20])' },
          { block: 'pygame.display.flip()' },
          { block: 'pygame.quit()' }
        ]
      },

      {
        name: 'Misc',
        color: 'lightblue',
        blocks: [
          { block: '# this is a comment' },

        ]
      },
    ]
  })
  '''

  editor = null

# Droplet itself
#<<<<<<< HEAD
  createEditor = (options) ->
    $('#droplet-editor').html ''
    editor = new droplet.Editor $('#droplet-editor')[0], options
#=======
#createEditor = (options) ->
#  $('#droplet-editor').html '<div id="ace-target"></div>'
#  aceEditor = ace.edit 'ace-target'
#  editor = new droplet.Editor aceEditor, options
#>>>>>>> c_support

    editor.setEditorState localStorage.getItem('blocks') is 'yes'
    editor.aceEditor.getSession().setUseWrapMode true

    # Initialize to starting text
    editor.setValue localStorage.getItem('text') ? ''

    editor.on 'change', ->
      localStorage.setItem 'text', editor.getValue()

    window.editor = editor

  createEditor eval dropletConfig.getValue()

  editor.toggleBlocks()

  $('#toggle').on 'click', ->
    editor.toggleBlocks()
    localStorage.setItem 'blocks', (if editor.currentlyUsingBlocks then 'yes' else 'no')

  # Stuff for testing convenience
  $('#update').on 'click', ->
    localStorage.setItem 'config', dropletConfig.getValue()
    createEditor eval dropletConfig.getValue()

  configCurrentlyOut = localStorage.getItem('configOut') is 'yes'

  updateConfigDrawerState = ->
    if configCurrentlyOut
      #$('#left-panel').css 'left', '0px'
      #$('#right-panel').css 'left', '525px'
    else
      #$('#left-panel').css 'left', '-500px'
      #$('#right-panel').css 'left', '25px'

    editor.resize()

    localStorage.setItem 'configOut', (if configCurrentlyOut then 'yes' else 'no')

  $('#close').on 'click', ->
    configCurrentlyOut = not configCurrentlyOut
    updateConfigDrawerState()

  updateConfigDrawerState()
