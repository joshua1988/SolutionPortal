var isPushEnabled = false;
var pushBtn = document.querySelector('#pushBtn');
var pushSwitch = document.querySelector('#pushSwitch');

var useNotifications = false;

window.addEventListener('load', function() {
  pushBtn.addEventListener('click', function() {
    if (isPushEnabled) {
      unsubscribe();
    } else {
      subscribe();
    }
  });

  // Check that service workers are supported, if so, progressively
  // enhance and add push messaging support, otherwise continue without it.
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('https://'+location.host+'/solutionpot/sw.js').then(function(reg) {
      if(reg.installing) {
        console.log('Service worker installing');
      } else if(reg.waiting) {
        console.log('Service worker installed');
      } else if(reg.active) {
        console.log('Service worker active');
      }

      initialiseState(reg);
    });
  } else {
    console.log('Service workers aren\'t supported in this browser.');
  }
});

function initialiseState(reg) {
  // Are Notifications supported in the service worker?
  if (!(reg.showNotification)) {
    console.log('Notifications aren\'t supported on service workers.');
    useNotifications = false;
  } else {
    useNotifications = true;
  }

  // Check the current Notification permission.
  // If its denied, it's a permanent block until the
  // user changes the permission
  if (Notification.permission === 'denied') {
    console.log('The user has blocked notifications.');
    return;
  }

  // Check if push messaging is supported
  if (!('PushManager' in window)) {
    console.log('Push messaging isn\'t supported.');
    return;
  } else {
    console.log("PushManager is supported.");
  }

  // We need the service worker registration to check for a subscription
  navigator.serviceWorker.ready.then(function(reg) {
    // Do we already have a push message subscription?
    reg.pushManager.getSubscription().then(function(subscription) {
        // Enable any UI which subscribes / unsubscribes from
        // push messages.

        pushBtn.disabled = false;

        if (!subscription) {
          console.log('Not yet subscribed to Push')
          // We aren't subscribed to push, so set UI
          // to allow the user to enable push
          return;
        }

        // Set your UI to show they have subscribed for
        // push messages
        pushBtn.textContent = "알림 끄기";
        pushSwitch.checked = true;
        isPushEnabled = true;

        // initialize status, which includes setting UI elements for subscribed status
        // and updating Subscribers list via push
        console.log(subscription.toJSON());
        var endpoint = subscription.endpoint;
        var key = subscription.getKey('p256dh');
        console.log(key);
//        updateStatus(endpoint,key,'init');
      })
      .catch(function(err) {
        console.log('Error during getSubscription()', err);
      });

      // set up a message channel to communicate with the SW
      var channel = new MessageChannel();
      channel.port1.onmessage = function(e) {
        console.log(e);
        handleChannelMessage(e.data);
      }

      mySW = reg.active;
      mySW.postMessage('hello', [channel.port2]);
  });
}

function subscribe() {
  pushBtn.disabled = true;
  console.log("subscribe is clicked");

  console.log("navigator.serviceWorker.ready : ", navigator.serviceWorker.ready);
  navigator.serviceWorker.ready.then(function(reg) {
    reg.pushManager.subscribe({userVisibleOnly: true}).then(function(subscription) {
        // The subscription was successful
        isPushEnabled = true;
        pushSwitch.checked = true;
        pushBtn.textContent = "알림 끄기";
        pushBtn.disabled = false;

        // Update status to subscribe current user on server, and to let
        // other users know this user has subscribed
        var endpoint = subscription.endpoint;
        var key = subscription.getKey('p256dh');

        // Update the pushMsg info
        // updateStatus(endpoint,key,'subscribe');

        console.log("endpoint : ", endpoint);
        console.log("key :", key);
        console.log("subscription : ", subscription);

        var postData = {
          "endpoint" : endpoint
        };
        // 16.11.28 (Mon)
        // send the endpoint to server
        fetch('/solutionpot/push/subscription', {
        	method: 'post',
          headers: new Headers({
            'Content-Type': 'application/json'
          }),
        	body: JSON.stringify(postData)
          // body: subscription
        }).catch(function(err) {
        	console.log("Sending subscription error : ", err);
        });
      }).catch(function(e) {
        if (Notification.permission === 'denied') {
          // The user denied the notification permission which
          // means we failed to subscribe and the user will need
          // to manually change the notification permission to
          // subscribe to push messages
          console.log('Permission for Notifications was denied');

        } else {
          // A problem occurred with the subscription, this can
          // often be down to an issue or lack of the gcm_sender_id
          // and / or gcm_user_visible_only
          console.log('Unable to subscribe to push.', e);
          pushBtn.disabled = false;
          pushBtn.textContent = '알림 설정';
        }
      });
  });
}

function unsubscribe() {
  pushBtn.disabled = true;

  navigator.serviceWorker.ready.then(function(reg) {
    // To unsubscribe from push messaging, you need get the
    // subcription object, which you can call unsubscribe() on.
    reg.pushManager.getSubscription().then(
      function(subscription) {

        // Update status to unsubscribe current user from server (remove details)
        // and let other subscribers know they have unsubscribed
        var endpoint = subscription.endpoint;
        var key = subscription.getKey('p256dh');

        // Update the pushMsg info
        // updateStatus(endpoint,key,'unsubscribe');

        // Check we have a subscription to unsubscribe
        if (!subscription) {
          // No subscription object, so set the state
          // to allow the user to subscribe to push
          isPushEnabled = false;
          pushSwitch.checked = false;
          pushBtn.disabled = false;
          pushBtn.textContent = '알림 설정';
          return;
        }

        isPushEnabled = false;
        pushSwitch.checked = false;

        // setTimeout used to stop unsubscribe being called before the message
        // has been sent to everyone to tell them that the unsubscription has
        // occurred, including the person unsubscribing. This is a dirty
        // hack, and I'm probably going to hell for writing this.
        setTimeout(function() {
        // We have a subcription, so call unsubscribe on it
        subscription.unsubscribe().then(function(successful) {
          pushBtn.disabled = false;
          pushBtn.textContent = '알림 설정';
          isPushEnabled = false;
          pushSwitch.checked = false;
        }).catch(function(e) {
          // We failed to unsubscribe, this can lead to
          // an unusual state, so may be best to remove
          // the subscription id from your data store and
          // inform the user that you disabled push

          console.log('Unsubscription error: ', e);
          pushBtn.disabled = false;
        })
        },3000);
      }).catch(function(e) {
        console.log('Error thrown while unsubscribing from ' +
          'push messaging.', e);
      });
  });
}
