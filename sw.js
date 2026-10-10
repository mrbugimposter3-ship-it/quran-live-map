const C="qlm-v2";
const SHELL=["./","./index.html","./manifest.webmanifest","./icon-192.png","./icon-512.png"];
self.addEventListener("install",e=>{
  e.waitUntil(caches.open(C).then(c=>c.addAll(SHELL)));
  self.skipWaiting();
});
self.addEventListener("activate",e=>{
  e.waitUntil(caches.keys().then(ks=>Promise.all(ks.filter(k=>k!==C).map(k=>caches.delete(k)))));
  self.clients.claim();
});
/* NETWORK-FIRST: always try the newest version; cache is only the offline fallback.
   (the old cache-first setup froze the app on its first copy - never again) */
self.addEventListener("fetch",e=>{
  if(e.request.method!=="GET")return;
  e.respondWith(
    fetch(e.request).then(res=>{
      const cl=res.clone();caches.open(C).then(c=>c.put(e.request,cl));return res;
    }).catch(()=>caches.match(e.request).then(r=>r||caches.match("./index.html")))
  );
});
