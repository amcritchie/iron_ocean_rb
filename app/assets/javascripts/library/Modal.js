var Modal = {
    $modal: null,
    $button: null,
    callback: null,
    create: function ($button, $modal, data, callback) {
        Modal.$modal = $modal;
        Modal.$button = $button;
        Modal.callback = callback;
        $modal.find('.confirm').off('click').on('click', function () {
            Modal.onConfirm(data)
        });
    },
    onConfirm: function (data) {
        Modal.$button.find('.standard-view').hide();
        Modal.$button.find('.waiting-view').show();
        data.message = Modal.$modal.find('.optional-message').val() || '';
        Ajax.post(data.route, data, Modal.postAjax);
    },
    postAjax: function () {
        Modal.$button.find('.standard-view').show();
        Modal.$button.find('.waiting-view').hide();
        Modal.callback(Modal.$button);
    }
};