

let testAzureFunction = (Name, Age) => {

	const FunctionName 			= "MakeApplication"
	const FunctionDeployment 	= "loadapplication01"
	const Key 					= "Fwld4qja1MRAdqFb6gwacWGaWZNR1UnRCPaCNuJMserBCeDuEud0Ag=="

	const Address = `https://${FunctionDeployment}.azurewebsites.net/api/${FunctionName}?code=${Key}`


	$.ajax({
		url: Address,
		type: 'POST',
		dataType: 'json',
		data: {"Name" : Name, "Age"  : Age },
	})
	.done(function(data) {
		console.log("success", data);
	})
	.fail(function() {
		console.log("error");
	})
	.always(function() {
		console.log("complete");
	});
	



}


$("#testMe").click( () => testAzureFunction("Jalal", "40") )


