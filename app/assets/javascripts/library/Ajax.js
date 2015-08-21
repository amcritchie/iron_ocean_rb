var Ajax = {
    post: function (route, data, callback) {
        $.ajax({
            type: "POST",
            url: route,
            data: data
        }).then(callback);
    }
};