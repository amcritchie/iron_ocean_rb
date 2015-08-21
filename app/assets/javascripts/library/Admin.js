var Admin = {
    prepareModal: function ($this, callback) {
        Modal.create($this, $($this.attr('data-target')), {
            id: $this.attr('data-id'),
            route: $this.attr('data-route')
        }, callback)
    },
    updateModalButton: function($button, rmClass, adClass, target, route, iIcon, nIcon) {
        $button.removeClass(rmClass).addClass(adClass).attr('data-target', target).attr('data-route', route);
        $button.find('.' + iIcon).removeClass(iIcon).addClass(nIcon);
    },
    Users: {
        handlers: function () {
            $('.activate-user').on('click', Admin.Users.activate);
            $('.deactivate-user').on('click', Admin.Users.deactivate);
            $('.resend-confirmation-email').on('click', Admin.Users.resendConfirmationEmail);
        },
        deactivate: function () {
            Admin.prepareModal($(this), function ($button) {
                Admin.updateModalButton($button, 'btn-success', 'btn-danger', '.activate-user-modal', '/activate_user', 'fa-unlock', 'fa-lock');
                $button.off('click').on('click', Admin.Users.activate);
            });
        },
        activate: function () {
            Admin.prepareModal($(this), function ($button) {
                Admin.updateModalButton($button, 'btn-danger', 'btn-success', '.deactivate-user-modal', '/deactivate_user', 'fa-lock', 'fa-unlock');
                $button.off('click').on('click', Admin.Users.deactivate)
            });
        },
        resendConfirmationEmail: function () {
            Admin.prepareModal($(this), function ($button) {
                $button.removeClass('btn-danger').addClass('btn-warning');
                $button.off('click').removeAttr('data-toggle');
            });
        }
    }
};