var Background = {
    $wrapper: null,
    $curtain: null,
    $spinner: null,
    $image: null,
    setup: function () {
        Background.setVariable($('.background-wrapper'));
        Background.$curtain.css('visibility', 'hidden');
        Background.$image.on('load', Background.onLoad);
        Background.$image.attr('src', Background.$wrapper.data('background-image-path'));
    },
    setVariable: function ($wrapper) {
        Background.$wrapper = $wrapper;
        Background.$curtain = $wrapper.find('.js-background-curtain');
        Background.$spinner = $wrapper.find('.spinner-wrapper');
        Background.$image = $wrapper.find('.background-image');
    },
    onLoad: function () {
//        Background.$spinner.fadeOut('medium');
        Background.$curtain.css('visibility', 'visible').hide().fadeIn('slow');
    }
};