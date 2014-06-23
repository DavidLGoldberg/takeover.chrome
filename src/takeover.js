
var platform = document.createElement('script');
platform.setAttribute('src', chrome.extension.getURL('platform.js'));
document.querySelector('head').appendChild(platform);

var takeover = document.createElement('link');
takeover.setAttribute('rel', 'import');
takeover.setAttribute('href', chrome.extension.getURL('takeover.html'));
document.querySelector('head').appendChild(takeover);
