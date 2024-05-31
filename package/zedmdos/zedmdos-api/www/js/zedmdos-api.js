
function hex2rgb(hex) {
    return {"r": '0x' + hex[1] + hex[2] | 0, "g": '0x' + hex[3] + hex[4] | 0, "b": '0x' + hex[5] + hex[6] | 0};
}

function getClockVals() {
    var style = document.querySelector('input[name="clock-style"]:checked').value;
    var format = "";
    switch(style) {
    case "h12":
	format = "%-I:%M %p";
	break;
    case "h12s":
	format = "%-I:%M:%S %p";
	break;
    case "h24":
	format = "%H:%M";
	break;
    case "h24s":
	format = "%H:%M:%S";
	break;
    case "custom":
	format = document.getElementById("clock-custom").value;
	break;
    }
    return {
        "color": hex2rgb(document.getElementById("clock-color").value),
	"format": format
    }
}

function getCountdownVals() {
    var to = document.getElementById("countdown-to").value;
    if(to) to = to.replace("T", " ") + ":00";

    return {
	"color": hex2rgb(document.getElementById("countdown-color").value),
	"to": to
    }
}

function getTextVals() {
    return {
	"color": hex2rgb(document.getElementById("text-color").value),
	"text":  document.getElementById("text-text").value
    }
}

function setMenu(menu) {
    document.getElementById("content-clock")    .style.display = (menu == "clock"     ? "block" : "none");
    document.getElementById("content-countdown").style.display = (menu == "countdown" ? "block" : "none");
    document.getElementById("content-text")     .style.display = (menu == "text"      ? "block" : "none");
    document.getElementById("content-image")    .style.display = (menu == "image"     ? "block" : "none");
    document.getElementById("content-clear")    .style.display = (menu == "clear"     ? "block" : "none");
}

function addListeners() {
    // menu
    document.getElementById("tab-clock")    .addEventListener('click', function() { setMenu("clock");     updateClock();     });
    document.getElementById("tab-countdown").addEventListener('click', function() { setMenu("countdown"); updateCountdown(); });
    document.getElementById("tab-text")     .addEventListener('click', function() { setMenu("text");      updateText();      });
    document.getElementById("tab-image")    .addEventListener('click', function() { setMenu("image");     updateImageTab();     });
    document.getElementById("tab-clear")    .addEventListener('click', function() { setMenu("clear");     updateClear();     });

    // clock
    document.getElementById("clock-color")          .addEventListener('change', function() { updateClock(); });
    document.getElementById("clock-h24")            .addEventListener('click',  function() { updateClock(); });
    document.getElementById("clock-h24s")           .addEventListener('click',  function() { updateClock(); });
    document.getElementById("clock-h12")            .addEventListener('click',  function() { updateClock(); });
    document.getElementById("clock-h12s")           .addEventListener('click',  function() { updateClock(); });
    document.getElementById("clock-custom-enabled") .addEventListener('click',  function() { updateClock(); });
    document.getElementById("clock-custom")         .addEventListener('keyup',  function() { updateClock(); });

    // countdown
    document.getElementById("countdown-color").addEventListener('change', function() { updateCountdown(); });
    document.getElementById("countdown-to")   .addEventListener('change', function() { updateCountdown(); });

    // text
    document.getElementById("text-color").addEventListener('change', function() { updateText(); });
    document.getElementById("text-text") .addEventListener('input', function() { updateText(); });

    // image
}

function updateClock() {
    var vals = getClockVals();
    var host = location.hostname;
    if(host == "") host = "localhost";
    updateZoneDmdplay("dmd-play.py --host " + host + " --clock --clock-format \"" + vals.format + "\" -r " + vals.color.r + " -g " + vals.color.g + " -b " + vals.color.b);
    updateZoneCurl("curl -X POST \"" + encodeURI("http://" + host + "/clock?format=" + vals.format + "&r=" + vals.color.r + "&g=" + vals.color.g + "&b=" + vals.color.b) + "\"");
    fetch('/clock?format='+vals.format+"&r="+vals.color.r+"&g="+vals.color.g+"&b="+vals.color.b, { method: "POST" }); // do nothing in case of error
}

function updateCountdown() {
    var vals = getCountdownVals();
    var host = location.hostname;
    if(host == "") host = "localhost";

    if(vals.to) {
	updateZoneDmdplay("dmd-play.py --host " + host + " --countdown \"" + vals.to + "\" -r " + vals.color.r + " -g " + vals.color.g + " -b " + vals.color.b);
    } else {
	updateZoneDmdplay("");
    }
    updateZoneCurl("curl -X POST \"" + encodeURI("http://" + host + "/countdown?" + (vals.to ? ("to=" + vals.to + "&") : "") + "r=" + vals.color.r + "&g=" + vals.color.g + "&b=" + vals.color.b) + "\"");

    var opt = ""
    if(vals.to) { opt += "to=" + vals.to + "&"; }
    fetch('/countdown?'+opt+"r="+vals.color.r+"&g="+vals.color.g+"&b="+vals.color.b, { method: "POST" }); // do nothing in case of error
}

function updateText() {
    var vals = getTextVals();
    var host = location.hostname;
    if(host == "") host = "localhost";
    updateZoneDmdplay("dmd-play.py --host " + host + " --text \"" + vals.text + "\" -r " + vals.color.r + " -g " + vals.color.g + " -b " + vals.color.b);
    updateZoneCurl("curl -X POST \"" + encodeURI("http://" + host + "/text?text=" + vals.text + "&r=" + vals.color.r + "&g=" + vals.color.g + "&b=" + vals.color.b) + "\"");
    fetch('/text?text='+vals.text+"&r="+vals.color.r+"&g="+vals.color.g+"&b="+vals.color.b, { method: "POST" }); // do nothing in case of error
}

function updateImageTab() {
    fetch("images/list")
	.then(res => res.json())
	.then(data => {
	    var html = "";
	    data.forEach(function(obj) {
	    	html += "<img class=\"image-miniature\" src=\"images/contents/" + obj + "\" onclick=\"updateImage('" + obj + "')\" />";
	    });
	    if(html == "") html = "Put your .png, .gif in the configs/images folder.";
	    document.getElementById("image-images").innerHTML = html;
	});
}

function updateImage(img) {
    var host = location.hostname;
    if(host == "") host = "localhost";

    updateZoneDmdplay("dmd-play.py --host " + host + " -f \"" + img + "\"");
    updateZoneCurl("curl -X POST \"" + encodeURI("http://" + host + "/image?file="+img) + "\"");
    fetch('/image?file='+img, { method: "POST" }); // do nothing in case of error
}

function updateClear() {
    var host = location.hostname;
    if(host == "") host = "localhost";
    updateZoneDmdplay("dmd-play.py --host " + host + " --clear");
    updateZoneCurl("curl -X POST \"" + encodeURI("http://" + host + "/clear") + '"');
    fetch('/clear', { method: "POST" }); // do nothing in case of error
}

function updateZoneDmdplay(code) {
    document.getElementById("code-zone-dmdplay").innerHTML = code;
}

function updateZoneCurl(code) {
    document.getElementById("code-zone-curl").innerHTML = code;
}

window.addEventListener('load', function() {
    addListeners();
});
