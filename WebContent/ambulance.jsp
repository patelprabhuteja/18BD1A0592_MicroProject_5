<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ambulance Portal</title>
<link rel='stylesheet' href="style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
	<div class="container" style="height: 85vh">
		<label style="margin-top: 30px;">
			You Will be Notified when a patient requires ambulance 
		</label>
		<table id="patients" class="table" style="margin-top: 30px;">
			<thead>
				<tr>
					<th>Patient Name</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
		var websocket = new WebSocket("ws://localhost:8080/MP5/VitalCheckEndPoint");
		websocket.onmessage = function processMessage(message) {
			var jsonData = JSON.parse(message.data);
			if (jsonData.message != null) {
				var details = jsonData.message.split(',');
				var row = document.getElementById('patients').insertRow();
				row.innerHTML = "<td>" + details[0] + "</td><td>" + details[1] + "</td>";
				showPopup(details[0]+" requires an ambulance.");
				alert(details[0] + " requires an ambulance");
			}
		}
		function showPopup(message){
			const popup=document.createElement("div");
			popup.classList.add("popup");
			popup.innerText=message;
			document.querySelector("body").appendChild(popup);
			setTimeout(()=>{
				popup.remove();
			},5000);
		}
	</script>
</body>
</html>