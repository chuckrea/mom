$(function() {
	
	//**************
	// PARALLAX
	//**************
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

			console.log($divs);

		return function render() {
			
			top = bodyScroll.scrollTop;
			// console.log($divs);

			for (i = 0; i < len; i++) {

				$div = $divs.eq(i);

				offset = $div.offset().top;

				scroll = Math.round(((top - offset) / liHeight) * diffHeight);

				$div.css('webkitTransform', "translate3d(0px, " + scroll + "px, " + scroll*(-20000) +"px)");
			}
		};

	})();

	$(window).on('scroll', parallax);

	//*************
	//SLIDE-DOWN LOGIN & SIGNUP
	//*************
	$('.pull-me').click(function(){
    $('.panel').slideToggle('slow');
    });

	//*************
	//CUSTOM TEXT EVENT HANDLING
	//*************

	$('#send-text').click(function(){
		console.log("button was clicked");
		var number = $('#phone-num').val();

		$.ajax({
			url: '/welcome',
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
  	$(".register").toggle();
	});

});

// $(function() {
// 	// activate sign up modal from
//   $sign_up_form = $("form#sign_up_user");
// 	$sign_up_form.on("submit", function(event){
// 	  $.ajax({	url: '/users',
//    						method: "post",
// 	  					format: "json",
// 	  					data: $sign_up_form.serialize()
// 	  				}
// 	  ).done(function(data) {
// 	  	console.log(data);
// 	  	if (data.success){
// 	  		game_app.signUp(data)
// 	  	}
// 	  });
// 	});

