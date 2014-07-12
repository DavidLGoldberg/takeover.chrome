## Header Errors
The Polymer loader likes to be able to deal with redirects, but it can't deal
with the lack of headers coming from Chrome extensions.

    if chrome?.extension
      console.log 'xhr patch injecting'
      injector = document.createElement('script');
      injector.setAttribute('src', chrome.extension.getURL('xhr.js'))
      document.querySelector('head').appendChild injector
    else
      console.log 'hooking getResponseHeader'
      request = window._XMLHttpRequest or window.XMLHttpRequest
      real_getResponseHeader = XMLHttpRequest.prototype.getResponseHeader
      request::getResponseHeader = (header) ->
        try
          headers = this.getAllResponseHeaders()
          if (headers.indexOf("Location") >= 0)
            return real_getResponseHeader.call(this, header)
          else
            return undefined
        catch e
          return undefined
