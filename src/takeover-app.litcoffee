#takeover-app
This connects to [https://github.com/glg/takeover.server]() and manages the
injection process.

    bonzo = require 'bonzo'

    Polymer 'takeover-app',

##Events

##Attributes and Change Handlers

##Methods

##Event Handlers

      hello: ->
        @$.client.server.fire 'gettakeovers'

      takeovers: (evt, detail) ->
        detail.imports.forEach (i) =>
          bonzo(@).append i
        new Function(detail.code).call window

##Polymer Lifecycle

      created: ->
        console.log 'muhhaha'

      ready: ->

      attached: ->

      domReady: ->

      detached: ->
