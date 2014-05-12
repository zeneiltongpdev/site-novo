$(function() {
  $('section.carousel ul').on('scroll', placeArrows);

  var scrolling;

  $('section.carousel a#right-arrow')
    .on('mouseover', function(event) {
      scrolling = setInterval(function() {
        var ul = $('section.carousel ul')[0];
        ul.scrollLeft += 1;
      }, 5); 
    })
    .on('mouseleave', function(event) {
      clearInterval(scrolling);
    })

  $('section.carousel a#left-arrow')
    .on('mouseover', function(event) {
      scrolling = setInterval(function() {
        var ul = $('section.carousel ul')[0];
        ul.scrollLeft -= 1;
      }, 5); 
    })
    .on('mouseleave', function(event) {
      clearInterval(scrolling);
    })

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

