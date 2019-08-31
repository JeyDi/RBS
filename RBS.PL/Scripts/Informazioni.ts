/// <reference path="../node_modules/@types/jquery/jquery.d.ts" />
/// <reference path="../node_modules/@types/bootstrap-table/index.d.ts" />

var BaseUrl = "http://localhost:44375/api/";

jQuery(document).ready(() => {
    SendEmail()
});


function SendEmail() {
    $('#input_email_send').on('click', function (event) {

        $.ajax({
            url: BaseUrl + 'actions/SendEmail',
            type: "POST",
            contentType: 'application/json',
            data: JSON.stringify({
                email_from: $("#input_email_from").val(),
                email_object: $("#input_email_object").val(),
                email_text: $('#input_email_text').val(),
                
            }),
            success: function () {
                alert("Email inviata con successo")
            },
            error: function (err) {
                alert("Errore nell'invio della mail, riprova..");
                console.log(err);
            }
        }).done(function (data) {

            
        });
    });
}

