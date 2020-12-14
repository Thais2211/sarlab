$(document).ready(function() {

  $('#btn_nova_escola').click(function () {
      $('#modalNewEscola').modal('show');
  });

  $('#btn_create_escola').click(function () {
    create_escola();
  });

  $('#btn_editar_escola').click(function () {
    editar_escola();
  });

});

function create_escola()
{
  $.ajax({
    url: '/escolas/nova_escola/',
    data: {nome: $('#modalNewEscola #nome').val(),
            endereco: $('#modalNewEscola #endereco').val(),
            numero: $('#modalNewEscola #numero').val(),
            bairro: $('#modalNewEscola #bairro').val(), 
            cidade: $('#modalNewEscola #cidade').val(),
            responsavel: $('#modalNewEscola #responsavel').val(),
            telefone: $('#modalNewEscola #telefone').val()},
    type: 'GET',
    success: function (data) {
        $('#modalNewEscola').modal('hide');
        console.log("salvou");
        /*if($('#form_agendamento #comentario').val() != ''){
              salvarComentario($('#form_agendamento #comentario').val(), data['id']);
        }*/
        exibirMsg("Agenda salva com sucesso.");
    },error: function(data) {
      console.log('errors');
        /*if (data['responseJSON'] == 'CONFLITO_HORARIO') {
            exibirErro('Horário do agendamento em conflito com outro agendamento do atendente.');
        } else if (data['responseJSON'] != null) {
            exibirErro(data['responseJSON']);
        } else {
            exibirErro('Ocorreu algum erro.');
        }*/
    }
  });
}

function open_modal_edit_escola(id)
{
  //pegar dados da escola
  $.getJSON("/escolas/" + id, function( data ) {
    $('#modalEditEscola #escola_id').val(data['id']);
    $('#modalEditEscola #nome').val(data['nome']);
    $('#modalEditEscola #endereco').val(data['endereco']);
    $('#modalEditEscola #numero').val(data['numero']);
    $('#modalEditEscola #bairro').val(data['bairro']); 
    $('#modalEditEscola #cidade').val(data['cidade']);
    $('#modalEditEscola #responsavel').val(data['responsavel']);
    $('#modalEditEscola #telefone').val(data['telefone']);
  });

  $('#modalEditEscola').modal('show');
}

function editar_escola()
{
  $.ajax({
    url: '/escolas/atualizar_escola/',
    data: {id: $('#modalEditEscola #escola_id').val(),
            nome: $('#modalEditEscola #nome').val(),
            endereco: $('#modalEditEscola #endereco').val(),
            numero: $('#modalEditEscola #numero').val(),
            bairro: $('#modalEditEscola #bairro').val(), 
            cidade: $('#modalEditEscola #cidade').val(),
            responsavel: $('#modalEditEscola #responsavel').val(),
            telefone: $('#modalEditEscola #telefone').val()},
    type: 'GET',
    success: function (data) {
        $('#modalEditEscola').modal('hide');
        console.log("salvou");
        exibirMsg('escola editada');
    }
  });
}