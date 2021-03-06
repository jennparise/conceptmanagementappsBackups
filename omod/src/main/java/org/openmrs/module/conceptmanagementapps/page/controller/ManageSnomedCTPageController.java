package org.openmrs.module.conceptmanagementapps.page.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.conceptmanagementapps.api.ConceptManagementAppsService;
import org.openmrs.module.conceptmanagementapps.api.ManageSnomedCTProcess;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.page.PageModel;
import org.openmrs.ui.framework.page.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ManageSnomedCTPageController {
	
	protected final Log log = LogFactory.getLog(this.getClass());
	
	public void post(@RequestParam("snomedDirectoryLocation") String snomedFileDirectoryLocation, UiUtils ui,
	                 PageRequest pageRequest, HttpServletRequest request, PageModel model) {
		
		String inputType = request.getParameter("inputType");
		
		ConceptManagementAppsService conceptManagementAppsService = (ConceptManagementAppsService) Context
		        .getService(ConceptManagementAppsService.class);
		
		if (StringUtils.equalsIgnoreCase("refresh", inputType)) {
			
			if (conceptManagementAppsService.getCancelManageSnomedCTProcess()) {
				
				setValuesForNoProcessRunning(model);
				
			} else {
				
				setValuesForCurrentProcess(model, conceptManagementAppsService);
			}
			
		} else if (StringUtils.equalsIgnoreCase("cancel", inputType)) {
			
			conceptManagementAppsService.setCancelManageSnomedCTProcess(true);
			
			setValuesForNoProcessRunning(model);
			
		} else {
			
			conceptManagementAppsService.setCancelManageSnomedCTProcess(false);
			conceptManagementAppsService.startManageSnomedCTProcess(inputType, snomedFileDirectoryLocation);
			conceptManagementAppsService.setCancelManageSnomedCTProcess(true);
			
			setValuesForNoProcessRunning(model);
			
		}
		
	}
	
	public void get(UiSessionContext sessionContext, PageModel model) throws Exception {
		
		ConceptManagementAppsService conceptManagementAppsService = (ConceptManagementAppsService) Context
		        .getService(ConceptManagementAppsService.class);
		
		if (conceptManagementAppsService.getCancelManageSnomedCTProcess()) {
			
			setValuesForNoProcessRunning(model);
			
		} else {
			
			if (conceptManagementAppsService.getCurrentSnomedCTProcess() != null) {
				
				setValuesForCurrentProcess(model, conceptManagementAppsService);
				
			} else {
				
				setValuesForNoProcessRunning(model);
				
			}
		}
	}
	
	private void setValuesForNoProcessRunning(PageModel model) {
		
		model.addAttribute("processRunning", "none");
		model.addAttribute("processStatus", "");
		model.addAttribute("dirLocation", "");
		model.addAttribute("processPercentComplete", "");
	}
	
	private void setValuesForCurrentProcess(PageModel model, ConceptManagementAppsService conceptManagementAppsService) {
		
		ManageSnomedCTProcess currentProcess = conceptManagementAppsService.getCurrentSnomedCTProcess();
		
		int numToProcess = currentProcess.getCurrentManageSnomedCTProcessNumToProcess();
		int numProcessed = currentProcess.getCurrentManageSnomedCTProcessNumProcessed();
		float percentComplete = 0;
		
		if (numToProcess > 0) {
			percentComplete = (float) numProcessed / (float) numToProcess;
			percentComplete = percentComplete * 100;
		}
		
		model.addAttribute("processStatus", "process running: " + currentProcess.getCurrentManageSnomedCTProcessName()
		        + " since " + currentProcess.getCurrentManageSnomedCTProcessStartTime());
		model.addAttribute("processRunning", currentProcess.getCurrentManageSnomedCTProcessName());
		model.addAttribute("dirLocation", currentProcess.getCurrentManageSnomedCTProcessDirectoryLocation());
		model.addAttribute("processPercentComplete", Math.round(percentComplete) + "% Complete Processing " + numProcessed
		        + " of " + numToProcess);
	}
}
