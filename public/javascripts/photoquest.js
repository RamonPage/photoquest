$(function() {
	$("#message").animate({
		opacity: 0
	}, 4000);
	
	$("p#send-quest").click(function() {
		$("#content-extra").show();
	});
});
