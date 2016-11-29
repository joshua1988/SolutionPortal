importScripts('dist/js/sw-toolbox/sw-toolbox.js');

const precacheFiles = [
    // app shell
    './',
    './main.js',
    './sw.js',
    // js
    './dist/js/board.js',
    './dist/js/common.js',
    './dist/js/customUser.js',
    './dist/js/file.js',
    './dist/js/licenseManagement.js',
    './dist/js/morgue2.js',
    './dist/js/signin.js',
    './dist/js/tree.js',
    './dist/materialize/js/materialize.js',
    './dist/materialize/js/materialize.min.js',
    // css
    './dist/bootstrap/css/bootstrap.css',
    './dist/bootstrap/css/bootstrap.min.css',
    './dist/materialize/css/materialize.css',
    './dist/materialize/css/materialize.min.css',
    // images
    './dist/images/folder_structure.png',
    './dist/images/GluePDJang.png',
    './dist/images/GluePDKang.png',
    './dist/images/GluePDCho.png',
    './dist/images/GluePMHwang.png',
    './dist/images/GlueShin.png',
    './dist/images/guest.png',
    './dist/images/PosBeeKang.png',
    './dist/img/mainLogo.gif',
    './dist/img/push.png'
];

// Precache the files
toolbox.precache(precacheFiles);

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
