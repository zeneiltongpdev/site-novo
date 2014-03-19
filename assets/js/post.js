$(document).ready(function($) {
	$('article.post img').on('load', function(e){

		var $img = $(e.currentTarget),
			w = e.currentTarget.clientWidth,
			h = e.currentTarget.clientHeight,
			ratio = w/h,
			$wrap = $('<figure></figure>');

		if ($img.parent().prop('tagName') !== 'FIGURE') {
			$wrap
				.addClass((ratio < 1.3)?'portrait':'landscape')
				.addClass('thumbnail crop animated');

			$img.wrap($wrap.get());
		}

	}).each(function() {
		if(this.complete) $(this).load();
	});
});
