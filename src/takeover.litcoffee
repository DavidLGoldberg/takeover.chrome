This content script is multiple stage.

    injectTakeover = ->
      injector = document.querySelector('script[takeover]')
      Polymer.import [injector.getAttribute('takeover')], ->
        console.log 'taken over'

## Stage 1
Inject itself into a running we page as a content script. Note that this
injects the compiled 'as js' version of this script, along with the location
of polymer, as the `getURL` call will not be available once in page.

    if chrome?.extension
      console.log 'takeover injecting'
      injector = document.createElement('script');
      injector.setAttribute('src', chrome.extension.getURL('takeover.js'))
      injector.setAttribute('polymer', chrome.extension.getURL('polymer/polymer.html'))
      injector.setAttribute('takeover', chrome.extension.getURL('takeover-app.html'))
      document.querySelector('head').appendChild(injector)

## Stage 2
Now in the page, detect if Polymer is available and inject polymer.

    if not chrome?.extension
      if Platform?
        console.log 'Polymer present'
        injectTakeover()
      else
        console.log('Polymer injecting')
        injector = document.querySelector('script[takeover]')

        polymer = document.createElement('link')
        polymer.setAttribute('rel', 'import')
        polymer.setAttribute('href', injector.getAttribute('polymer'))
        document.querySelector('head').appendChild(polymer)

## Stage 3
This is a followon to stage 2.
When there is polymer, inject the takeover by importing the polymer element
that is our `takeover-app`.

      document.addEventListener 'polymer-ready', ->
        # NOTE: The 'polymer-ready' event will have *already* been fired
        # by the time the extension runs if polymer was *already* present so
        # we also call injectTakeover() above.
        injectTakeover()
