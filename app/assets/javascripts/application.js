// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery/dist/jquery
//= require jquery-ui
//= require bootstrap/dist/js/bootstrap
//= require jquery-easing/jquery.easing.1.3
//= require datatables
//= require sb-admin-2
//= require toastr/toastr
//= require moment
//= require fullcalendar/main.min
//= require fullcalendar/locales-all.min
//= require bootstrap-datetimepicker


function exibirErro(msgErro) {
  toastr.options = {
      closeButton: true,
      showMethod: 'slideDown',
      showDuration: "300",
  };
  toastr.error(msgErro);
}

function exibirMsg(msg){
  toastr.options = {
    closeButton: true,
    showMethod: 'slideDown',
    showDuration: "3000",
    hideDuration: "1000",
    timeOut: "5000",
    extendedTimeOut: "1000",
    positionClass: "toast-bottom-right",
  };
  toastr.success(msg);
}

function exibirWarning(msg){
  toastr.options = {
      closeButton: true,
      showMethod: 'slideDown'
  };
  toastr.warning(msg);
}