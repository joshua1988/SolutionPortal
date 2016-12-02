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

// var title, body, icon, tag;
var pushData = {
  title: "",
  body: "",
  icon: "",
  tag: ""
};

self.addEventListener('push', function(event) {
//  console.log('Received a push message', event);

  event.waitUntil(fetch("/solutionpot/push/fetch/messages").then(function(response) {
        if (response.status !== 200) {
          // Either show a message to the user explaining the error
          // or enter a generic message and handle the
          // onnotificationclick event to direct the user to a web page
          console.log('Looks like there was a problem. Status Code: ' + response.status);
          throw new Error();
        }

        // Examine the text in the response
        return response.json().then(function(data) {

          if (!data === undefined) {
            console.error('The API returned an error.', data.error);
            throw new Error();
          }
          console.log("response data : ", data);
          console.log("response data length : ", data.length);

          // Push Messages Constructor
          var pushConstructor = {};
          pushConstructor = data[0];

          if (data.length > 1) {
            console.log("Push 메시지가 여러개입니다.");
          } else {
            console.log("새 메시지가 하나입니다.");;
          }

          console.log("pushConstructor : ", pushConstructor);

          pushConstructor.post_type == "board" ? "게시글" : "댓글";
          pushData.title = "새로운 " + pushConstructor.BOARD_TYPE + "이 게시되었습니다.";
          pushData.body = pushConstructor.SOLUTION_TYPE + " / " + pushConstructor.BOARD_TYPE + " / " + pushConstructor.POST_TITLE + " / " +  pushConstructor.USER + "가 작성";
          pushData.icon = 'dist/img/push.png';
          pushData.tag = pushConstructor.POST_TYPE;
          // constructor end

          console.log("pushData : ", pushData);

          return self.registration.showNotification(pushData.title, {
            body: pushData.body,
            icon: pushData.icon,
            tag: pushData.tag
          });
        });
      }).catch(function(err) {
        console.error('Unable to retrieve data', err);

        title = 'An error occurred';
        body = 'We were unable to get the information for this push message';
        icon = 'dist/img/push.png';
        notificationTag = 'notification-error';
        return self.registration.showNotification(title, {
            body: body,
            icon: icon,
            tag: notificationTag
          });
      })
    );

});

self.addEventListener('notificationclick', function(event) {
  console.log('[Service Worker] Notification click Received.');

  event.notification.close();

  event.waitUntil(
    clients.openWindow('http://www.solutionpot.co.kr/')
  );
});

var pushMessageConstructor = function (data) {
  var msg = {};

  console.log("constructor's data : ", data);

  // data = data[1];



  console.log("constructor's msg : ", msg);

  return msg;
}
