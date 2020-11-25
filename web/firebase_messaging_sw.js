importScripts('https://www.gstatic.com/firebasejs/7.22.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/7.22.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing in the
// messagingSenderId.
firebase.initializeApp({
    apiKey: "AIzaSyC2x4RDEhCAc6VWR8WnnCpq9ozYITtMrlk",
    authDomain: "mahoganequeue.firebaseapp.com",
    databaseURL: "https://mahoganequeue.firebaseio.com",
    projectId: "mahoganequeue",
    storageBucket: "mahoganequeue.appspot.com",
    messagingSenderId: "466597325221",
    appId: "1:466597325221:web:7eccc88f0de873b908604c",
    measurementId: "G-W109GWY1PL"
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
console.log('setBackgourd')

const messaging = firebase.messaging();
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
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});