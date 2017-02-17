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
    './dist/images/icons/icon-32x32.png',
    './dist/images/icons/icon-48x48.png',
    './dist/images/icons/icon-128x128.png',
    './dist/images/icons/icon.png',
    './dist/images/icons/ch_icon.png',
    './dist/images/icons/apple-touch-icon.png',
    './dist/images/icons/chrome-touch-icon.png',
    './dist/images/folder_structure.png',
    './dist/images/GluePDJang.png',
    './dist/images/GluePDKang.png',
    './dist/images/GluePDCho.png',
    './dist/images/GluePMHwang.png',
    './dist/images/GlueShin.png',
    './dist/images/guest.png',
    './dist/images/PosBeeKang.png',
    './dist/img/mainLogo.gif',
    './dist/img/arrow_top.gif',
    './dist/img/delete_reply.png',
    './dist/img/push.png',
    // favicon
    './dist/images/favicon/android-icon-36x36.png',
    './dist/images/favicon/android-icon-48x48.png',
    './dist/images/favicon/android-icon-72x72.png',
    './dist/images/favicon/android-icon-96x96.png',
    './dist/images/favicon/android-icon-144x144.png',
    './dist/images/favicon/android-icon-192x192.png',
    './dist/images/favicon/apple-icon-57x57.png',
    './dist/images/favicon/apple-icon-60x60.png',
    './dist/images/favicon/apple-icon-72x72.png',
    './dist/images/favicon/apple-icon-76x76.png',
    './dist/images/favicon/apple-icon-114x114.png',
    './dist/images/favicon/apple-icon-120x120.png',
    './dist/images/favicon/apple-icon-144x144.png',
    './dist/images/favicon/apple-icon-152x152.png',
    './dist/images/favicon/apple-icon-180x180.png',
    './dist/images/favicon/apple-icon-precomposed.png',
    './dist/images/favicon/apple-icon.png',
    './dist/images/favicon/favicon-16x16.png',
    './dist/images/favicon/favicon-32x32.png',
    './dist/images/favicon/favicon-96x96.png'
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

  event.waitUntil(fetch("/license/push/fetch/message").then(function(response) {
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
        pushData.icon = 'dist/images/icons/icon-48x48.png';
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
    clients.openWindow('https://www.solutionpot.co.kr')
  )

  // 노티를 클릭하고 나면, 읽기 체크가 가능하도록?
  // fetch("/license/push/update/messages")
});

// Push Messages Constructor
var pushMessageConstructor = function (data) {
  var postTypeKR = "",
      pushConstructor = data[0],
      pushContent= "",
      pushTitle="";

  // streamlining the raw push data
  postTypeKR = pushConstructor.POST_TYPE == "board" ? "게시글" : "댓글";
  pushConstructor.POST_TITLE.length > 16 ? pushTitle = pushConstructor.POST_TITLE.substring(0,15) + "..." : pushTitle = pushConstructor.POST_TITLE;
  pushConstructor.CONTENT.length > 16 ? pushContent = pushConstructor.CONTENT.substring(0,15) + "..." : pushContent = pushConstructor.CONTENT;

  pushData.title = "새로운 " + postTypeKR + " 등록";
  if (postTypeKR == "게시글") {
    pushData.body = "[" + pushConstructor.SOLUTION_TYPE + " " + pushConstructor.BOARD_TYPE + " 게시판] \n" +
                      "제목: " + pushTitle + " \n" +
                      "작성자: " + pushConstructor.USER.substring(0, 15);
  } else if (postTypeKR == "댓글") {
    pushData.body = "[" + pushConstructor.SOLUTION_TYPE + " " + pushConstructor.BOARD_TYPE + " 게시판] \n" +
                      "내용: " + pushContent + " \n" +
                      "작성자: " + pushConstructor.USER.substring(0, 15);
  }
  pushData.icon = 'dist/images/icons/icon-48x48.png';
  pushData.tag = pushConstructor.POST_TYPE;

  return pushData;
};
