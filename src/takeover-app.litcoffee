#takeover-app
This connects to [https://github.com/glg/takeover.server]() and manages the
injection process.

    Polymer 'takeover-app',

##Events

##Attributes and Change Handlers

##Methods

##Event Handlers

      hello: ->
        @$.client.server.fire 'gettakeovers'

      takeovers: (evt, detail) ->
        new Function(detail.code).call window

##Polymer Lifecycle

      created: ->
        console.log 'muhhaha'

      ready: ->

      attached: ->

      domReady: ->

      detached: ->
