// Scripts for Push
var isPushEnabled = false,
    pushSwitch = document.querySelector('#pushSwitch'),
    pushStatus = document.querySelector('#pushStatus'),
    useNotifications = false;

window.addEventListener('load', function() {
  pushSwitch.addEventListener('click', function() {
    if (isPushEnabled) {
      unsubscribe();
    } else {
      subscribe();
    }
  });

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
  // 서비스워커 의 notification 유무 확인
  if (!(reg.showNotification)) {
    console.log('Notifications aren\'t supported on service workers.');
    useNotifications = false;
  } else {
    useNotifications = true;
  }

  // notification 권한 확인
  if (Notification.permission === 'denied') {
    console.log('The user has blocked notifications.');
    return;
  }

  // Push 메시지 지원여부 확인
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

        // subscription 상태가 아닌 경우
        if (!subscription) {
          console.log('Not yet subscribed to Push');
          // We aren't subscribed to push, so set UI
          // to allow the user to enable push
          return;
        }

        // subscription 상태인 경우
        isPushEnabled = true;
        updatePushSwitch();

        console.log("subscription : ", subscription.toJSON());

        var endpoint = subscription.endpoint;
        var key = subscription.getKey('p256dh');
        updateStatus(endpoint, key, 'init');
      }).catch(function(err) {
        console.log('Error during getSubscription()', err);
      });

  });
}

function subscribe() {
  navigator.serviceWorker.ready.then(function(reg) {
    reg.pushManager.subscribe({userVisibleOnly: true}).then(function(subscription) {

        isPushEnabled = true;
        updatePushSwitch();

        // Update status to subscribe current user on server, and to let
        // other users know this user has subscribed
        var endpoint = subscription.endpoint;
        var key = subscription.getKey('p256dh');
        updateStatus(endpoint, key, 'subscribe');

      }).catch(function(e) {
        if (Notification.permission === 'denied') {
          // 사용자가 알람 권한을 설정하지 않은 경우
          console.log('Permission for Notifications was denied');
        } else {
          // subscription 관련한 에러 발생시,
          // gcm_sender_id 또는 gcm_user_visible_only 를 확인
          console.log('Unable to subscribe to push.', e);
          pushStatus.innerHTML = "알림 설정이 필요합니다";
        }
      });
  });
}

function unsubscribe() {

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
        updateStatus(endpoint,key,'unsubscribe');

        // Check we have a subscription to unsubscribe
        if (!subscription) {
          isPushEnabled = false;
          updatePushSwitch();

          return;
        }

        subscription.unsubscribe().then(function(successful) {
          isPushEnabled = false;
          updatePushSwitch();

          console.log("unsubscribe clicked");
        }).catch(function(e) {
          // We failed to unsubscribe, this can lead to
          // an unusual state, so may be best to remove
          // the subscription id from your data store and
          // inform the user that you disabled push

          console.log('Unsubscription error: ', e);
        });

        // setTimeout used to stop unsubscribe being called before the message
        // has been sent to everyone to tell them that the unsubscription has
        // occurred, including the person unsubscribing. This is a dirty
        // hack, and I'm probably going to hell for writing this.
        // setTimeout(function() {
          // We have a subcription, so call unsubscribe on it
        // }, 3000);

      }).catch(function(e) {
        console.log('Error thrown while unsubscribing from ' + 'push messaging.', e);
      });
  });
}

function updatePushSwitch() {
  if (isPushEnabled) {
    pushSwitch.checked = true;
    pushStatus.innerHTML = "Push is on";
  } else {
    pushSwitch.checked = false;
    pushStatus.innerHTML = "Push is off";
  }
}

function updateStatus(endpoint, key, status) {

  // endpoint 키 값 추출
  endpoint = endpoint.split("send/")[1];
  // Key 값 변환 (Array Buffer to Byte)
  key = btoa(String.fromCharCode.apply(null, new Uint8Array(key)));
  // console.log(" updateStatus endpoint :" + endpoint + ".\n key : " + key + ".\n status : " + status);
  console.log(status);

  var data = {
    "endpoint" : endpoint,
    "key" : key,
    "subscription_status" : status
  };

  // 16.11.28 (Mon)
  // send the endpoint to server
  fetch('/solutionpot/push/subscription', {
    method: 'post',
    headers: new Headers({
      'Content-Type': 'application/json'
    }),
    body: JSON.stringify(data)
  }).catch(function(err) {
    console.log("Sending subscription error : ", err);
  });
}
