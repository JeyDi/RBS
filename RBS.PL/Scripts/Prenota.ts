/// <reference path="../node_modules/@types/jquery/jquery.d.ts" />
/// <reference path="../node_modules/@types/bootstrap-table/index.d.ts" />


var BaseUrl = "http://localhost:44375/api/";
var prenotazioni_list = [];
var prenotazioni_delete_row;

jQuery(document).ready(() => {
    console.log("starting DOM functions");

    DropdownRisorse();
    RefreshTable();

    console.log("finish loading function in DOM");
})


function CreateTable() {

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
                console.log(value.name)
            });

            return resources_list
        },
        error: function (err) {
            console.log(err);
            return [];
        }
    });

};


function RefreshTable() {
    $('#refresh_risorse_table').on('click', function (event) {

        CreateTable()

    });
}


function TablePrenotazioniActions(value, row) {
    prenotazioni_delete_row = row
    return '<i class="fas fa-trash-alt" onclick="DeletePrenotazioneTable()"></i>';

}


function TablePrenotazioniDetails(index, row) {
    var html = []
    //$.each(row, function (key, value) {
    html.push('<p><b>ID Prenotazione:</b> ' + row.id_reservations + '</p>')
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
    $('#table_prenotazioni').bootstrapTable('load', edifici_list);
    $("#Prenotazioni_Alert_UnSuccess").show();
}


