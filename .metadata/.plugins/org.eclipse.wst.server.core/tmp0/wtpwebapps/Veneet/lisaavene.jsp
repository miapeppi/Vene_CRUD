<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<title>Lis�� vene | Peppi M�kel�</title>
</head>
<body>

<div>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="6" class="oikealle"><span id="takaisin" class="siirry">TAKAISIN LISTAUKSEEN</span></th>
			</tr>
			<tr>
				<th>Nimi</th>
				<th>Merkki ja malli</th>
				<th>Pituus</th>
				<th>Leveys</th>
				<th>Hinta</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="nimi" id="nimi"></td>
				<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
				<td><input type="text" name="pituus" id="pituus"></td>
				<td><input type="text" name="leveys" id="leveys"></td>
				<td><input type="text" name="hinta" id="hinta"></td>
				<td><input type="submit" id="tallenna" class="nappi" value="LIS��"></td>
			</tr>
		</tbody>
	</table>
	<br><span id="ilmo"></span>
</form>
</div>

<script>
$(document).ready(function() {
	
	$("#nimi").focus();
	
	$("#takaisin").click(function() {
		document.location = "listaaveneet.jsp";
	});
	
	$("#tiedot").validate ({
		rules: {
			nimi: {
				required: true,
				minlength: 3
			},
			merkkimalli: {
				required: true,
				minlength: 3
			},
			pituus: {
				required: true,
				number: true,
				min: 1,
				max: 100
			},
			leveys: {
				required: true,
				number: true,
				min: 0.5,
				max: 100
			},
			hinta: {
				required: true,
				number: true,
				min: 10,
				max: 1000000
			}
		},
		messages: {
			nimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			merkkimalli: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			pituus: {
				required: "Puuttuu",
				number: "Ei numero",
				min: "Tarkista pituus",
				max: "Tarkista pituus"
			},
			leveys: {
				required: "Puuttuu",
				number: "Ei numero",
				min: "Tarkista leveys",
				max: "Tarkista leveys"
			},
			hinta: {
				required: "Puuttuu",
				number: "Ei numero",
				min: "Tarkista hinta",
				max: "Tarkista hinta"
			}
		},
		submitHandler: function(form) {
			lisaaVene();
		}
	});
});

function lisaaVene(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({
		url:"veneet", 
		data:formJsonStr, 
		type:"POST", 
		dataType:"json", 
		success:function(result) {
			if(result.response == 0){
	        	$("#ilmo").html("Veneen lis��minen ep�onnistui.");
	        }else if(result.response == 1){			
	        	$("#ilmo").html("Veneen lis��minen onnistui.");
	        	$("#nimi, #merkkimalli, #pituus, #leveys, #hinta").val("");
			}
	    }
	});	
}
</script>

</body>
</html>