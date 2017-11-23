(function($, _turbolinks, _bootstrapDialog) {
  "use strict";
  if (typeof(_turbolinks) != "undefined" && typeof(_bootstrapDialog) != "undefined" && _turbolinks.supported) {
    $(document).on("turbolinks:before-cache", function() {
      $.each(_bootstrapDialog.dialogs, function (id, dialogInstance) {
        if (dialogInstance.getModal() && dialogInstance.isOpened()) {
          $(document.body).removeClass("modal-open");
          $(".modal-backdrop.fade.in").remove();
          dialogInstance.getModal().modal("hide").remove();
        }
      });
    });
  }
})(jQuery, Turbolinks, BootstrapDialog);
