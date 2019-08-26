/// <reference path="../node_modules/@types/jquery/jquery.d.ts" />
/// <reference path="../node_modules/@types/bootstrap-table/index.d.ts" />
var BaseUrl = "http://localhost:44375/api/";
var risorse_list = [];
var sale_list = [];
var edifici_list = [];
var edifici_delete_row;
jQuery(document).ready(() => {
    console.log("starting DOM functions");
    //Show tables actions
    ShowRisorseTable();
    ShowEdificiTable();
    ShowSaleTable();
    console.log("finish loading function in DOM");
});
///////TABLE RISORSE
function ShowRisorseTable() {
    $('#option_risorse').on('click', function (event) {
        $('#manager_edifici').hide();
        $('#manager_sale').hide();
        $('#manager_risorse').toggle("slide");
        CreateRisorseTable();
        InsertRisorseTable();
    });
}
function CreateRisorseTable() {
    $.ajax({
        url: BaseUrl + "resources/GetAll",
        type: "GET",
        //contentType: 'application/json',
        dataType: 'json',
        success: function (json) {
            risorse_list = json;
            $('#table_risorse').bootstrapTable('load', risorse_list);
            //$('#table_risorse').bootstrapTable({ data: risorse_list });
        },
        error: function (err) {
            console.log(err);
        }
    });
}
function RefreshRisorseTable() {
    $('#refresh_risorse_table').on('click', function (event) {
        CreateRisorseTable();
    });
}
function UpdateRisorseTable() {
}
function InsertRisorseTable() {
    $('#input_risorse_inserisci').on('click', function (event) {
        var name = $('#input_risorse_nome').val();
        var surname = $('#input_risorse_cognome').val();
        var admin = $("#checkbox_risorse_admin").is(":checked") ? true : false;
        $.ajax({
            url: BaseUrl + "resources/Insert/" + name + "/" + surname + "/" + admin,
            type: "POST",
            contentType: 'application/json',
            data: JSON.stringify({}),
            success: function () {
                CreateRisorseTable();
                $("#Risorsa_Alert_Success").show();
            },
            error: function (err) {
                alert("errore nella creazione dell'utente.");
                console.log(err);
            }
        });
    });
}
function DeleteRisorsaTable() {
    $("#Risorsa_Alert_UnSuccess").show();
}
function TableRisorseActions(value, row) {
    return '<i class="fas fa-trash-alt" onclick="DeleteRisorsaTable(' + row.id + ')"></i>';
}
function TableRisorseDetails(index, row) {
    var html = [];
    //$.each(row, function (key, value) {
    html.push('<p><b>ID:</b> ' + row.id_resource + '</p>');
    html.push('<p><b>Username:</b> ' + row.username + '</p>');
    html.push('<p><b>Email:</b> ' + row.email + '</p>');
    html.push('<p><b>Admin:</b> ' + row.admin + '</p>');
    html.push('<p><b>Status:</b> ' + row.status + '</p>');
    //})
    return html.join('');
}
///////TABLE SALE
function ShowSaleTable() {
    $('#option_sale').on('click', function (event) {
        $("#manager_risorse").hide();
        $("#manager_edifici").hide();
        $('#manager_sale').toggle("slide");
        //Popola la dropdown con gli edifici selezionabili
        DropdownSaleInsert();
        InsertSalaTable();
        CreateSaleTable();
        RefreshSaleTable();
    });
}
function CreateSaleTable() {
    $('#refresh_sale_table').on('click', function (event) {
        var edificio = $('#input_sale_edificio').find("option:selected").text();
        console.log("Call");
        console.log("Edificio:" + edificio);
        $.ajax({
            url: BaseUrl + "rooms/GetAll/" + edificio,
            type: "GET",
            //contentType: 'application/json',
            dataType: 'json',
            success: function (json) {
                sale_list = json;
                console.log("Inside the call of sale");
                console.log(sale_list);
                $('#table_sale').bootstrapTable('load', sale_list);
            },
            error: function (err) {
                console.log(err);
            }
        });
    });
}
function DropdownSaleInsert() {
    var building_list = [];
    $('#input_sale_edificio').empty();
    $.ajax({
        url: BaseUrl + "buildings/GetAll",
        type: "GET",
        //contentType: 'application/json',
        dataType: 'json',
        success: function (json) {
            //building_list = JSON.parse(json)
            $.each(json, function () {
                building_list.push({
                    name: this.name,
                });
            });
            $.each(building_list, function (index, value) {
                $('#input_sale_edificio')
                    .append($("<option></option>")
                    .attr("value", index)
                    .text(value.name));
                console.log(value.name);
            });
            return building_list;
        },
        error: function (err) {
            console.log(err);
            return [];
        }
    });
}
function InsertSalaTable() {
    $('#input_sale_inserisci').on('click', function (event) {
        var name = $("#input_sale_nome").val();
        var sittings = $("#input_sale_sittings").val();
        var edificio = $('#input_sale_edificio').find("option:selected").text();
        $.ajax({
            url: BaseUrl + "rooms/Insert/" + name + "/" + sittings + "/" + edificio,
            type: "POST",
            contentType: 'application/json',
            data: JSON.stringify({}),
            success: function () {
                CreateSaleTable();
                $("#Sala_Alert_Success").show();
            },
            error: function (err) {
                alert("errore nella creazione della sala, Sala già esistente o valori inseriti non correttamente");
                console.log(err);
            }
        });
    });
}
function DeleteSalaTable() {
    $("#Sala_Alert_UnSuccess").show();
}
function TableSalaActions(value, row) {
    return '<i class="fas fa-trash-alt" onclick="DeleteSalaTable(' + row.id + ')"></i>';
}
function TableSaleDetails(index, row) {
    var html = [];
    //$.each(row, function (key, value) {
    html.push('<p><b>ID:</b> ' + row.id_room + '</p>');
    html.push('<p><b>ID Edificio:</b> ' + row.id_building + '</p>');
    html.push('<p><b>Nome Edificio:</b> ' + row.building_name + '</p>');
    //})
    return html.join('');
}
function RefreshSaleTable() {
    $('#refresh_sale_table').on('click', function (event) {
        CreateSaleTable();
    });
}
///////TABLE EDIFICI
function ShowEdificiTable() {
    $('#option_edifici').on('click', function (event) {
        $("#manager_risorse").hide();
        $("#manager_sale").hide();
        $('#manager_edifici').toggle("slide");
        CreateEdificiTable();
        InsertEdificioTable();
        RefreshEdificiTable();
    });
}
function CreateEdificiTable() {
    $.ajax({
        url: BaseUrl + "buildings/GetAll",
        type: "GET",
        //contentType: 'application/json',
        dataType: 'json',
        success: function (json) {
            edifici_list = json;
            $('#table_edifici').bootstrapTable('load', edifici_list);
        },
        error: function (err) {
            console.log(err);
        }
    });
}
function InsertEdificioTable() {
    $('#input_edificio_inserisci').on('click', function (event) {
        var name = $("#input_edificio_nome").val();
        var address = $("#input_edificio_indirizzo").val();
        $.ajax({
            url: BaseUrl + "buildings/Insert/" + name + "/" + address,
            type: "POST",
            contentType: 'application/json',
            data: JSON.stringify({}),
            success: function () {
                CreateEdificiTable();
                $('#Edifici_Alert_Success').show();
            },
            error: function (err) {
                alert("errore nella creazione dell'edificio, Edificio già esistente o valori inseriti non correttamente");
                console.log(err);
            }
        });
    });
}
function DeleteEdificiTable() {
    $.ajax({
        url: BaseUrl + "buildings/Delete/" + edifici_delete_row.name,
        type: "GET",
        //contentType: 'application/json',
        //dataType: 'json',
        success: function () {
            console.log(edifici_delete_row.name + " eliminated");
            //CreateEdificiTable()
        },
        error: function (err) {
            console.log(err);
        }
    });
    $('#table_edifici').bootstrapTable('load', edifici_list);
    $("#Edifici_Alert_UnSuccess").show();
}
function TableEdificiActions(value, row) {
    edifici_delete_row = row;
    return '<i class="fas fa-trash-alt" onclick="DeleteEdificiTable()"></i>';
}
function TableEdificiDetails(index, row) {
    var html = [];
    //$.each(row, function (key, value) {
    html.push('<p><b>ID:</b> ' + row.id_building + '</p>');
    html.push('<p><b>Nome Edificio:</b> ' + row.name + '</p>');
    html.push('<p><b>Indirizzo:</b> ' + row.address + '</p>');
    html.push('<p><b>Status:</b> ' + row.status + '</p>');
    //})
    return html.join('');
}
function RefreshEdificiTable() {
    $('#refresh_edifici_table').on('click', function (event) {
        CreateEdificiTable();
    });
}
//# sourceMappingURL=Gestisci.js.map