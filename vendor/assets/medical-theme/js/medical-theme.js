/* Theme Name: The Project - Responsive Website Template
 * Author: HtmlCoder
 * Author URI:http://www.htmlcoder.me
 * Author e-mail:htmlcoder.me@gmail.com
 * Version: 2.0.5
 * Created: March 2015
 * License URI: http://support.wrapbootstrap.com/
 * File Description: Initializations of plugins
 */

(function($) {
  $(document).ready(function() {

    if ($('.boxed .fullscreen-bg').length > 0) {
      $("body").addClass("transparent-page-wrapper");
    };

    //Show dropdown on hover only for desktop devices
    //-----------------------------------------------
    if (Modernizr.mq('only all and (min-width: 992px)')) {
      $('.main-navigation:not(.onclick) .navbar-nav>li.dropdown, .main-navigation:not(.onclick) li.dropdown>ul>li.dropdown').hover(
        function() {
          var $this = $(this);
          $this.addClass('show');
          $this.find('>.dropdown-menu').addClass('show');
        },
        function() {
          $(this).removeClass('show');
          $(this).find('>.dropdown-menu').removeClass('show');
        });
    };

    //Show dropdown on click only for mobile devices
    //-----------------------------------------------
    if (Modernizr.mq('only all and (max-width: 991px)') || $(".main-navigation.onclick").length > 0) {
      $('.header [data-toggle=dropdown], .header-top [data-toggle=dropdown]').on('click', function(event) {
        // Avoid following the href location when clicking
        event.preventDefault();

        // Avoid having the menu to close when clicking
        event.stopPropagation();

        // close all the siblings
        $(this).parent().siblings().removeClass('show');
        $(this).parent().siblings().find('.dropdown-menu').removeClass('show');

        // close all the submenus of siblings
        $(this).parent().siblings().find('[data-toggle=dropdown]').parent().removeClass('show');

        // opening the one you clicked on
        $(this).parent().toggleClass('show');
        $(this).siblings('.dropdown-menu').toggleClass('show');
      });
    };

    //Transparent Header Calculations
    var timer_tr;
    if ($(".transparent-header").length > 0) {
      var trHeaderHeight;
      $(window).on('load', function(e) {
        trHeaderHeight = $("header.header").outerHeight();
        $(".transparent-header .tp-bannertimer").css("marginTop", (trHeaderHeight) + "px");
      });
      var headerTopHeightResize = $(".header-top").outerHeight();
      $(window).resize(function() {
        if ($(this).scrollTop() < headerTopHeightResize + trHeaderHeight - 5) {
          trHeaderHeight = $("header.header").outerHeight();
          $(".transparent-header .tp-bannertimer").css("marginTop", (trHeaderHeight) + "px");
        }
      });
      $(window).scroll(function() {
        if ($(this).scrollTop() == 0) {
          if (timer_tr) {
            window.clearTimeout(timer_tr);
          };
          timer_tr = window.setTimeout(function() {
            trHeaderHeight = $("header.header").outerHeight();
            $(".transparent-header .tp-bannertimer").css("marginTop", (trHeaderHeight) + "px");
          }, 300);
        };
      });
    }

    if ($(".transparent-header .slideshow").length > 0) {
      $(".header-container header.header").addClass("transparent-header-on");
    } else {
      $(".header-container header.header").removeClass("transparent-header-on");
    }

    //Full Width Slider with Transparent Header Calculations
    if ($(".transparent-header .slider-banner-fullwidth-big-height").length > 0) {
      if (Modernizr.mq('only all and (max-width: 991px)')) {
        $("body").removeClass("transparent-header");
        $(".header-container header.header").removeClass("transparent-header-on");
        $(".tp-bannertimer").css("marginTop", "0px");
        $("body").addClass("slider-banner-fullwidth-big-height-removed");
      } else {
        $("body").addClass("transparent-header");
        $(".header-container header.header").addClass("transparent-header-on");
        $("body").removeClass("slider-banner-fullwidth-big-height-removed");
      }
    };

    if ($(".transparent-header .slider-banner-fullwidth-big-height").length > 0 || $(".slider-banner-fullwidth-big-height-removed").length > 0) {
      $(window).resize(function() {
        if (Modernizr.mq('only all and (max-width: 991px)')) {
          $("body").removeClass("transparent-header");
          $(".header-container header.header").removeClass("transparent-header-on");
          $(".tp-bannertimer").css("marginTop", "0px");
        } else {
          $("body").addClass("transparent-header");
          $(".header-container header.header").addClass("transparent-header-on");
        }
      });
    };

    //Mega menu fixed width
    if ($('html[dir="ltr"] .container .mega-menu--wide').length > 0 && Modernizr.mq('only all and (min-width: 992px)')) {
      var headerSecondLeft = parseInt($('.main-navigation--mega-menu').closest('.header-second').parent().offset().left + 15),
        headerFirstLeft = parseInt($('.header-first').offset().left),
        megaMenuLeftPosition = headerFirstLeft - headerSecondLeft;
      $('.mega-menu--wide > .dropdown-menu').css('left', megaMenuLeftPosition + 'px');
      $(window).resize(function() {
        var headerSecondLeft = parseInt($('.main-navigation--mega-menu').closest('.header-second').parent().offset().left + 15),
          headerFirstLeft = parseInt($('.header-first').offset().left),
          megaMenuLeftPosition = headerFirstLeft - headerSecondLeft;
        $('.mega-menu--wide > .dropdown-menu').css('left', megaMenuLeftPosition + 'px');
      });
    }
    if ($('html[dir="rtl"] .container .mega-menu--wide').length > 0 && Modernizr.mq('only all and (min-width: 992px)')) {
      var headerSecond = $('.main-navigation--mega-menu').closest('.header-second').parent(),
        headerSecondRight = parseInt(headerSecond.offset().left + headerSecond.outerWidth()),
        headerFirstRight = parseInt($('.header-first').offset().left + $('.header-first').outerWidth() + 15),
        megaMenuRightPosition = headerSecondRight - headerFirstRight;
      $('.mega-menu--wide > .dropdown-menu').css('right', megaMenuRightPosition + 'px');
      $(window).resize(function() {
        var headerSecond = $('.main-navigation--mega-menu').closest('.header-second').parent(),
          headerSecondRight = parseInt(headerSecond.offset().left + headerSecond.outerWidth()),
          headerFirstRight = parseInt($('.header-first').offset().left + $('.header-first').outerWidth() + 15),
          megaMenuRightPosition = headerSecondRight - headerFirstRight;
        $('.mega-menu--wide > .dropdown-menu').css('right', megaMenuRightPosition + 'px');
      });
    }

    //Mega menu full width
    if ($('html[dir="ltr"] .container-fluid .mega-menu--wide').length > 0 && Modernizr.mq('only all and (min-width: 992px)')) {
      var headerSecondLeft = parseInt($('.main-navigation--mega-menu').closest('.header-second').parent().offset().left + 15),
        headerFirstLeft = parseInt($('.header-first').offset().left),
        megaMenuLeftPosition = headerFirstLeft - headerSecondLeft,
        megaMenuWidth = parseInt($('.header .container-fluid').width());
      $('.mega-menu--wide > .dropdown-menu').css('left', megaMenuLeftPosition + 'px');
      $('.mega-menu--wide > .dropdown-menu').css('width', megaMenuWidth + 'px');
      $(window).resize(function() {
        var headerSecondLeft = parseInt($('.main-navigation--mega-menu').closest('.header-second').parent().offset().left + 15),
          headerFirstLeft = parseInt($('.header-first').offset().left),
          megaMenuLeftPosition = headerFirstLeft - headerSecondLeft,
          megaMenuWidth = parseInt($('.header .container-fluid').width());
        $('.mega-menu--wide > .dropdown-menu').css('left', megaMenuLeftPosition + 'px');
        $('.mega-menu--wide > .dropdown-menu').css('width', megaMenuWidth + 'px');
      });
    }
    if ($('html[dir="rtl"] .container-fluid .mega-menu--wide').length > 0 && Modernizr.mq('only all and (min-width: 992px)')) {
      var headerSecond = $('.main-navigation--mega-menu').closest('.header-second').parent(),
        headerSecondRight = parseInt(headerSecond.offset().left + headerSecond.outerWidth()),
        headerFirstRight = parseInt($('.header-first').offset().left + $('.header-first').outerWidth() + 15),
        megaMenuRightPosition = headerSecondRight - headerFirstRight;
      megaMenuWidth = parseInt($('.header .container-fluid').width());
      $('.mega-menu--wide > .dropdown-menu').css('right', megaMenuRightPosition + 'px');
      $('.mega-menu--wide > .dropdown-menu').css('width', megaMenuWidth + 'px');
      $(window).resize(function() {
        var headerSecond = $('.main-navigation--mega-menu').closest('.header-second').parent(),
          headerSecondRight = parseInt(headerSecond.offset().left + headerSecond.outerWidth()),
          headerFirstRight = parseInt($('.header-first').offset().left + $('.header-first').outerWidth() + 15),
          megaMenuRightPosition = headerSecondRight - headerFirstRight;
        megaMenuWidth = parseInt($('.header .container-fluid').width());
        $('.mega-menu--wide > .dropdown-menu').css('right', megaMenuRightPosition + 'px');
        $('.mega-menu--wide > .dropdown-menu').css('width', megaMenuWidth + 'px');
      });
    }

    //Full Page
    if ($(".fullpage-site").length > 0) {
      $('.fullpage-site').fullpage({
        anchors: ['firstPage', 'secondPage', 'thirdPage', 'fourthPage', 'fifthPage'],
        navigation: true,
        navigationPosition: 'right',
        navigationTooltips: ['Intro', 'About', 'Portfolio', 'Clients', 'Contact Us'],
        fixedElements: '.header-container, .subfooter',
        responsiveWidth: 992,
        responsiveHeight: 600
      });
    }
    if ($(".fullpage-site-with-menu").length > 0) {
      $('.fullpage-site-with-menu').fullpage({
        anchors: ['firstPage', 'secondPage', 'thirdPage', 'fourthPage', 'fifthPage'],
        navigation: true,
        navigationPosition: 'right',
        navigationTooltips: ['Intro', 'About', 'Menu', 'Reviews', 'Contact Us'],
        fixedElements: '.header-container, .subfooter',
        responsiveWidth: 992,
        responsiveHeight: 600,
        menu: '#fullpage-menu',
      });
    };

    // Fixed header
    //-----------------------------------------------
    if (($(".header.fixed.fixed-desktop").length > 0) && Modernizr.mq('only all and (min-width: 992px)')) {
      var sticky = new Waypoint.Sticky({
        element: $('.header-container .header.fixed'),
        stuckClass: 'object-visible',
        handler: function(direction) {
          $('body').toggleClass('fixed-header-on');
        },
        offset: -1
      });
    };
    if ($(".header.fixed.fixed-all").length > 0) {
      var sticky = new Waypoint.Sticky({
        element: $('.header-container .header.fixed'),
        stuckClass: 'object-visible',
        handler: function(direction) {
          $('body').toggleClass('fixed-header-on');
        },
        offset: -1
      });
    };

    // Charts
    //-----------------------------------------------
    if ($(".graph").length > 0) {
      // Creates random numbers you don't need this for real graphs
      var randomScalingFactor = function() {
        return Math.round(Math.random() * 500)
      };

      if ($(".graph.line").length > 0) {
        // Data for line charts
        var lineChartData = {
          labels: ["January", "February", "March", "April", "May", "June", "July"],
          datasets: [{
            label: "My First dataset",
            fill: false,
            lineTension: 0.1,
            backgroundColor: "rgba(75,192,192,0.4)",
            borderColor: "rgba(75,192,192,1)",
            borderCapStyle: 'butt',
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: 'miter',
            pointBorderColor: "rgba(75,192,192,1)",
            pointBackgroundColor: "#fff",
            pointBorderWidth: 1,
            pointHoverRadius: 5,
            pointHoverBackgroundColor: "rgba(75,192,192,1)",
            pointHoverBorderColor: "rgba(220,220,220,1)",
            pointHoverBorderWidth: 2,
            pointRadius: 1,
            pointHitRadius: 10,
            data: [65, 59, 80, 81, 56, 55, 40],
            spanGaps: false,
          }]
        };

        // Line Charts Initialization
        $(window).on('load', function(e) {
          var ctx = document.getElementById("lines-graph").getContext("2d");
          var LineChart = new Chart(ctx, {
            type: 'line',
            data: lineChartData,
            responsive: true,
            bezierCurve: false
          });
        });
      }
      if ($(".graph.bar").length > 0) {
        // Data for bar charts
        var barChartData = {
          labels: ["January", "February", "March", "April", "May", "June", "July"],
          datasets: [{
            label: "My First dataset",
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(153, 102, 255, 0.2)',
              'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
              'rgba(255,99,132,1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)',
              'rgba(153, 102, 255, 1)',
              'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1,
            data: [65, 59, 80, 81, 56, 55, 40],
          }]
        };

        // Bar Charts Initialization
        $(window).on('load', function(e) {
          var ctx = document.getElementById("bars-graph").getContext("2d");
          var BarChart = new Chart(ctx, {
            type: 'bar',
            data: barChartData,
            responsive: true
          });
        });
      }
      if ($(".graph.pie").length > 0) {
        // Data for pie chart
        var pieData = {
          labels: [
            "Red",
            "Blue",
            "Yellow"
          ],
          datasets: [{
            data: [300, 50, 100],
            backgroundColor: [
              "#FF6384",
              "#36A2EB",
              "#FFCE56"
            ],
            hoverBackgroundColor: [
              "#FF6384",
              "#36A2EB",
              "#FFCE56"
            ]
          }]
        };

        // Pie Chart Initialization
        $(window).on('load', function(e) {
          var ctx = document.getElementById("pie-graph").getContext("2d");
          var PieChart = new Chart(ctx, {
            type: 'pie',
            data: pieData
          });
        });
      }
      if ($(".graph.doughnut").length > 0) {
        // Data for doughnut chart
        var doughnutData = {
          labels: [
            "Red",
            "Blue",
            "Yellow"
          ],
          datasets: [{
            data: [300, 50, 100],
            backgroundColor: [
              "#FF6384",
              "#36A2EB",
              "#FFCE56"
            ],
            hoverBackgroundColor: [
              "#FF6384",
              "#36A2EB",
              "#FFCE56"
            ]
          }]
        };

        // Doughnut Chart Initialization
        $(window).on('load', function(e) {
          var ctx = document.getElementById("doughnut-graph").getContext("2d");
          var DoughnutChart = new Chart(ctx, {
            type: 'doughnut',
            data: doughnutData,
            responsive: true
          });
        });
      }
    };

    // Magnific popup
    //-----------------------------------------------
    if (($(".popup-img").length > 0) || ($(".popup-iframe").length > 0) || ($(".popup-img-single").length > 0) || $(".owl-carousel--popup-img").length > 0) {
      $(".popup-img").magnificPopup({
        type: "image",
        gallery: {
          enabled: true,
        }
      });
      if ($(".owl-carousel--popup-img").length > 0) {
        $(".owl-carousel").each(function() {
          $(this).find(".owl-item:not(.cloned) .owl-carousel--popup-img").magnificPopup({
            type: "image",
            gallery: {
              enabled: true,
            }
          });
        });
      }
      $(".popup-img-single").magnificPopup({
        type: "image",
        gallery: {
          enabled: false,
        }
      });
      $('.popup-iframe').magnificPopup({
        disableOn: 700,
        type: 'iframe',
        preloader: false,
        fixedContentPos: false
      });
    };

    // Animations
    //-----------------------------------------------
    if ($("[data-animation-effect]").length > 0) {
      $("[data-animation-effect]").each(function() {
        if (Modernizr.csstransitions) {
          var waypoints = $(this).waypoint(function(direction) {
            animatedObject = $(this.element);
            animatedObject.addClass('animated object-visible ' + animatedObject.attr("data-animation-effect"));
            this.destroy();
          }, {
            offset: '90%'
          });
        } else {
          $(this).addClass('object-visible');
        }
      });
    };

    // Text Rotators
    //-----------------------------------------------
    if ($(".text-rotator").length > 0) {
      $(".text-rotator").each(function() {
        var tr_animationEffect = $(this).attr("data-rotator-animation-effect");
        $(this).Morphext({
          animation: "" + tr_animationEffect + "", // Overrides default "bounceIn"
          separator: ",", // Overrides default ","
          speed: 3000 // Overrides default 2000
        });
      });
    };

    // Stats Count To
    //-----------------------------------------------
    if ($(".stats [data-to]").length > 0) {
      $(".stats [data-to]").each(function() {
        var waypoints = $(this).waypoint(function(direction) {
          countingObject = $(this.element);
          countingObject.countTo();
          this.destroy();
        }, {
          offset: '95%'
        });
      });
    };

    // Isotope filters
    //-----------------------------------------------
    if ($('.isotope-container').length > 0 || $('.masonry-grid').length > 0 || $('.masonry-grid-fitrows').length > 0 || $('.isotope-container-fitrows').length > 0) {
      $('.masonry-grid').isotope({
        itemSelector: '.masonry-grid-item',
        layoutMode: 'masonry'
      });
      $('.masonry-grid-fitrows').isotope({
        itemSelector: '.masonry-grid-item',
        layoutMode: 'fitRows'
      });
      $('.isotope-container').fadeIn();
      var $container = $('.isotope-container').imagesLoaded(function() {
        $container.isotope({
          itemSelector: '.isotope-item',
          layoutMode: 'masonry',
          transitionDuration: '0.6s',
          filter: "*"
        });
      });
      $('.isotope-container-fitrows').fadeIn();
      var $container_fitrows = $('.isotope-container-fitrows').imagesLoaded(function() {
        $container_fitrows.isotope({
          itemSelector: '.isotope-item',
          layoutMode: 'fitRows',
          transitionDuration: '0.6s',
          filter: "*"
        });
      });
      // filter items on button click
      $('.filters').on('click', 'ul.nav li a', function() {
        var filterValue = $(this).attr('data-filter');
        $(".filters").find("li .active").removeClass("active");
        $(this).addClass("active");
        $container.isotope({
          filter: filterValue
        });
        $container_fitrows.isotope({
          filter: filterValue
        });
        return false;
      });
      $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
        $('.tab-pane .masonry-grid-fitrows').isotope({
          itemSelector: '.masonry-grid-item',
          layoutMode: 'fitRows'
        });
      });
    };

    // Animated Progress Bars
    //-----------------------------------------------
    if ($("[data-animate-width]").length > 0) {
      $("[data-animate-width]").each(function() {
        if (!Modernizr.csstransitions) {
          $(this).find("span").hide();
        };
        var waypoints = $(this).waypoint(function(direction) {
          $(this.element).animate({
            width: $(this.element).attr("data-animate-width")
          }, 800);
          this.destroy();
          if (!Modernizr.csstransitions) {
            $(this.element).find("span").show('slow');
          };
        }, {
          offset: '90%'
        });
      });
    };

    // Animated Circular Progress Bars
    //-----------------------------------------------
    if ($(".knob").length > 0) {

      $(".knob").knob();
      $(".knob").each(function() {
        var animateVal = $(this).attr("data-animate-value");
        $(this).animate({
          animatedVal: animateVal
        }, {
          duration: 2000,
          step: function() {
            $(this).val(Math.ceil(this.animatedVal)).trigger("change");
          }
        });
      });
    }

    //Scroll totop
    //-----------------------------------------------
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

    //Modal
    //-----------------------------------------------
    if ($(".modal").length > 0) {
      $(".modal").each(function() {
        $(".modal").prependTo("body");
      });
    }

    // Pricing tables popovers
    //-----------------------------------------------
    if ($(".pricing-tables").length > 0) {
      $(".plan .pt-popover").popover({
        trigger: 'hover',
        container: 'body'
      });
    };

    //Scroll Spy
    //-----------------------------------------------
    if ($(".scrollspy").length > 0) {
      $("body").addClass("scroll-spy");
      if ($(".fixed.header").length > 0) {
        $('body').scrollspy({
          target: '.scrollspy',
          offset: 85
        });
      } else {
        $('body').scrollspy({
          target: '.scrollspy',
          offset: 20
        });
      }
    }

    //Smooth Scroll
    //-----------------------------------------------
    if ($(".smooth-scroll").length > 0) {
      if (($(".header.fixed").length > 0) && (Modernizr.mq('only all and (min-width: 768px)'))) {
        $('.smooth-scroll a, a.smooth-scroll').click(function() {
          if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
              $('html,body').animate({
                scrollTop: target.offset().top - 63
              }, 1000);
              return false;
            }
          }
        });
      } else {
        $('.smooth-scroll a, a.smooth-scroll').click(function() {
          if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
              $('html,body').animate({
                scrollTop: target.offset().top
              }, 1000);
              return false;
            }
          }
        });
      }
    }

    // Offcanvas side navbar
    //-----------------------------------------------
    if ($("#offcanvas").length > 0) {
      $('#offcanvas').offcanvas({
        canvas: "body",
        disableScrolling: false,
        toggle: false
      });
    };

    if ($("#offcanvas").length > 0) {
      $('#offcanvas [data-toggle=dropdown]').on('click', function(event) {
        // Avoid following the href location when clicking
        event.preventDefault();
        // Avoid having the menu to close when clicking
        event.stopPropagation();
        // close all the siblings
        $(this).parent().siblings().removeClass('open');
        // close all the submenus of siblings
        $(this).parent().siblings().find('[data-toggle=dropdown]').parent().removeClass('open');
        // opening the one you clicked on
        $(this).parent().toggleClass('open');
      });
    };

    // Parallax section
    //-----------------------------------------------
    if (($(".parallax").length > 0)) {
      $(".parallax").parallax("50%", 0.2);
    };
    if (($(".parallax-2").length > 0)) {
      $(".parallax-2").parallax("50%", 0.3);
    };
    if (($(".parallax-3").length > 0)) {
      $(".parallax-3").parallax("50%", 0.4);
    };

    // Notify Plugin
    //-----------------------------------------------
    if ($(".btn-alert").length > 0) {
      $(".btn-alert").on('click', function(event) {
        $.notify({
          // options
          message: 'Great! you have just created this message :-) you can configure this into the template.js file'
        }, {
          // settings
          type: 'info',
          delay: 4000,
          offset: {
            y: 100,
            x: 20
          }
        });
        return false;
      });
    };

    // Remove Button
    //-----------------------------------------------
    $(".btn-remove").click(function() {
      $(this).closest(".remove-data").remove();
    });

    // Shipping Checkbox
    //-----------------------------------------------
    if ($("#shipping-info-check").is(':checked')) {
      $("#shipping-information").hide();
    }
    $("#shipping-info-check").change(function() {
      if ($(this).is(':checked')) {
        $("#shipping-information").slideToggle();
      } else {
        $("#shipping-information").slideToggle();
      }
    });

    // Full Width Image Overlay
    //-----------------------------------------------
    if ($(".full-image-overlay").length > 0) {
      overlayHeight = $(".full-image-overlay").outerHeight();
      $(".full-image-overlay").css("marginTop", -overlayHeight / 2);
    };

    //This will prevent the event from bubbling up and close the dropdown when you type/click on text boxes (Header Top).
    //-----------------------------------------------
    $('.header-top .dropdown-menu input').click(function(e) {
      e.stopPropagation();
    });

  }); // End document ready

})(this.jQuery);

if (jQuery(".btn-print").length > 0) {
  function print_window() {
    var mywindow = window;
    mywindow.document.close();
    mywindow.focus();
    mywindow.print();
    mywindow.close();
  }
}
