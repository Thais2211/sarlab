// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
  $('#btn_novo_tipo_reserva').click(function () {
    $('#modalNewType').modal('show');
  });
})

function open_modal_edit_tipo(id, description)
{
  $('#modalEditTipo #id').val(id);
  $('#modalEditTipo #description').val(description);
  
  $('#modalEditTipo').modal('show');
}