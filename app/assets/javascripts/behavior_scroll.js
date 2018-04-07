$(document).on("turbolinks:load", function() {
  window.onscroll = function() {
    stick_navbar()
  };

  var sticky = $("#sticked-navbar")[0].offsetTop;

  function stick_navbar() {
    if (window.pageYOffset >= sticky) {
      $("#sticked-navbar").addClass("sticked");
      if ($("#navbar-collapse-1").hasClass("show")) {
        $(".main-container").addClass("sticked-body-mobile-collapse");
      }
      else {
        $(".main-container").addClass("sticked-body");
      }

    } else {
      $("#sticked-navbar").removeClass("sticked");
      $(".main-container").removeClass("sticked-body");
      $(".main-container").removeClass("sticked-body-mobile-collapse");
    }
  }

  $(window).scroll(function() {
    if ($(this).scrollTop() != 0) {
      $(".scrollToTop").addClass("fadeToTop");
      $(".scrollToTop").removeClass("fadeToBottom");
    } else {
      $(".scrollToTop").removeClass("fadeToTop");
      $(".scrollToTop").addClass("fadeToBottom");
    }
  });

  $(".scrollToTop").click(function() {
    $("body,html").animate({
      scrollTop: 0
    }, 800);
  });
})
