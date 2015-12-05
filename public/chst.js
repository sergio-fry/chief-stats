var params = {
  url: location.href,
  r: Math.random(),
  referer: document.referrer,
};

var components = [];

for(var i in params) {
  components.push(i + "=" + encodeURIComponent(params[i]));
}

var img = new Image();
img.src = 'http://consumer.charybd.com/api/p/v?' + components.join("&");

