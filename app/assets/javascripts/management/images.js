$(document).on("turbolinks:load", function() {
  $("#images-presentation").on("change","input[type=checkbox]", function() {
    if(this.id === "chk_all") {
      $("input[type=checkbox]").next("a").children("img").toggleClass("blur")
      if(this.checked) {
        $("input[type=checkbox]").prop("checked", true)
      }
      else {
        $("input[type=checkbox]").prop("checked", false)
      }
    }
    else {
      $(this).next("a").children("img").toggleClass("blur")
    }

    if($(".checkbox:checked").length > 0) {
      $("#delete-images").prop("disabled", false);
      $("#download-images").prop("disabled", false);
    }
    else {
      $("#delete-images").prop("disabled", true);
      $("#download-images").prop("disabled", true);
    }
  });
});
