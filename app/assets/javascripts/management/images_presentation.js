$(document).on("turbolinks:load", function() {
  $("#album-list .group-item-album a").click(function() {
    $("#images-presentation").magnificPopup({
      delegate: "div div div a.pt-image",
      type: "image",
      gallery: {enabled: true}
    });
  })
});
