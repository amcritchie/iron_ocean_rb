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
(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date();
    a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

ga('create', 'UA-65241849-2', 'auto');
ga('send', 'pageview');


var Modal = {
    $this: null,
    id: null,
    route: null,
    $modal: null,
    $confirm: null,
    callback: null,
    initialize: function ($this, callback) {
//        console.log('init');
//        debugger;
//        Modal.callback = callback();

//        var $button =
            Modal.$this = $this;
        Modal.id = $this.data('id');
        Modal.route = $this.data('route');
        Modal.$modal = $($this.data('target'));
        Modal.$confirm = Modal.$modal.find('.confirm');
//        console.log(Modal.$confirm);
//        debugger;
        Modal.$confirm.on('click', function () {
//                console.log('on confirm click');
                Modal.onConfirm(callback)
            }
        );
    },

    onConfirm: function (callback) {
        var $standardView = Modal.$this.find('.standard-view');
        var $waitingView = Modal.$this.find('.waiting-view');
        $standardView.hide();
        $waitingView.show();
//        debugger;
        var message = Modal.$modal.find('.optional-message').val() || '';
//        console.log('ajax');
        Ajaxx.post(Modal.route, {
            id: Modal.id,
            message: message
        }, function () {
            setTimeout(function () {
                $standardView.show();
                $waitingView.hide();
//                Modal.callback();
//                console.log('time out done');
                callback();
            }, 1000);

        });
    }
};

var Ajaxx = {
    post: function (route, data, callback) {
        $.ajax({
            type: "POST",
            url: route,
            data: data
        }).then(callback);
    }
};


$(document).ready(function () {
    Background.setup();

//    $('.confirm').on('click', function() {
//       console.log('confirm click');
//    });

    Form.login();

    $('.activate-user').on('click', Admin.activateUser
//        function (){
//        var $button = $(this);
//        Modal.initialize($(this), function() {
//            $button.removeClass('btn-danger').addClass('btn-success');
//            $button.find('.fa-lock').removeClass('fa-lock').addClass('fa-unlock');
//        })
//    }

    );
    $('.deactivate-user').on('click', Admin.deactivateUser

//        function () {
//        var $button = $(this);
//        Modal.initialize($(this), function () {
//            $button.removeClass('btn-success').addClass('btn-danger');
//            $button.find('.fa-unlock').removeClass('fa-unlock').addClass('fa-lock');
//        });
//
////    }));
//
//    }


    );
    $('.resend-confirmation-email').on('click', Modal.initialize);

});

var Admin = {
    deactivateUser: function() {
        console.log('deactivate -user');
        var $button = $(this);
        Modal.initialize($(this), function () {
            $button.removeClass('btn-success').addClass('btn-danger');
            $button.find('.fa-unlock').removeClass('fa-unlock').addClass('fa-lock');
            $button.off('click').on('click', Admin.activateUser)
        });
    },

    activateUser: function() {
        console.log('activate -user');
        var $button = $(this);
        Modal.initialize($(this), function() {
            $button.removeClass('btn-danger').addClass('btn-success');
            $button.find('.fa-lock').removeClass('fa-lock').addClass('fa-unlock');
            $button.off('click').on('click', Admin.deactivateUser)
        })
    }
};


//    document.querySelector('.sweet-10').onclick = function(){
//        swal({
//            title: "Are you sure?",
//            text: "You will not be able to recover this imaginary file!",
//            type: "info",
//            showCancelButton: true,
//            confirmButtonClass: 'btn-primary',
//            confirmButtonText: 'Primary!'
//        });
//    };
//    document.querySelector('.sweet-11').onclick = function(){
//        swal({
//            title: "Are you sure?",
//            text: "You will not be able to recover this imaginary file!",
//            type: "info",
//            showCancelButton: true,
//            confirmButtonClass: 'btn-info',
//            confirmButtonText: 'Info!'
//        });
//    };
//    document.querySelector('.sweet-12').onclick = function(){
//        swal({
//            title: "Are you sure?",
//            text: "You will not be able to recover this imaginary file!",
//            type: "success",
//            showCancelButton: true,
//            confirmButtonClass: 'btn-success',
//            confirmButtonText: 'Success!'
//        });
//    };
//    document.querySelector('.sweet-13').onclick = function(){
//        swal({
//            title: "Are you sure?",
//            text: "You will not be able to recover this imaginary file!",
//            type: "warning",
//            showCancelButton: true,
//            confirmButtonClass: 'btn-warning',
//            confirmButtonText: 'Warning!'
//        });
//    };
//    document.querySelector('.sweet-14').onclick = function(){
//        swal({
//            title: "Are you sure?",
//            text: "You will not be able to recover this imaginary file!",
//            type: "error",
//            showCancelButton: true,
//            confirmButtonClass: 'btn-danger',
//            confirmButtonText: 'Danger!'
//        });
//    };
//});
