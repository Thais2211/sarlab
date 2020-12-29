// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $('#btn_new_lab').click(function () {
    $('#modalNewLaboratory').modal('show');
  });

})

function open_modal_edit_lab(id)
{
  $.getJSON("/laboratorys/get_laboratory?id=" + id, function( data ) {
    $('#modalEditLaboratory #id').val(data['id']);
    $('#modalEditLaboratory #name').val(data['name']);
    $('#modalEditLaboratory #local').val(data['local']);
    $('#modalEditLaboratory #description').val(data['description']);
  });

  $('#modalEditLaboratory').modal('show');
}