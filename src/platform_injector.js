//bootstrap polymer platform shims if not detected

if (typeof Platform === "undefined") {
  //trap header access
  var real_getResponseHeader = XMLHttpRequest.prototype.getResponseHeader;
  XMLHttpRequest.prototype.getResponseHeader = function(header) {
    try {
      var headers = this.getAllResponseHeaders();
      if (headers.indexOf("Location") >= 0) {
        return real_getResponseHeader.call(this, header);
      } else {
        return undefined;
      }
    } catch (e) {
      return undefined;
    }
  }

  console.log('Polymer injecting');
  var injector = document.querySelector('script[platform]');
  var platform = document.createElement('script');
  platform.setAttribute('src', injector.getAttribute('platform'));
  document.querySelector('head').appendChild(platform);

  var takeover = document.createElement('link');
  takeover.setAttribute('rel', 'import');
  takeover.setAttribute('href', injector.getAttribute('polymer'));
  document.querySelector('head').appendChild(takeover);
} else {
  console.log('Polymer present');
}
