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

          pushMessageConstructor(data);

          return self.registration.showNotification(pushData.title, {
            body: pushData.body,
            icon: pushData.icon,
            tag: pushData.tag
          });
        });
      }).catch(function(err) {
        console.error('Unable to retrieve data', err);

        pushData.title = '오류 발생';
        pushData.body = 'Push 메시지 정보를 받지 못하였습니다.';
        pushData.icon = 'dist/img/push.png';
        pushData.tag = 'notification-error';
        return self.registration.showNotification(pushData.title, {
            body: pushData.body,
            icon: pushData.icon,
            tag: pushData.tag
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

// Push Messages Constructor
var pushMessageConstructor = function (data) {
  var postTypeKR = "",
      pushConstructor = data[0];

  postTypeKR = pushConstructor.POST_TYPE == "board" ? "게시글" : "댓글";
  pushData.title = "새로운 " + postTypeKR + " 등록";
  if (postTypeKR == "게시글") {
    pushData.body = "[" + pushConstructor.SOLUTION_TYPE + " " + pushConstructor.BOARD_TYPE + " 게시판] \n" +
                      "제목: " + pushConstructor.POST_TITLE + " \n" +
                      "작성자: " + pushConstructor.USER;
  } else {
    pushData.body = "[" + pushConstructor.SOLUTION_TYPE + " " + pushConstructor.BOARD_TYPE + " 게시판] \n" +
                      "내용: " + pushConstructor.CONTENT + " \n" +
                      "작성자: " + pushConstructor.USER;
  }
  pushData.icon = 'dist/img/push.png';
  pushData.tag = pushConstructor.POST_TYPE;

  return pushData;
};
