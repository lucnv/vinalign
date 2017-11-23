$(document).on("turbolinks:load", function(){
  $(".province_selection").change(function(){
    var province_id = $(this).val();
    load_data_for_select("districts", province_id);
  });
});

function load_data_for_select(model, object){
  $.ajax({
    url: "/supports/" + model,
    type: "GET",
    dataType: "script",
    data: {object: object}
  });
}
