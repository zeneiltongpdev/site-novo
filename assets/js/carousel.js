window.onload = (function initializeCarousel() {
  carousel().find('> a').on('click', scroll);

  function carousel() {
    return $('section.carousel');
  }

  function scroll(event) {
    var index = parseInt(carousel().attr('data-index'));
    var direction = $(event.currentTarget).data('direction'); 
    carousel().attr('data-index', index + direction); 
  }
});

