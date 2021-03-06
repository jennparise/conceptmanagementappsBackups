

<% 
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("uicommons", "emr/simpleFormUi.css", -200);
            
    ui.includeJavascript("conceptmanagementapps", "jquery.dataTables.min.js");
    ui.includeJavascript("conceptmanagementapps", "fourButtonPagination.js");
    
    ui.includeCss("conceptmanagementapps", "../css/dataTables.css");

%>

${ ui.includeFragment("uicommons", "validationMessages")}
<script type="text/javascript">
    jQuery(function() {
        KeyboardController();
    }
</script>

 <script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("conceptmanagementapps.homepage.title") }", link: "${ ui.pageLink("conceptmanagementapps", "conceptManagementAppsMain") }" },
        { label: "${ ui.message("conceptmanagementapps.managesnomedct.title") }", link: "${ ui.pageLink("conceptmanagementapps", "manageSnomedCT") }" }
    ];
 </script>
 
 <script type="text/javascript">
 function showHideValues(){
 	var theProcessRunning="<%=processRunning.toString()%>";
 	resetButtons();
	if(theProcessRunning === "addSnomedCTNames"){
	
		document.getElementById('addSnomedCTRelationshipsId').disabled = true;
		document.getElementById('addSnomedCTAncestorsId').disabled = true;
		document.getElementById('showHideAddNames').style.display = "none";
		document.getElementById('showHideCancelAddNames').style.display = "block";
	}
	if(theProcessRunning === "addSnomedCTRelationships"){
	
		document.getElementById('addSnomedCTNamesId').disabled = true;
		document.getElementById('addSnomedCTAncestorsId').disabled = true;
		document.getElementById('showHideAddRelationships').style.display = "none";
		document.getElementById('showHideCancelAddRelationships').style.display = "block";
	}
	if(theProcessRunning === "addSnomedCTAncestors"){
	
		document.getElementById('addSnomedCTNamesId').disabled = true;
		document.getElementById('addSnomedCTRelationshipsId').disabled = true;
		document.getElementById('showHideAddAncestors').style.display = "none";
		document.getElementById('showHideCancelAddAncestors').style.display = "block";
	}
	
	function resetButtons(){

		document.getElementById('addSnomedCTAncestorsId').disabled = false;
		document.getElementById('addSnomedCTNamesId').disabled = false;
		document.getElementById('addSnomedCTRelationshipsId').disabled = false;
		document.getElementById('showHideAddNames').style.display = "block";
		document.getElementById('showHideAddRelationships').style.display = "block";
		document.getElementById('showHideAddAncestors').style.display = "block";
		document.getElementById('showHideCancelAddNames').style.display = "none";
		document.getElementById('showHideCancelAddRelationships').style.display = "none";
		document.getElementById('showHideCancelAddAncestors').style.display = "none";
		
	}
}
function validateForm(inputType) {
	if(inputType.value=="Cancel"){
		document.getElementById('inputTypeId').value = inputType.value;
	}
	else{
		document.getElementById('inputTypeId').value = inputType.name;
	}
	var directoryLocationErrText = document.getElementById("showHideDirectoryLocationValidationError");
	var error=0;
	
    directoryLocationErrText.style.display = "none";
    
    if (document.getElementById('snomedDirectoryLocationId').value == null || document.getElementById('snomedDirectoryLocationId').value.length == 0) 
    { 
    	directoryLocationErrText.style.display = "block";
    	error=1;
    }
    if(inputType.name=="showHideCancelAdd"){
    	cancelAddNames.style.display = "block";
    }
    if(error==1){
    	return false;
    }
    else 
    { 
    	document.manageSnomedCT.submit();
    	if(inputType.name=="refresh"){
    		document.getElementById('inputTypeId').value = inputType.name;
    	}
    	else{
        	inputType.value = "Cancel";
        	document.getElementById('inputTypeId').value = inputType.value;
        }
    }
}
</script>

 <h2>
        ${ui.message("conceptmanagementapps.managesnomedct.title")}
 </h2>


<form name="manageSnomedCT" class="simple-form-ui" method="post">
           
                <div id="showHideDirectoryLocationValidationError" style="display: none">
            		<p  style="color:red" class="required">(${ ui.message("emr.formValidation.messages.requiredField") })</p>
            	</div>            
				<p>
					<label name="snomedDirectoryLocationId">${ui.message("conceptmanagementapps.managesnomedct.snomeddirectorylocation.label")}</label>
					<input  type="text" name="snomedDirectoryLocation" id="snomedDirectoryLocationId" size="35" value="<%= dirLocation.toString() %>"/>
				</p>

				<div id="showHideRefresh" style="display: block">
					<p>
					<input type="button" name="refresh" id="refreshId" value="Refresh" onclick="javascript:validateForm(this);"/>
					</p>
					<p>
 					<%= processStatus.toString() %>
 					</p>
 					<p>
 					<%= processPercentComplete.toString() %>
 					</p>
				</div>
			           
           <fieldset>
                <legend>
       	 			${ui.message("conceptmanagementapps.managesnomedct.addnames.title")}
     			</legend>
     			<div id="showHideAddNames" style="display: none">
				<p class="left">
				<input type="button" name="addSnomedCTNames" id="addSnomedCTNamesId" value="Start Task" onclick="javascript:validateForm(this);"/>
				</p>
				</div>
				<div id="showHideCancelAddNames" style="display: block">
				<p>
				<input type="button" name="cancelAddNames" id="cancelAddNamesId" value="Cancel" onclick="javascript:validateForm(this);"/>
				</p>
				</div>
			</fieldset>
			
			 <fieldset>
                <legend>
       	 			${ui.message("conceptmanagementapps.managesnomedct.addancestors.title")}
     			</legend>
     			<div id="showHideAddAncestors" style="display: none">
				<p>
				<input type="button" name="addSnomedCTAncestors" id="addSnomedCTAncestorsId" value="Start Task" onclick="javascript:validateForm(this);"/>
				</p>
				</div>
				<div id="showHideCancelAddAncestors" style="display: block">
				<p>
				<input type="button" name="cancelAddAncestors" id="cancelAddAncestorsId" value="Cancel" onclick="javascript:validateForm(this);"/>
				</p>
				</div>
			</fieldset>
			
			 <fieldset>
                <legend>
       	 			${ui.message("conceptmanagementapps.managesnomedct.addrelationships.title")}
     			</legend>
     			<div id="showHideAddRelationships"  style="display: none">
				<p>
				<input type="button" name="addSnomedCTRelationships" id="addSnomedCTRelationshipsId" value="Start Task" onclick="javascript:validateForm(this);"/>
				</p>
				</div>
				<div id="showHideCancelAddRelationships" style="display: block">	
				<p>
				<input type="button" name="cancelAddRelationships" id="cancelAddRelationshipsId" value="Cancel" onclick="javascript:validateForm(this);"/>
				</p>
				</div>
			</fieldset>
			
			<input type="hidden" name="inputType" id="inputTypeId"/>

</form>

<script type="text/javascript">
window.onload=showHideValues();

 </script>