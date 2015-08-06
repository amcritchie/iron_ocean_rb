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

var ready;
ready = function() {
    console.log('____');
    var paragraphs = document.getElementsByTagName("p");
    for (var i = 0; i < paragraphs.length; i++) {
        var paragraph = paragraphs.item(i);
        paragraph.style.setProperty("color", "white", null);
    }

    Background.setup();

    Form.login();

    Admin.Users.handlers();
};

$(document).ready(ready);
$(document).on('page:load', ready);

//$(document).ready(function () {
//    var paragraphs = document.getElementsByTagName("p");
//    for (var i = 0; i < paragraphs.length; i++) {
//        var paragraph = paragraphs.item(i);
//        paragraph.style.setProperty("color", "white", null);
//    }
//
//    Background.setup();
//
//    Form.login();
//
//    Admin.Users.handlers();
//});

var Ajaxx = {
    post: function (route, data, callback) {
        $.ajax({
            type: "POST",
            url: route,
            data: data
        }).then(callback);
    }
};