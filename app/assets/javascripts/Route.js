var Route = {
    page: function() {
        Background.setup();
        Form.login();

        Route.admin();
        Route.user();
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