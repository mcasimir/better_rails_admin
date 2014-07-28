var sortPositions = function(sortable) {
  var i = 0;
  $(sortable).find('a').each(function(){
    var tab = $($(this).attr('href'));
    
    var input = tab.find('input').filter(function(i,e){ 
      var name = $(e).attr("name");
      return name && name.match(/\[position\]$/); 
    });
    
    input.val(i);
    i++;
  });
}

$(document).on('rails_admin.dom_ready', function(){
  var sortables = $( "[data-nestedmany] .nav-tabs" );
  
  $("a.add_nested_fields").on('click tap', function(){
    var btn = $(this);
    var sortable = btn.closest('.controls').find('.nav-tabs');
    setTimeout(function() {
      sortPositions(sortable);
    }, 100);  
  });

  sortables.sortable({ axis: "x",  
    forcePlaceholderSize: true, 
    update: function( event, ui ) {
      sortPositions(event.target);
    }
  });

  sortables.each(function(){
    sortPositions(this);
  });

  $(".control-group.error").closest('.tab-pane').each(function(){
    var id = $(this).attr('id');
    $(".nav-tabs a[href='#" + id + "']").closest('li').addClass('error');
  });

});