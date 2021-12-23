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

function toggle_eqp(id){
  $.ajax({
    url: '/equipaments/toggle_eqp',
    data: {id: id
          },
    type: 'POST',
    success: function (data) {
      if(data['active'] == true)
        exibirMsg("Equipamento ativado com sucesso.");
      else
        exibirMsg("Equipamento desativado com sucesso.");

      window.location.reload();
    },error: function(data) {
      console.log('errors');
      exibirErro('Ocorreu algum erro.');
    }
  });
}
;
