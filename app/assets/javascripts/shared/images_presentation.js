$(document).on("turbolinks:load", function() {
  $("#album-list .group-item-album a").click(function() {
    $("#images-presentation").magnificPopup({
      delegate: "div div div a",
      type: "image",
      gallery: {enabled: true}
    });
  })
});
