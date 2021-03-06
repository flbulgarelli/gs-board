Polymer
  is: '#GRUNT_COMPONENT_NAME'

  properties:
    black:
      type: Number
      value: 0
    blue:
      type: Number
      value: 0
    green:
      type: Number
      value: 0
    red:
      type: Number
      value: 0
    cellIndex: Number
    rowIndex: Number
    attire: Object
    options: Object
    header:
      type: Object
      notify: true

  listeners:
    click: "_leftClick"

  ready: ->
    @_validateData()

  cssClass: (header) ->
    return "" if not header?
    isHeader = @x() is header.x and @y() is header.y

    if isHeader then "gbs_gh" else ""

  x: -> @cellIndex
  y: -> @domHost.getRowNumber @domHost.table, @rowIndex

  updateCellStyles: (table, header, attire) ->
    cell = table[@rowIndex]?[@cellIndex]
    return if not cell? or not header?

    isHeader = @x() is header.x and @y() is header.y
    rule = @$.dresser.getRule cell, isHeader, attire
    url = rule?.image

    @customStyle["--stones-visibility"] = if url? then "hidden" else "visible"
    @customStyle["--outline-style"] = if url? and rule?.when?.head? then "none" else "solid"
    if url? then @customStyle["--background-url"] = "url(#{url})"
    else delete @customStyle["--background-url"]

    @updateStyles()

  _leftClick: (event) ->
    return if not @options.editable

    if @domHost.isCtrlPressed()
      @header = { x: @x(), y: @y() }
      @fire "board-changed"

  _validateData: ->
    throw new Error("The coordinates are required") if not @cellIndex? or not @rowIndex?
    throw new Error("The header is required") if not @header?
    throw new Error("The options are required") if not @options?
