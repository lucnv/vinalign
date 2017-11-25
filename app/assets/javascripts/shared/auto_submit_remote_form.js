$(document).on("turbolinks:load", function(){
  $(document).on("change", ".auto_remote_form", function(){ 
    var data = new FormData($(this)[0]),
      url = $(this).attr("action"),
      method = $(this).attr("method");
    $.ajax({
      type: method,
      processData: false,
      contentType: false,
      cache: false,
      url: url,
      data: data,
      dataType: "script"
    });
  });
});
