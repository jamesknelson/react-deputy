# TODO: This could probably be factored out again into a mixin which
# listens to the value of a property mapped by something with bacon


Kefir = require('kefir')


listenToDescriptor = (descriptor, idProperty, callback) ->
  # idProperty is optional
  if !callback
    callback = idProperty
    idProperty = null

  mixin =
    componentDidMount: ->
      @deputyPropModels ?= {}
      @deputyPropModels[idProperty] ?= Kefir.model(@props[idProperty])
      @deputyPropModels[idProperty]
        .flatMap(descriptor.getModel.bind(descriptor))
        .onValue(callback.bind(this))

    componentWillReceiveProps: (newProps) ->
      @deputyPropModels[idProperty].set(newProps[idProperty])

    componentWillUnmount: ->
      # If multiple listenTo's subscribe to the same keyProperty for some
      # reason, this may be called multiple times
      if @deputyPropModels[idProperty]
        @deputyPropModels[idProperty].dispose()
        @deputyPropModels[idProperty] = null


module.exports = listenToDescriptor