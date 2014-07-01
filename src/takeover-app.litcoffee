#takeover-app
This connects to [https://github.com/glg/takeover.server]() and manages the
injection process.

    _ = require 'lodash'
    async = require 'async'

    Polymer 'takeover-app',

##Events

##Attributes and Change Handlers

##Methods

##Event Handlers

      hello: ->
        @$.client.server.fire 'gettakeovers'

      takeovers: (evt, detail) ->
        waterfall = detail.imports.map (i) =>
          (callback) ->
            element = document.createElement 'takeover-import'
            element.innerHTML = i
            Polymer.importElements element, callback

Now all the polymer elements are dynamically imported, but still aren't either
ready to run -- or are run. Thank CSP. So, let's beat CSP with a simple selection
of that script code and a run with our buddy `Function`.

        async.waterfall waterfall, (e) ->
          console.log 'takeovers imported'
          if e
            console.log e
          else
            polymerInits = _.map(
              document.querySelectorAll('takeover-import script'),
              (s) -> s.text
              ).join '\n'
            new Function(polymerInits)()
            new Function(detail.code)()

##Polymer Lifecycle

      created: ->

      ready: ->

      attached: ->

      domReady: ->

      detached: ->
