// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require nprogress
//= require nprogress-turbolinks
//= require turbolinks
//= require_tree .

$(document).on('page:load', function(){
  appInit();
});

$(document).ready(function(){
  appInit();
});

function appInit(){
  $(".more-items-control").click(function(event){
    event.preventDefault();
    $("#more-items").toggle();
  });

//  Open all external links with new window
  $("a").click(function() {
    link_host = this.href.split("/")[2];
    document_host = document.location.href.split("/")[2];

    if (link_host != document_host) {
      window.open(this.href);
      return false;
    }
  });
}