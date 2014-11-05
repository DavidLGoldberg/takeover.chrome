initTakeover() injects itself into a running page as a content script. Note that this
injects the compiled 'as js' version of this script, along with the location
of polymer, as the `getURL` call will not be available once in page.

    initTakeover = ->
      console.log 'takeover injecting'
      injector = document.createElement('script');
      injector.setAttribute('src', chrome.extension.getURL('takeover.js'))
      injector.setAttribute('polymer', chrome.extension.getURL('polymer/polymer.html'))
      injector.setAttribute('takeover', chrome.extension.getURL('takeover-app.html'))
      document.querySelector('head').appendChild(injector)

    takeoverInjector = document.querySelector('script[takeover]')

    injectPolymer = ->
      polymer = document.createElement 'link'
      polymer.setAttribute 'rel', 'import'
      polymer.setAttribute 'href', takeoverInjector.getAttribute('polymer')
      document.querySelector('head').appendChild(polymer)
      console.log 'Polymer injected'

    injectTakeover = ->
      Polymer.import [takeoverInjector.getAttribute('takeover')], ->
        console.log 'taken over'

This content script has 2 main stages.

## Stage 1 - (Extension Level)

    if chrome?.extension
      initTakeover()
    else # In the content page!

## Stage 2 - (Content Page Level)
Now in the page, detect if Polymer is available and inject polymer.

      if Platform?
        console.log 'Polymer present'
        injectTakeover()
      else # Needs Polymer!

When polymer is not there, set up the listener that will injectTakeover() and
then start injecting polymer.

`injectTakeover()` will make it our `takeover-app`.

        document.addEventListener 'polymer-ready', ->
          injectTakeover()

        injectPolymer()
