importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyBKhWhaiQXobm8zUomHxIR265KygbsUsLg",
    authDomain: "sparks-35c8b.firebaseapp.com",
    projectId: "sparks-35c8b",
    storageBucket: "sparks-35c8b.appspot.com",
    messagingSenderId: "338407139909",
    appId: "1:338407139909:web:99d33d08c116ee2ab7d12c",
    measurementId: "G-1HQ9VY9600"
});
const messaging = firebase.messaging();
// messaging.onBackgroundMessage((message) => {
//     console.log("onBackgroundMessage", message);
//   });
//   messaging.onMessage(function(payload){
//     console.log('onMessage',payload);
// });

// messaging.usePublicVapidKey();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.body
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});
messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
//   self.addEventListener('push', async function(event) {
//     event.waitUntil(
//         self.registration.showNotification('title', {
//           body: 'body'
//         })
//     );
// });