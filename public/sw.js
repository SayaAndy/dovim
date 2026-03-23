var version = 9;
var cacheKey = 'movim_' + version;

const channel = new BroadcastChannel('messages');

self.addEventListener('install', (e) => {
    // Workaround for https://issues.chromium.org/issues/466790291
    e.addRoutes({
        condition: {
            urlPattern: new URLPattern({})
        },
        source: "fetch-event"
    });

    e.waitUntil(
        caches.open(cacheKey).then((cache) => cache.addAll([
            '/scripts/libsignal_protocol.min.js',
            '/scripts/thumbhash.js',
            '/scripts/movim_emojis_list.js',
            '/theme/audio/call.opus',
            '/theme/audio/message.ogg',
            '/theme/fonts/MaterialSymbols/MaterialSymbols-Outlined.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmSU5fCRc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmSU5fABc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmSU5fCBc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmSU5fBxc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmSU5fCxc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmSU5fChc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmSU5fBBc4.woff2',
            '/theme/fonts/Roboto/KFOmCnqEu92Fr1Mu72xKOzY.woff2',
            '/theme/fonts/Roboto/KFOmCnqEu92Fr1Mu5mxKOzY.woff2',
            '/theme/fonts/Roboto/KFOmCnqEu92Fr1Mu7mxKOzY.woff2',
            '/theme/fonts/Roboto/KFOmCnqEu92Fr1Mu4WxKOzY.woff2',
            '/theme/fonts/Roboto/KFOmCnqEu92Fr1Mu7WxKOzY.woff2',
            '/theme/fonts/Roboto/KFOmCnqEu92Fr1Mu7GxKOzY.woff2',
            '/theme/fonts/Roboto/KFOmCnqEu92Fr1Mu4mxK.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmEU9fCRc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmEU9fABc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmEU9fCBc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmEU9fBxc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmEU9fCxc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmEU9fChc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmEU9fBBc4.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmWUlfCRc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmWUlfABc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmWUlfCBc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmWUlfBxc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmWUlfCxc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmWUlfChc4EsA.woff2',
            '/theme/fonts/Roboto/KFOlCnqEu92Fr1MmWUlfBBc4.woff2',
            '/theme/fonts/Philosopher/vEFX2_5QCwIS4_Dhez5jcWBrf0I81_idV7b-rQ.woff2',
            '/theme/fonts/Philosopher/vEFI2_5QCwIS4_Dhez5jcWjValgf8te1Xb7GlMo.woff2',
            '/theme/fonts/Philosopher/vEFI2_5QCwIS4_Dhez5jcWjValgV8te1Xb7GlMo.woff2',
            '/theme/fonts/Philosopher/vEFK2_5QCwIS4_Dhez5jcWBrd_QZwtG_WpzEpMvsfA.woff2',
            '/theme/fonts/Philosopher/vEFX2_5QCwIS4_Dhez5jcWBrf0881_idV7Y.woff2',
            '/theme/fonts/Philosopher/vEFK2_5QCwIS4_Dhez5jcWBrd_QZwti_WpzEpMvsfA.woff2',
            '/theme/fonts/Philosopher/vEFV2_5QCwIS4_Dhez5jcWBjT0020NqfZ7c.woff2',
            '/theme/fonts/Philosopher/vEFI2_5QCwIS4_Dhez5jcWjValgW8te1Xb7GlMo.woff2',
            '/theme/fonts/Philosopher/vEFX2_5QCwIS4_Dhez5jcWBrf0s81_idV7b-rQ.woff2',
            '/theme/fonts/Philosopher/vEFV2_5QCwIS4_Dhez5jcWBqT0020NqfZ7c.woff2',
            '/theme/fonts/Philosopher/vEFV2_5QCwIS4_Dhez5jcWBuT0020Nqf.woff2',
            '/theme/fonts/Philosopher/vEFI2_5QCwIS4_Dhez5jcWjValgb8te1Xb7G.woff2',
            '/theme/fonts/Philosopher/vEFK2_5QCwIS4_Dhez5jcWBrd_QZwtu_WpzEpMvsfA.woff2',
            '/theme/fonts/Philosopher/vEFK2_5QCwIS4_Dhez5jcWBrd_QZwtq_WpzEpMvsfA.woff2',
            '/theme/fonts/Philosopher/vEFV2_5QCwIS4_Dhez5jcWBhT0020NqfZ7c.woff2',
            '/theme/fonts/Philosopher/vEFX2_5QCwIS4_Dhez5jcWBrf0A81_idV7b-rQ.woff2',
            '/theme/fonts/Philosopher/vEFK2_5QCwIS4_Dhez5jcWBrd_QZwtW_WpzEpMs.woff2',
            '/theme/fonts/Philosopher/vEFV2_5QCwIS4_Dhez5jcWBgT0020NqfZ7c.woff2',
            '/theme/fonts/Philosopher/vEFX2_5QCwIS4_Dhez5jcWBrf0E81_idV7b-rQ.woff2',
            '/theme/fonts/Philosopher/vEFI2_5QCwIS4_Dhez5jcWjValgU8te1Xb7GlMo.woff2',
        ]))
    );
});

self.addEventListener('activate', function (e) {
    e.waitUntil(caches.keys().then(keys => {
        return Promise.all(keys
            .filter(key => key != cacheKey)
            .map(key => caches.delete(key))
        );
    }).then(function () {
        return self.clients.claim();
    }));
});

self.addEventListener('push', function (e) {
    var json = e.data.json();
    var options = {
        body: json.body,
        icon: json.picture,
        badge: '/theme/img/app/badge.png',
        vibrate: [100, 50, 100],
        data: { url: json.action },
        actions: [{ action: json.action, title: json.actionButton }],
        timestamp: json.timestamp * 1000,
        tag: json.group,
    };
    e.waitUntil(
        self.registration.showNotification(json.title, options)
    );
});

self.addEventListener('notificationclick', function (e) {
    e.waitUntil(
        clients
            .matchAll({
                type: "window",
            })
            .then((clientList) => {
                for (const client of clientList) {
                    if ("focus" in client) return client.focus();
                }
                if (clients.openWindow) return clients.openWindow(e.notification.data.url);
            }),
    );

    channel.postMessage({ type: e.action, data: e.notification.data });

    e.notification.close();
});

self.addEventListener('fetch', (e) => {
    e.respondWith(
        caches.match(e.request).then((response) => response || fetch(e.request)),
    );
});
