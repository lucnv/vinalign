$(document).on("turbolinks:load", function() {
  $("#images-list").magnificPopup({
    delegate: "div div a.pt-image",
    type: "image",
    gallery: {enabled: true},
    image: {
      verticalFit: true,
      titleSrc: function(item) {
        return item.el.siblings(".image-name").text();
      }
    },
    zoom: {
      enabled: true,
      duration: 300
    }
  });
});
