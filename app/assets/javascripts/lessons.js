// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function () {
      
  $('#btn_new_lesson').click(function () {
    $('#modalNewLesson').modal('show');
  });

  $('#btn_create_lesson').click(function () {
    create_lesson();
  });

  $('#btn_conferir_lesson').click(function () {
    $.ajax({
      url: '/lessons/review',
      data: {id: $('#modalNewLesson #data').val()
            },
      type: 'POST',
      success: function (data) {
        exibirMsg("Aula conferida com sucesso.");
      },error: function(data) {
        console.log('errors');
        exibirErro('Ocorreu algum erro.');
      }
    });
  });


});

function create_lesson()
{
  $.ajax({
    url: '/lessons/new_lesson',
    data: {data: $('#modalNewLesson #data').val(),
            start_time: $('#modalNewLesson #start_time').val(),
            end_time: $('#modalNewLesson #end_time').val(),
            laboratory_id: $('#modalNewLesson #laboratory_id').val(), 
            disciplina_id: $('#modalNewLesson #disciplina_id').val(),
          },
    type: 'POST',
    success: function (data) {
      //limpar dados modal
      $('#modalNewLesson #start_time').val('');
      $('#modalNewLesson #end_time').val('');
      $('#modalNewLesson #laboratory_id').val('');
      $('#modalNewLesson #disciplina_id').val('');

      $('#modalNewLesson').modal('hide');
      $('#modalAnexarSolicitacaoAula #lesson_id').val(data.id);
      $('#modalAnexarSolicitacaoAula').modal('show');

      exibirMsg("Aula salva com sucesso.");
      //window.location.reload();
    },error: function(data) {
      console.log('errors');
      exibirErro('Ocorreu algum erroooo.');
    }
  });
}

function review_lesson(id){
  $.ajax({
    url: '/lessons/review',
    data: {id: id
          },
    type: 'POST',
    success: function (data) {
      exibirMsg("Aula conferida com sucesso.");
    },error: function(data) {
      console.log('errors');
      exibirErro('Ocorreu algum erro.');
    }
  });
}