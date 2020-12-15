// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery-validation/dist/jquery.validate

$(document).ready(function(){
  $('#btn_nova_disciplina').click(function () {
    $('#modalNewDisciplina').modal('show');
  });

  $('#btn_editar_disciplina').click(function () {
    editar_disciplina();
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

function open_modal_edit_disciplina(id)
{
  //pegar dados
  $.getJSON("/disciplinas/get_disciplina?id=" + id, function( data ) {
    console.log(data);
    $('#modalEditDisciplina #id').val(data['id']);
    $('#modalEditDisciplina #escola_id').val(data['escola_id']).trigger("chosen:updated");
    $('#modalEditDisciplina #nome').val(data['nome']);
    //add ao dropdown somente professores dessa instituição
    $.ajax({
      url: '/disciplinas/find_professor?escola=' + $('#modalEditDisciplina #escola_id').val(),
      type: 'GET',
      success: function (data_prof) {
          $.each(data_prof, function (k, v) {
              $('#modalEditDisciplina #professor_id_edit').append('<option value="' + v['id'] + '">'+ v['nome'] +'</option>');
          });
          $('#modalEditDisciplina #professor_id_edit').val(data['professor_id']).trigger("chosen:updated");
      },error: function(data_prof){
        console.log('erro buscar professor editar disciplina')
          //exibirErro(data);
      }
    });
  });

  $('#modalEditDisciplina').modal('show');
}

function editar_disciplina()
{
  console.log('editar');
  $.ajax({    
    url: '/disciplinas/' + $('#modalEditDisciplina #id').val() + '/atualizar_disciplina/',
    data: {escola_id: $('#modalEditDisciplina #escola_id').val(),
            nome: $('#modalEditDisciplina #nome').val(),
            professor_id: $('#modalEditDisciplina #professor_id_edit').val()},
    type: 'PUT',
    success: function (data) {
        $('#modalEditDisciplina').modal('hide');
        exibirMsg("Cadastro atualizado com sucesso");
    }
  });
}
