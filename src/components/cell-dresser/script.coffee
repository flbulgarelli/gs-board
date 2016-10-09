Polymer
  is: '#GRUNT_COMPONENT_NAME'

  getImage: (cell, clothing)->
    clothing?.rules
      .filter((rule) => @_doesSatisfyRule cell, rule)[0]?.image

  _doesSatisfyRule: (rule, cell) ->
    itSatisfies = (color) =>
      @_doesSatisfyQuantity cell[color], rule[color]

    ["red", "blue", "green", "black"]
    .reduce((previousCondition, color) =>
      previousCondition and itSatisfies color
    , true)

  _doesSatisfyQuantity: (quantity, expectedQuantity) ->
    switch expectedQuantity
      when "*"
        true
      when "+"
        quantity > 0
      else
        quantity is expectedQuantity
