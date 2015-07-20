// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(document).ready(function () {

//    setTimeout(function () {
        $('.background-wrapper').each(function (index, element) {
            $(element).css('visibility', 'hidden');
            $(element).find('img').on('load', function () {
                $(".page-load-spinner").fadeOut('medium');
                $(element).css('visibility', 'visible').hide().fadeIn('slow');
            });
            $(element).find('img').attr('src', $(element).data('background-image-path'));
        });
//    }, 1000);
});