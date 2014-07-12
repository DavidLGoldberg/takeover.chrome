#takeover-app
This connects to [https://github.com/glg/takeover.server]() and manages the
injection process.

    _ = require 'lodash'
    async = require 'async'

    Polymer 'takeover-app',

##Events

##Attributes and Change Handlers

When we get new takeovers, set up to run them by importing all the provided
imports.

      takeoversChanged: ->
        waterfall = @takeovers.imports.map (i) =>
          (callback) ->
            element = document.createElement 'takeover-import'
            element.innerHTML = i
            Polymer.importElements element, callback

Ahh, asynchonicity. Either the user or the takeovers can come in before the
other -- and we need both. I'm not bothering with a promise for just two things,
that -- and the takeovers can and will change on line so a promise's single fire
on satisfaction isn't a good fit.

        waterfall.push (callback) =>
          new Function(@takeovers.code)(@email) if @takeovers.code and @email
          callback()

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

When we know an email address, run takeovers if they are loaded.

      emailChanged: ->
        new Function(@takeovers.code)(@email) if @takeovers?tacode and @email

##Methods

##Event Handlers

      onHello: (evt) ->
        @$.client.server.fire 'gettakeovers'
        evt.stopPropagation()

      onTakeovers: (evt, detail) ->
        @takeovers = detail
        evt.stopPropagation()

      onUser: (evt, detail) ->
        @email = detail.email
        evt.stopPropagation()

##Polymer Lifecycle

      created: ->

      ready: ->

      attached: ->

      domReady: ->

      detached: ->
