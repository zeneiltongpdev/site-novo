$(function() {
  $('section.carousel ul').on('scroll', placeArrows);
});

function placeArrows(event) {
  var ul = $(event.currentTarget)[0];
  var scroll = ul.scrollLeft;
  var min = 50;
  var max = (ul.scrollWidth - ul.clientWidth) - min;
  var carousel = $('section.carousel')
  if (ul.scrollLeft < min) return carousel.addClass('left-most');
  if (ul.scrollLeft > max) return carousel.addClass('right-most');
  carousel.removeClass('left-most right-most');
}

