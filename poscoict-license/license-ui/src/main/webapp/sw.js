self.addEventListener('push', function(event) {
//  console.log('Received a push message', event);

  // var title = 'Yay a message.';
  // var body = 'We have received a push message.';
  // var icon = 'dist/img/push.png';
  // var tag = 'simple-push-demo-notification-tag';

  event.waitUntil(fetch("/solutionpot/greeting").then(function(response) {
        if (response.status !== 200) {
          // Either show a message to the user explaining the error
          // or enter a generic message and handle the
          // onnotificationclick event to direct the user to a web page
          console.log('Looks like there was a problem. Status Code: ' + response.status);
          throw new Error();
        }

        // Examine the text in the response
        return response.json().then(function(data) {
          console.log("response data : ", data);
          if (!data === undefined) {
            console.error('The API returned an error.', data.error);
            throw new Error();
          }

          var title = 'Yay another message.';
          var body = data.content;
          var icon = 'dist/img/push.png';
          var tag = 'simple-push-demo-notification-tag';

          return self.registration.showNotification(title, {
            body: body,
            icon: icon,
            tag: tag
          });
        });
      }).catch(function(err) {
        console.error('Unable to retrieve data', err);

        var title = 'An error occurred';
        var body = 'We were unable to get the information for this push message';
        var icon = 'dist/img/push.png';
        var notificationTag = 'notification-error';
        return self.registration.showNotification(title, {
            body: body,
            icon: icon,
            tag: notificationTag
          });
      })
    );

  // original
  // event.waitUntil(
  //   self.registration.showNotification(title, {
  //     body: body,
  //     icon: icon,
  //     tag: tag
  //   })
  // );
});

self.addEventListener('notificationclick', function(event) {
  console.log('[Service Worker] Notification click Received.');

  event.notification.close();

  event.waitUntil(
    clients.openWindow('http://www.solutionpot.co.kr/')
  );
});
