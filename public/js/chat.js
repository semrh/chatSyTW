$('#text').keypress(
  function(e){
    if( e.keyCode==13 ){
      $.get('/send',{text:$('#text').val()});
      $('#text').val('');
    } 
  }
);

$('#btn-chat').click(
  function(e){
    $.get('/send',{text:$('#text').val()});
    $('#text').val('');
  }
);

(function() {
  setInterval(
    function(){
      $.get('/update/usuarios',{},
        function(response){
          $('#usuarios1').empty();
          $('#usuarios1').append(response);
        }
      );
    },
  1000);
})();
