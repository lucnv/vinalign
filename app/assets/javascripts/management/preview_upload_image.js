$(document).on("turbolinks:load", function() {
  function previewImageUpload(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $("#image_preview").attr("src", e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#image_upload").change(function() {
    previewImageUpload(this);
  });
});
