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
            console.log('add equipamentos');
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

  $('#btnSalvarAgendamento').click(function () {
    $.ajax({
      url: '/schedules/save_schedule',
      data: { start: $('#agendamento #start').val(), end: $('#agendamento #end').val(), 
              laboratory_id: $('#agendamento #laboratory_id').val(), equipament_id: $('#agendamento #equipament_id').val(),
              type_reservation_id: $('#agendamento #type_reservation_id').val(),
      },
      type: 'POST',
      success: function (data) {
          exibirMsg("agendamento realizado");
          window.location.reload();
      },error: function(data){
          //exibirErro(data);
      }
    });
  })

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
        $('#agendamento #start').text(moment(start).format("DD/MM/YYYY HH:mm"));
        $('#agendamento #start').val(moment(start).format("DD/MM/YYYY HH:mm"));
        $('#agendamento #end').text(moment(end).format("DD/MM/YYYY HH:mm"));
        $('#agendamento #end').val(moment(end).format("DD/MM/YYYY HH:mm"));

        $('#agendamento').modal('show');
    },
    eventClick: function(calEvent, jsEvent, view) {
        console.log('event click, l:60');
        $.getJSON('/schedules/' + calEvent.id, function(data) {
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
                  title: agendamento['type_reservation']['description'] + '\n' + agendamento['laboratory']['name'],
                  start: moment(agendamento['start']),
                  end: moment(agendamento['end']),
                  backgroundColor: agendamento['type_reservation']['color'],
                  textColor: 'white',
                  borderColor: agendamento['color'],
                  user_id: agendamento['user_id'],
                  user: agendamento['user']['nome'],
                  status: agendamento['status'],
                  laboratory: agendamento['laboratory']['name'],
                  type_reservation: agendamento['type_reservation']['description']
                });
            });
            callback(events);
        });
    },
    eventRender: function eventRender( event, element, view ) {
        console.log('event render');
        console.log(event);
        var content = '<h3>'+event.laboratory + '</h3>' +
            '<h5>' + event.type_reservation + 'teste</h5>'
            '<p><b>Solicitante:</b> '+event.nome+'<br />' +
            '<p><b>Status:</b> '+event.status+'</p>';          
        
            
            if(event.end.add(2, 'hours') < moment()){
                var css = $(element).css('background-color');
                if(css != '') {
                    css = css.substring(4, css.length - 1);
                    console.log(css);
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
    },
    eventAfterAllRender: function (view) {
        console.log('after render');
        var quantity = $('.fc-event').length;
        $("#quantity").text('(' + quantity + ' agendamentos)');
    },
  });
});

function showAgendamento(calEvent){
  console.log(calEvent);
  $('#agendamento').modal('show');
}
  