$(function() {
	var parallax = (function() {
		'use strict';

		var $container = $('.parallax'),
			$divs = $container.find('div.parallax-background'),
			len = $divs.length,
			liHeight = $divs.first().closest('li').height(),
			diffHeight = $divs.first().height() - liHeight,
			bodyScroll = document.documentElement,
			top,
			i,
			$div,
			offset,
			scroll;

			console.log('parallax container');

		return function render() {
			
			top = bodyScroll.scrollTop;
			console.log('body scroll');

			for (i = 0; i < len; i++) {
				$div = $divs.eq(i);
				offset = $div.offset().top;
				scroll = Math.round(((top - offset) / liHeight) * diffHeight);
				$div.css('webkitTransform', "translate3d(0px, " + scroll + "px, " + scroll*(-20000) +"px)");
			}
		};
	})();

	$(window).on('scroll', parallax);
	console.log('window onload')

	//SLIDE-DOWN LOGIN & SIGNUP
	$('.pull-me').click(function(){
    $('.panel').slideToggle('slow');
    });

	//CUSTOM TEXT EVENT HANDLING
	$('#send-text').click(function(){
		console.log("button was clicked");
		var number = $('#phone-num').val();

		$.ajax({
			url: '/custom_text',
			type: 'post',
			dataType: 'json',
			data: {phone_num: number}
		})
			.success(function(data) {
				console.log("text was sent!")
			});
			$('#phone-num').val("");
	});

	$("#register-btn").click(function(){
  	$(".register").slideToggle(1500);
	});

	$("#sign-in-btn").click(function(){
  	$(".sign-in").slideToggle(1500);
	});
});
