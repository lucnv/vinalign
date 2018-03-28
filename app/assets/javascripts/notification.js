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
    url: "/supports/notifications/" + container.data("notification-id"),
    type: "PUT",
    dataType: "script",
    data: {is_read: 1}
  });
}
