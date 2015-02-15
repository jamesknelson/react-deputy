Kefir = require('kefir')
listenToDescriptor = require('./listenToDescriptorMixin')


connectDescriptor = (descriptor, stateField, idProperty) ->

  updateState = (data) ->
    newState = {}
    newState[stateField] = data
    @setState(newState)

  base = listenToDescriptor(descriptor, idProperty, updateState)

  return base


module.exports = connectDescriptor
