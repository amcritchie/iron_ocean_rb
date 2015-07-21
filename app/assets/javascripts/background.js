var Background = {
    $wrapper: null,
    $curtain: null,
    $spinner: null,
    $image: null,
    setup: function () {
        console.log('___1');
        Background.setVariable($('.background-wrapper'));
        console.log('___2');
        Background.$curtain.css('visibility', 'hidden');
        console.log('___3');
        Background.$image.on('load', Background.onLoad);
        console.log('___4');
        console.log(Background.$wrapper);
        console.log('___5');
        console.log(Background.$wrapper.data('background-image-path'));

        console.log('___6');

        Background.$image.attr('src', Background.$wrapper.data('background-image-path'));
    },
    setVariable: function ($wrapper) {
        Background.$wrapper = $wrapper;
        Background.$curtain = $wrapper.find('.background-curtain');
        Background.$spinner = $wrapper.find('.spinner-wrapper');
        Background.$image = $wrapper.find('.background-image');
    },
    onLoad: function () {
        Background.$spinner.fadeOut('medium');
        Background.$curtain.css('visibility', 'visible').hide().fadeIn('slow');
    }
};