var Form = {
    onSubmit: function($submitButton, callback) {
        $submitButton.submit(function(event) {
            event.preventDefault();
            event.stopPropagation();
            $('.errorInput').removeClass('errorInput');
            $('.errorMessage').remove();
            $('#notification-box').fadeOut();
            callback($(this))
        });
    },
    function: null,
    login: function () {
        Form.onSubmit($('.loginForm'), function(form) {
            var info = {
                email: form.find('#user_email').val(),
                password: form.find('#user_password').val()
            };
            $.when(Validate.login(info)).done(function(response) {
                if (response.error) {
                    $('#notification-box').fadeIn();
                    $('#notification-message').html(response.error);
                    clearInterval(Form.function);
                    Form.function = setInterval(function() {
                        setTimeout(function() {
                            $('#notification-box').fadeOut();
                        }, 8000)
                    });
                    Form.prependErrorMessages(form, {email: response.error});
                } else {
                    form.unbind('submit').submit();
                }
            });
        });
    },
    signUp: function() {
        Form.onSubmit($('.signUpForm'), function(form) {
            var info = Inputs.signUp();
            var errors = Validate.form(form, info, 'user');
            var email = form.find('#user_email').val();
            $.when(Validate.uniqueEmail(email)).done(function(response) {
                if (response.error) {
                    errors.email = response.error
                }
                Form.respondToErrors(form, errors);
            });
        });
    },
    contactForm: function() {
        Form.onSubmit($('.contactForm'), function(form) {
            var info = Inputs.contact();
            var errors = Validate.form(form, info, 'contact');
            if ($.isEmptyObject(errors)) {
                Form.loadSpinner(form, function() {
                    Ajax.post('/contact', form.serialize(), function(test) {
                        form.find('input').prop("readonly", true);
                        form.find('textarea').prop("readonly", true);
                        form.find('[type=submit]').html('Message sent, Thanks!');
                    });
                })
            } else {
                Form.prependErrorMessages(form, errors);
            }
        });
    },
    loadSpinner: function(form, callback) {
        var $submit = form.find('[type=submit]');
        $submit.find('.loading').show();
        $submit.find('.resting').hide();
        callback();
    },
    hideSpinner: function(form, callback) {
        var $submit = form.find('[type=submit]');
        $submit.find('.loading').hide();
        $submit.find('.resting').show();
        callback();
    },
    restaurant: function() {
        Form.onSubmit($('.restaurantForm'), function (form) {
            var info = Inputs.restaurant();
            var errors = Validate.form(form, info, 'restaurant');
            var email = form.find('#restaurant_email').val();
            $.when(Validate.uniqueEmail(email)).done(function (response) {
                if (response.error) {
                    errors.email = response.error
                }
                Form.respondToErrors(form, errors);
            });
        });
    },
    evaluation: function () {
        Form.onSubmit($('#new_evaluation'), function (form) {
            var validations = Inputs.evaluation();
            var errors = Validate.form(form, validations, 'evaluation');
            Form.respondToErrors(form, errors);
        });
    },

    question: function () {
        Form.onSubmit($('.newQuestionForm'), function (form) {
            var validations = Inputs.question();
            var errors = Validate.form(form, validations, 'question');
            Form.respondToErrors(form, errors);
        });
    },

    respondToErrors: function (form, errors) {
        if ($.isEmptyObject(errors)) {
            form.unbind('submit').submit();
        } else {
            Form.prependErrorMessages(form, errors);
        }
    },

    prependErrorMessages: function (form, errors) {
        $.each(errors, function (key, value) {
            form.find('[for=' + key + ']').append('<p class="errorMessage">' + value + '</p>');
        });
        Form.removeErrorsOnFocus(form);
    },
    removeErrorsOnFocus: function (form) {
        form.find('input').on('focus', function () {
            $(this).parents('.control-group').find('.errorMessage').remove();
            $(this).removeClass('errorInput')
        })
    }
};