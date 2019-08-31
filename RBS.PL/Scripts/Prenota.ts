/// <reference path="../node_modules/@types/jquery/jquery.d.ts" />
/// <reference path="../node_modules/@types/bootstrap-table/index.d.ts" />


var BaseUrl = "http://localhost:44375/api/";
var prenotazioni_list = [];
var prenotazioni_delete_row;

jQuery(document).ready(() => {

   
    CreateTable()
    DropdownRisorse();
    RefreshTableButton();
    DropdownStanze();
    InsertPrenotazioniTable()
    ShowAll()

})


function CreateTable() {
    $.ajax({
        url: BaseUrl + "reservations/All",
        type: "GET",
        //contentType: 'application/json',
        dataType: 'json',
        success: function (json) {
            risorse_list = json;

            $('#table_prenotazioni').bootstrapTable('load', risorse_list);
            //$('#table_risorse').bootstrapTable({ data: risorse_list });
        },
        error: function (err) {
            console.log(err);
        }
    })
}


function RefreshTable() {

    var username = $('#input_risorse').find("option:selected").text();

    $.ajax({
        url: BaseUrl + "reservations/GetAll/" + username,
        type: "GET",
        //contentType: 'application/json',
        dataType: 'json',
        success: function (json) {
            risorse_list = json;

            $('#table_prenotazioni').bootstrapTable('load', risorse_list);
            //$('#table_risorse').bootstrapTable({ data: risorse_list });
        },
        error: function (err) {
            console.log(err);
        }
    })
};


function RefreshTableButton() {
    $('#refresh_risorse_table').on('click', function (event) {
        RefreshTable()
    });
}

function ShowAll() {
    $('#showall_risorse_table').on('click', function (event) {
        $.ajax({
            url: BaseUrl + "reservations/All",
            type: "GET",
            //contentType: 'application/json',
            dataType: 'json',
            success: function (json) {
                risorse_list = json;

                $('#table_prenotazioni').bootstrapTable('load', risorse_list);
                //$('#table_risorse').bootstrapTable({ data: risorse_list });
            },
            error: function (err) {
                console.log(err);
            }
        })
    });
}


function DropdownRisorse() {

    var resources_list = []
    $('#input_risorse').empty()

    $.ajax({
        url: BaseUrl + "resources/GetAll",
        type: "GET",
        //contentType: 'application/json',
        dataType: 'json',
        success: function (json) {
            //building_list = JSON.parse(json)
            $.each(json, function () {
                resources_list.push({
                    name: this.username,
                });
            });

            $.each(resources_list, function (index, value) {
                $('#input_risorse')
                    .append($("<option></option>")
                        .attr("value", index)
                        .text(value.name));
                
            });

            return resources_list
        },
        error: function (err) {
            console.log(err);
            return [];
        }
    });

};

function DropdownStanze() {

    var resources_list = []
    $('#input_prenota_stanza').empty()

    $.ajax({
        url: BaseUrl + "rooms/All",
        type: "GET",
        //contentType: 'application/json',
        dataType: 'json',
        success: function (json) {
            //building_list = JSON.parse(json)
            $.each(json, function () {
                resources_list.push({
                    name: this.name,
                });
            });

            $.each(resources_list, function (index, value) {
                $('#input_prenota_stanza')
                    .append($("<option></option>")
                        .attr("value", index)
                        .text(value.name));
               
            });

            return resources_list
        },
        error: function (err) {
            console.log(err);
            return [];
        }
    });

};

function TablePrenotazioniDetails(index, row) {
    var html = []
    //$.each(row, function (key, value) {
    html.push('<p><b>ID Prenotazione:</b> ' + row.id_reservation + '</p>')
    html.push('<p><b>Data inizio:</b> ' + row.start_date + '</p>')
    html.push('<p><b>Data fine:</b> ' + row.end_date + '</p>')
    html.push('<p><b>ID Risorsa:</b> ' + row.id_resource + '</p>')
    html.push('<p><b>Nome risorsa:</b> ' + row.resource_name + '</p>')
    html.push('<p><b>Cognome risorsa:</b> ' + row.resource_surname + '</p>')
    html.push('<p><b>Email risorsa:</b> ' + row.resource_email + '</p>')
    html.push('<p><b>Username risorsa:</b> ' + row.resource_username + '</p>')
    html.push('<p><b>ID Edificio:</b> ' + row.id_building + '</p>')
    html.push('<p><b>Nome Edificio:</b> ' + row.building_name + '</p>')
    html.push('<p><b>ID Stanza:</b> ' + row.id_room + '</p>')
    html.push('<p><b>Nome Stanza:</b> ' + row.room_name + '</p>')
    html.push('<p><b>Posti nella Stanza:</b> ' + row.room_sittings + '</p>')
    //})
    return html.join('')

}


function DeletePrenotazioniTable() {

    var id = prenotazioni_delete_row.id_reservation

    $.ajax({
        url: BaseUrl + "reservations/Delete/" + id,
        type: "GET",
        //contentType: 'application/json',
        //dataType: 'json',
        error: function (err) {
            console.log(err);
        }
    }).done(function (data) {
        CreateTable();
        $("#Prenotazioni_Alert_UnSuccess").show();
    });

}

function TablePrenotazioniActions(value, row) {
    prenotazioni_delete_row = row
    return '<i class="fas fa-trash-alt" onclick="DeletePrenotazioniTable()"></i>';

}


function InsertPrenotazioniTable() {
    $('#input_prenotazione_inserisci').on('click', function (event) {

        //Create start and end date
        var input_start_date = $('#input_prenota_data_value').datepicker('getFormattedDate') + " " + $("#input-time-start").val() + ":00"
        var input_end_date = $('#input_prenota_data_value').datepicker('getFormattedDate') + " " + $("#input-time-end").val() + ":00"

        //Check if in the input textbox there are values
        var input_event_name = $("#input_prenota_evento").val()
        var input_description = $("#input_prenota_descrizione").val()
        var input_username = $('#input_risorse').find("option:selected").text()
        var input_room = $('#input_prenota_stanza').find("option:selected").text()

        if (input_event_name && input_description && input_username && input_room) {

            $.ajax({
                url: BaseUrl + 'reservations/Insert',
                type: "POST",
                contentType: 'application/json',
                data: JSON.stringify({
                    event_name: input_event_name,
                    description: input_description,
                    username: input_username,
                    room: input_room,
                    start_date: input_start_date,
                    end_date: input_end_date
                }),
                error: function (err) {
                    alert("Prenotazione già esistente o non valida, inserisci dei valori corretti controllando la tabella");
                    console.log(err);
                }
            }).done(function (data) {

                RefreshTable()
                $("#Prenotazioni_Alert_Success").show();
            });
        }
        else {
            alert("Inserisci i valori all'interno del form di compilazione correttamente!");
        }

      
    });


}