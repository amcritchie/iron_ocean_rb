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

$(document).ready(function() {

    setTimeout(function() {
        $('.background-page').each(function(index, element) {
//        debugger;
            $(element).css('visibility', 'hidden');
//            $(element).find('img').css('visibility', 'hidden');
            $(element).find('img').on('load', function() {
                        $(".page-load-spinner").fadeOut('medium');
                $(element).css('visibility', 'visible').hide().fadeIn('slow');

                debugger;
            });
//            $(element).data('background-image-path');
//            $(element).find('img').attr('src', '/images/iron_ocean.jpeg');
            $(element).find('img').attr('src', $(element).data('background-image-path'));
            debugger;
//            $(element).find('img').css('src', '/images/iron_ocean.jpeg');
//        $(element).find('img').onLoad(funtion() {
//            debugger;
//        });
//        $('<img/>').attr('src', 'http://picture.de/image.png').load(function() {
//            $(this).remove(); // prevent memory leaks as @benweet suggested
//            $('body').css('background-image', 'url(http://picture.de/image.png)');
//        });
        });
    },1000);


//    var img = new Image();
//    $.when(minTime(), onImageLoad()).then(function () {
//        $(".background-image").css("background-image", "url('" + img.src + "')").fadeIn('medium');
//        $(".page-load-spinner").fadeOut('medium');
//    });
//    function minTime() {
//        var minLoadTime = 500;
//        var deferred = $.Deferred();
//        setTimeout(function () {
//            deferred.resolve();
//        }, minLoadTime);
//        return deferred;
//    }
//    function onImageLoad() {
//        var deferred = $.Deferred();
//        img.src = "http://farm1.staticflickr.com/293/18278124840_42bcd162cb_b.jpg";
//        img.onload = function () {
//            deferred.resolve();
//        };
//        return deferred;
//    }
});