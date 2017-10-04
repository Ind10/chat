<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>

<div style="margin-top: 40px;" class="container">

<form class="form-horizontal" style="margin: auto; width: 20%;" id="myform" >
<div class="form-group">
<textarea class="form-control" id="result" rows="20" cols="5"></textarea>
</div>

<div class="form-group">
<input class="form-control" type="text" name="question" id="message" placeholder="Message" >
</div>

</form>
<div class="container"  style="margin: auto; width: 10%;" >
<button class="btn btn-info" id="button">Send</button>
</div>
</div>
</body>
</html>
<script>
var ws;
var stompClient;

$(document).ready(function () {

	$('#button').click(function (){	
		sendForm();
		$('#message').val('');	
	});
	ws = new SockJS("questions");
	stompClient = Stomp.over(ws);
	
	
	stompClient.connect({},function (frame) {		
		stompClient.subscribe("/topic/questions",function(message) {
			var myTextArea = $('#result');
			myTextArea.val(myTextArea.val() + '\n'+message.body);
		});	
	});	
	
});

function sendForm(){
	stompClient.send("/topic/questions",{} , $("#message").val());
};
</script>