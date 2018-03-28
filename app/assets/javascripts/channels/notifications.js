App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel\
    $("#notification-icon span").remove();
    if (data.unread_noti_count > 0){
      $("#notification-icon").append("<span class='label label-warning'>" + data.unread_noti_count + "</span>");
    }
  }
});
