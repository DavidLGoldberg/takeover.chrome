This content script is multiple stage.

## Stage 1
Inject itself into a running we page as a content script. Note that this
injects the compiled 'as js' version of this script, along with the location
of polymer, as the `getURL` call will not be available once in page.

    if chrome?.extension
      console.log 'takeover injecting'
      injector = document.createElement('script');
      injector.setAttribute('src', chrome.extension.getURL('takeover.js'))
      injector.setAttribute('platform', chrome.extension.getURL('polymer/platform.js'))
      injector.setAttribute('polymer', chrome.extension.getURL('polymer/polymer.html'))
      injector.setAttribute('takeover', chrome.extension.getURL('takeover-app.html'))
      document.querySelector('head').appendChild(injector)

## Stage 2
Now in the page, detect if Polymer is available and inject polymer.

    if not chrome?.extension
      if Platform?
        console.log 'Polymer present'
      else
        console.log('Polymer injecting')
        injector = document.querySelector('script[platform]')
        platform = document.createElement('script')
        platform.setAttribute('src', injector.getAttribute('platform'))
        document.querySelector('head').appendChild(platform)

        polymer = document.createElement('link')
        polymer.setAttribute('rel', 'import')
        polymer.setAttribute('href', injector.getAttribute('polymer'))
        document.querySelector('head').appendChild(polymer)

## Stage 3
This is a followon to stage 2.
When there is polymer, inject the takeover by importing the polymer element
that is our `takeover-app`.

      document.addEventListener 'polymer-ready', ->
        injector = document.querySelector('script[takeover]')
        Polymer.import [injector.getAttribute('takeover')], ->
          console.log 'taken over'

## Header Errors
The Polymer loader likes to be able to deal with redirects, but it can't deal
with the lack of headers coming from Chrome extensions.

    real_getResponseHeader = XMLHttpRequest.prototype.getResponseHeader
    XMLHttpRequest::getResponseHeader = (header) ->
      try
        headers = this.getAllResponseHeaders()
        if (headers.indexOf("Location") >= 0)
          return real_getResponseHeader.call(this, header)
        else
          return undefined
      catch e
        return undefined
