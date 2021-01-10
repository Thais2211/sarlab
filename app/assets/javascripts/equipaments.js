// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function () {
  $('#lab_id').on('change', function () {
    console.log('onchange');
    $.getJSON("/equipaments/equipaments_labs?lab=" + $('#lab_id').val(), function(data) {
      exibirMsg('Filtro aplicado');
      console.log(data);
    });
  });
})