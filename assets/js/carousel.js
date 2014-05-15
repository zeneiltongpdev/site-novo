window.onload = (function initializeCarousel() {
  var autoScroll;
  carousel().find('> a').on('click', scroll);

  function carousel() {
    return $('section.carousel');
  }

  function scroll(event) {
    clearInterval(autoScroll);
    var index = parseInt(carousel().attr('data-index'));
    var direction = $(event.currentTarget).data('direction'); 
    carousel().attr('data-index', index + direction); 
  }

  autoScroll = setInterval(function() {
    var index = parseInt(carousel().attr('data-index'));
    carousel().attr('data-index', index == 4 ? 0 : index + 1); 
  }, 4000);
});

