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
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require rails-ujs
//= require turbolinks
//= require underscore
//= require_directory ./js


function leftmenu() {
  $( ".leftmenu" ).toggleClass( "toggle_menu" )
}
function rightmenu() {
  $( ".rightmenu" ).toggleClass( "toggle_menu" )
}
var addr_chosen = '#destino';
function choose_field(value) {
  addr_chosen = value;
}
function choose(value) {
  $(addr_chosen).val(value)
}
