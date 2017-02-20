function treeActive () {
	if (treeKey != null) {
		$("#"+treeKey).trigger("click");
	}

	if (!activeKey) {
		console.log("nothing has been active yet");
	} else if(activeKey == "notice" || activeKey == "presentation" || activeKey == "sdkDownload") {
		var activeKeyDom = $("#"+activeKey);
		activeKeyDom.css('background-color', 'rgb(83, 117, 158)');
		activeKeyDom.css('color', '#eafaf9');
	} else {
		// console.log("else : nothing active");
		$("#"+activeKey).addClass("active");
	}

}

function navTreeActive () {
	$("#sidebar").click(function(event) {
		sessionStorage.setItem("navActiveKey", event.target.id);
	});

	if (!navActiveKey) {
//		console.log("nothing on the nav is set");
	} else {
		var activeKeyDom = $("#"+navActiveKey);
		activeKeyDom.css('background-color', '#26a69a');
		activeKeyDom.css('color', '#eafaf9');
	}
}

function treeHeaderValidation (arguments) {

}

function treeActiveValidation () {
	$("#tree").click(function(event) {
		sessionStorage.removeItem("treeKey");
		sessionStorage.removeItem("treeActiveKey");

		if (/^GlueMobile/.test(event.target.id)) {
			sessionStorage.setItem("treeKey", "GlueMobile");
		} else if (/^GlueMaster/.test(event.target.id)) {
			sessionStorage.setItem("treeKey", "GlueMaster");
		} else if (/^Glue/.test(event.target.id)) {
			sessionStorage.setItem("treeKey", "Glue");
		} else if (/^uCUBE/.test(event.target.id)) {
			sessionStorage.setItem("treeKey", "uCUBE");
		} else if (/^PosBee/.test(event.target.id)) {
			sessionStorage.setItem("treeKey", "PosBee");
		} else if (/^Sol/.test(event.target.id)) {
			sessionStorage.setItem("treeKey", "Sol");
		} else if (/^ClientMng/.test(event.target.id)){
			sessionStorage.setItem("treeKey", "ClientMng");
		} else {
			// console.log("nth has been selected yet.");
		}

		sessionStorage.setItem("treeActiveKey", event.target.id);
	});
}
