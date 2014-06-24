console.log('takeover')

var injector = document.createElement('script');
injector.setAttribute('src', chrome.extension.getURL('platform_injector.js'));
injector.setAttribute('platform', chrome.extension.getURL('platform.js'));
injector.setAttribute('polymer', chrome.extension.getURL('polymer.html'));
document.querySelector('head').appendChild(injector);
