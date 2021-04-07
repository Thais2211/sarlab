// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


//= require fullcalendar
//= require fullcalendar/locale-all

$(document).ready(function () {

  $('#laboratory_id').on('change', function () {      
    $('#equipament_id').html('');
    if($('#laboratory_id').val() != null && $('#laboratory_id').val() != ""){
      $.ajax({
        url: '/equipaments/equipaments_labs_json?lab=' + $('#laboratory_id').val(),
        type: 'GET',
        success: function (data) {
            $('#equipament_id').append('<option value=""></option>');
            $.each(data, function (k, v) {
                $('#equipament_id').append('<option value="' + v['id'] + '">'+ v['name'] +'</option>');
            });
            $('#equipament_id').trigger("chosen:updated");
        },error: function(data){
            //exibirErro(data);
        }
      });
    }
  });


    //primeiro vai no events l:40 o event render é chamado pra cada agendamento e depois o after render
    //click em existente chama o event click
    //click em novo passa pelo render mas chama o select
    $('#calendar').fullCalendar({
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
      },
      defaultView: 'agendaDay',
      timezone:'local',
      height: 730,
      defaultDate: Date(),
      navLinks: true, // can click day/week names to navigate views
      eventLimit: true, // allow "more" link when too many events
      allDaySlot: false,
      minTime: "07:00:00",
      maxTime: "23:30:00",
      selectable: true,
      selectHelper: true,
      select: function(start, end){
          console.log('select');
          //limparForm();
          $('#form_agendamento #data_inicio').text(moment(start).format("DD/MM/YYYY HH:mm"));
          $('#form_agendamento #data_inicio').val(moment(start).format("DD/MM/YYYY HH:mm"));
          $('#form_agendamento #data_fim').text(moment(end).format("DD/MM/YYYY HH:mm"));
          $('#form_agendamento #data_fim').val(moment(end).format("DD/MM/YYYY HH:mm"));
  
          $('#agendamento').modal('show');
      },
      eventClick: function(calEvent, jsEvent, view) {
          console.log('event click, l:60');
          $.getJSON('/agendamentos/' + calEvent.id, function(data) {
              showAgendamento(data);
          });
      },
      events: function(start, end, timezone, callback) {
          console.log('events l: 65');
          $.getJSON('/schedules/get_schedules?start=' + start.unix() + "&end=" + end.unix() + "&status=" + $('#filtro_status').val(), function(data) {
              var events = [];
              $.each(data,function (i,agendamento){
                  console.log(agendamento);
                  events.push({
                      id: agendamento['id'],
                      title: agendamento['tipo_agendamento'] + '\n' + agendamento['cliente_razao_social'],
                      start: moment(agendamento['data_inicio']),
                      end: moment(agendamento['data_fim']),
                      obs: agendamento['observacao'],
                      backgroundColor : agendamento['color'],
                      borderColor: agendamento['color'],
                      user_id: (agendamento['user_id'] == null ? null : agendamento['user_id'].toString()),
                      user: agendamento['user_name'],
                      tipo_id: (agendamento['tipo_agendamento_id'] == null ? null : agendamento['tipo_agendamento_id'].toString()),
                      tipo: agendamento['tipo_agendamento'],
                      cliente: agendamento['cliente_razao_social'],
                      cliente_id: (agendamento['cliente_id'] == null ? null : agendamento['cliente_id'].toString()),
                      empresa: agendamento['empresa'],
                      empresa_id: agendamento['empresa_id'].toString(),
                      solicitante: agendamento['user_registro'],
                      telefone: agendamento['telefone'],
                      responsavel: agendamento['responsavel'],
                      telefone2: agendamento['telefone2'],
                      resposavel2: agendamento['responsavel2'],
                      implantacao_id: agendamento['implantacao_id'],
                      sistema: agendamento['sistema'],
                      vendedor: agendamento['vendedor'],
                      vendedor_id: (agendamento['vendedor_id'] == null ? null : agendamento['vendedor_id'].toString()),
                      negociador_id: (agendamento['negociador_id'] == null ? null : agendamento['negociador_id']),
                      dias_de_teste: agendamento['dias_de_teste'],
                      tipo_fechamento: agendamento['tipo_fechamento'],
                      data_fechamento: agendamento['data_fechamento'],
                      status: agendamento['ativo'],
                      motivo: agendamento['motivo'],
                      data_cancelamento: agendamento['data_cancelamento'],
                      user_cancelamento: agendamento['user_cancelamento'],
                      confirmado: agendamento['confirmado'],
                      usuario_confirmacao: agendamento['usuario_confirmacao'],
                      data_confirmacao: agendamento['data_confirmacao'],
                      cidade: agendamento['cidade']
                  });
              });
              callback(events);
          });
      },
      eventRender: function eventRender( event, element, view ) {
          console.log('event render');
          var content = '<h3>'+event.cliente + '</h3>' +
              '<h5>' + event.cidade + '</h5>'
              '<p><b>Tipo:</b> '+event.tipo+'<br />' +
              '<p><b>Atendente:</b> '+event.user+'</p>';
          if(event.sistema != null)
              content = content + '<p><b>Sistema:</b> '+event.sistema+'</p>';
          if(event.vendedor != null)
              content = content + '<p><b>Vendedor:</b> '+event.vendedor+'</p>';
          if(event.dias_de_teste != null)
              content = content + '<p><b>Dias teste:</b> '+event.dias_de_teste+'</p>';
          if(event.user != null)
              content = content + '<p><b>Técnico:</b> '+event.user+'</p>';
          else
              content = content + '<p><b>Técnico:</b> </p>';
          content = content + '<p><b>Empresa:</b> '+event.empresa+'</p>';
              element.qtip({
                  content: {
                      text: content
                  },
                  position: {
                      my: 'bottom center',
                      at: 'top center',
                      viewport: $('#fullcalendar'),
                      adjust: {
                          mouse: false,
                          scroll: false
                      }
                  },
                  style: 'qtip-light',
                  show: { solo: true },
                  hide: {
                      delay: 10
                  }
              });
              if(event.end.add(2, 'hours') < moment()){
                  var css = $(element).css('background-color');
                  if(css != '') {
                      css = css.substring(4, css.length - 1);
                      var array = css.split(',')
                      var color1 = parseInt(array[0].trim());
                      color1 = Math.round((color1 + 255)/2);
                      var color2 = parseInt(array[1].trim());
                      color2 = Math.round((color2 + 255)/2);
                      var color3 = parseInt(array[2].trim());
                      color3 = Math.round((color3 + 255)/2);
                      $(element).css('background-color', 'rgb(' + color1 + ', ' + color2 + ', ' + color3 + ')');
                      var css = $(element).css('background-color');
                  }
              }
              return ['all', event.user_id].indexOf($('#user_id_selector').val()) >= 0 &&
                  ['all', event.tipo_id].indexOf($('#tipo_id_selector').val()) >= 0 &&
                  ['all', event.cliente_id].indexOf($('#filtro_cliente_id').val()) >= 0 &&
                  ['all', event.vendedor_id].indexOf($('#filtro_vendedor_id').val() == '' ? 'all' : $('#filtro_vendedor_id').val()) >= 0 &&
                  ['all', event.empresa_id].indexOf($('#filtro_empresa_id').val() == '' ? 'all' : $('#filtro_empresa_id').val()) >= 0
      },
      eventAfterAllRender: function (view) {
          console.log('after render');
          var quantity = $('.fc-event').length;
          $("#quantity").text('(' + quantity + ' agendamentos)');
      },
    });
  });