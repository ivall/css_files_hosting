var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

$.ajaxSetup( {
    beforeSend: function ( xhr ) {
        xhr.setRequestHeader( 'X-CSRF-Token', token );
    }
});

$(document).ready(function() {
    $(document).on("click", ".upload_code_button", function () {
        $(this).prop('disabled', true)
        const code = codeArea.getCode();
        $.ajax({
            url: '/upload_file/',
            type: 'POST',
            data: {code: code, captcha: grecaptcha.getResponse()},
            success: function (data) {
                document.location = document.location.href+"stylesheets/"+data.message+".css";
            },
            error: function (data) {
                toastr.error(data.responseJSON.message);
                $('.upload_code_button').prop('disabled', false);
                grecaptcha.reset()
            }
        });
    });
});