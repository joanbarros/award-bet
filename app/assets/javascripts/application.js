// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });

$(document).ajaxError(function(event, xhr, options, exec){

console.log(xhr.responseText);
console.log('exec->' + exec);



  var errors = JSON.parse(xhr.responseText);
  var dd = "<div class='callout alert'><ul>";

  for(var i = 0; i < errors.length; i++){
    var list = errors[i];
    dd += "<li>" + list + "</li>";
  }
  dd += "</ul></div>";
  $("#error_explanation").html(dd);


});
