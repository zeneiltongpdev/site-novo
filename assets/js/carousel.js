window.onload = (function initializeCarousel() {
  function carousel() { return $('section.carousel'); }
  var scrolling;

  carousel().find('ul').on('scroll', placeArrows);
  carousel().find('> a').on('mouseover', scroll).on('mouseleave', stopScroll);

  function scroll(event) {
    scrolling = setInterval(function() {
      carousel().find('ul')[0].scrollLeft += $(event.currentTarget).data('direction');
    }, 1); 
  }

  function stopScroll() {
    clearInterval(scrolling);
  }

  function placeArrows(event) {
    var ul = $(event.currentTarget)[0];
    var scroll = ul.scrollLeft;
    var min = 50;
    var max = (ul.scrollWidth - ul.clientWidth) - min;
    if (ul.scrollLeft < min) return carousel().addClass('left-most');
    if (ul.scrollLeft > max) return carousel().addClass('right-most');
    carousel().removeClass('left-most right-most');
  }
});

