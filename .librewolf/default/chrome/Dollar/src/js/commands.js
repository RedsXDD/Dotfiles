// Display time
time = clock;
function clock(args) {
	var today = new Date();
	block_log(today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds());
}

// Clear the terminal
cl = clear;
function clear(args) {
	document.getElementById('wrapper').innerHTML = "";
}

// Search something on searxng, if no arguments are provided => https://searxng.ca
s = searxng;
function searxng(args) {
	instance = "https://searxng.ca"
	if (args != undefined) {
		search = args.replace(" ", "+")
		window.open(instance + "/search?q=" + search);
	} else {
		window.open(instance);
	}
}

// Search something on brave, if no arguments are provided => https://search.brave.com
b = brave;
function brave(args) {
	if (args != undefined) {
		search = args.replace(" ", "+")
		window.open("https://search.brave.com/search?q=" + search);
	} else {
		window.open("https://search.brave.com");
	}
}

// Search something on duckduckgo, if no arguments are provided => https://duckduckgo.com
d = duckduckgo;
function duckduckgo(args) {
	if (args != undefined) {
		search = args.replace(" ", "+")
		window.open("https://duckduckgo.com/search?q=" + search);
	} else {
		window.open("https://duckduckgo.com");
	}
}

// Search something on google, if no arguments are provided => https://www.google.com
g = google;
function google(args) {
	if (args != undefined) {
		search = args.replace(" ", "+")
		window.open("https://www.google.com/search?q=" + search);
	} else {
		window.open("https://www.google.com");
	}
}
