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

			console.log($divs);

		return function render() {
			
			top = bodyScroll.scrollTop;
			// console.log($divs);

			for (i = 0; i < len; i++) {

				$div = $divs.eq(i);
				console.log(i);

				offset = $div.offset().top;

				scroll = Math.round(((top - offset) / liHeight) * diffHeight);

				$div.css('webkitTransform', "translate3d(0px, " + scroll + "px, " + scroll*(-20000) +"px)");
			}
		};

	})();

	$(window).on('scroll', parallax);
});
