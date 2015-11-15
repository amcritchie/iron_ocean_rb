var Route = {
    page: function() {
        Background.setup();
        Form.login();
        Form.contactForm();

        Route.admin();
        Route.user();

        //  When opening a modal, focus on the first input.
        $('.modal').on('shown.bs.modal', function () {
            $(this).find('input:text:visible:first').focus();
        });
        //  When switching tabs, focus on the first input.
        $('[data-toggle="tab"]').on('click', function () {
            var $form = $($(this).attr('href'));
            setTimeout(function() { $form.find('input:text:visible:first').focus(); },200);
        });

    },
    admin: function() {
        Admin.Users.handlers();
    },
    user: function() {
        // Clickable table rows
        jQuery(document).ready(function($) {
            $(".clickable-row").click(function() {
                window.document.location = $(this).data("href");
            });
        });
    }
};