<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="ISO-8859-1">
	<title>Patient Portal</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container" style="height: 85vh;">
        <div class="container oxygenDet py-3 mt-3 d-flex align-items-center justify-content-center">
        	<div class="form-floating mb-3 w-25">
  				<input type="text" class="form-control" id="vital" name="vital" placeholder="Enter Oxygen Levels" required>
  				<label for="vital">Enter Oxygen levels</label>
			</div>
			<div class="form-floating mb-3 w-25">
  				<input type="text" class="form-control" id="pulse" name="pulse" placeholder="Enter Pulse" required>
  				<label for="pulse">Enter Pulse</label>
			</div>
			<div class="form-floating mb-3 w-25">
  				<input type="text" class="form-control" id="temperature" name="temperature" placeholder="Enter Temperature" required>
  				<label for="temperature">Enter Temperature</label>
			</div>
            <button onclick="sendVitals();" class="btn btn-success btn-sm mb-3 py-2 px-4">Submit</button>
        </div>
		<table id="example" class="w-100">
			<thead>
				<tr>
					<th>Doctor</th>
					<th>Medicine</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr></tr>
			</tbody>
		</table>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"></script>
	<script>
		var websocket=new WebSocket("ws://localhost:8080/MP5/VitalCheckEndPoint");
		websocket.onmessage=function processVital(vital){
			var jsonData=JSON.parse(vital.data);
			if(jsonData.message!=null)
			{
				var details=jsonData.message.split(',');
				var row=document.getElementById('example').insertRow();
				if(details.length>2)
				{
					row.innerHTML="<td>"+details[0]+"</td><td>"+details[1]+"</td><td>"+details[2]+"</td>";		
				}
				else
				{
					showPopup(details[0]+" has summoned an ambulance.","dark");
					alert(details[0]+" has summoned an ambulance");
					row.innerHTML="<td>"+details[0]+"</td><td></td><td>"+details[1]+"</td>";		
				}
			}
		}
		function sendVitals()
		{
			if(vital.value==="" || pulse.value==="" || temperature.value===""){
				showPopup("All fields are required.");
				return;
			}
			if(vital.value>=90){
				showPopup("You are fine.","dark");
			}
			else{
				websocket.send(vital.value+","+pulse.value+","+temperature.value);
			}
			vital.value="";
			pulse.value="";
			temperature.value="";
		}
		function showPopup(message,color){
			const popup=document.createElement("div");
			popup.classList.add("popup");
			popup.classList.add("text-"+color);
			popup.innerText=message;
			document.querySelector("body").appendChild(popup);
			setTimeout(()=>{
				popup.remove();
			},5000);
		}
	</script>
</body>
</html>
