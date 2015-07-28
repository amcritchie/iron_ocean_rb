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

//Google Analytics
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-65241849-2', 'auto');
ga('send', 'pageview');

$(document).ready(function () {
    Background.setup();


    window.location.hash = '#food'

    $(window).on('hashchange', function () {
        if (!location.hash) {
            $('#tabs').tabs('option', 'active', 0); // activate first tab by default
            return;
        }
        $('#tabs > ul > li > a').each(function (index, a) {
            if ($(a).attr('href') == location.hash) {
                $('#tabs').tabs('option', 'active', index);
            }
        });
    });
});