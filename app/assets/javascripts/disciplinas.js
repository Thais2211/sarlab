// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


//= require jquery/dist/jquery
//= require jquery-easing/jquery.easing.1.3
//= require datatables

$(document).ready(function(){
  $('#btn_nova_disciplina').click(function () {
    $('#modalNewDisciplina').modal('show');
  });

  $('#escola_id').on('change', function(){
    $('#professor_id').html('');
    if($('#escola_id').val() != null && $('#escola_id').val() != ""){
      $.ajax({
        url: '/disciplinas/find_professor?escola=' + $('#escola_id').val(),
        type: 'GET',
        success: function (data) {
            $('#professor_id').append('<option value=""></option>');
            $.each(data, function (k, v) {
                $('#professor_id').append('<option value="' + v['id'] + '">'+ v['nome'] +'</option>');
            });
            $('#professor_id').trigger("chosen:updated");
        },error: function(data){
          console.log('erro buscar professor')
            //exibirErro(data);
        }
      });
    }
  });

  $('#form-disciplina').validate({
    rules:{
      'nome': {required: true},
      'escola_id': {required: true},
      'professor_id': {required: true}
    }
  });
})
