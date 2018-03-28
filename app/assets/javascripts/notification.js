$(document).on("turbolinks:load", function() {
  $("#notification-icon").on("click", function(){
    $.ajax({
      url: "/supports/notifications",
      type: "GET",
      dataType: "script"
    });
  });
});

function readNotification(container){
  $.ajax({
    url: "/my_page/notifications/" + container.data("notification"),
    type: "PUT",
    dataType: "script",
    data: {is_read: 1}
  });
}
