$(document).ready(function(){

	// ==================================================
	// 		Tablesorter
	// ==================================================
  var url = $(location).attr('href');
	if (url.indexOf("relations") > 0 || 
		  url.indexOf("users") > 0 || 
		  url.indexOf("mpl_offers") > 0 || 
		  url.indexOf("inv_invoices") > 0 || 
		  url.indexOf("ins_insurances") > 0 || 
		  url.indexOf("tms_timesheets") > 0 || 
		  url.indexOf("dec_declarations") > 0 || 
		  url.indexOf("mob_cars") > 0 || 
		  url.indexOf("tms_projects") > 0)
		{
 			$("table").tablesorter(); 
	}
	
	// ==================================================
	// 		Company sameas checkboxes
	// ==================================================

	// Get current page and decide if code needs to be active for page
	url	= $(location).attr('href');
	if (url.indexOf("companies") > 0){
		// Get company visit address details and add them to post address
		$('#company_same').click(function() {
			$('#company_post_address').val($('#company_address1').val());
			$('#company_post_zipcode').val($('#company_zipcode').val());
			$('#company_post_city').val($('#company_city').val());
			$('#company_post_country').val($('#company_country').val());
		});   

		// Get billing address details and add them to post address
		$('#company_same2').click(function() {
			$('#company_billing_address').val($('#company_post_address').val());
			$('#company_billing_zipcode').val($('#company_post_zipcode').val());
			$('#company_billing_city').val($('#company_post_city').val());
			$('#company_billing_country').val($('#company_post_country').val());
		});   
	}

	// ==================================================
	// 		Address sameas checkboxes
	// ==================================================

	// Get current page and decide if code needs to be active for page
	url	= $(location).attr('href');
	if (url.indexOf("relations") > 0){
		// Get relation visit address details and add them to post address
		$('#relation_same').click(function() {
			$('#relation_post_address').val($('#relation_visit_address').val());
			$('#relation_post_zipcode').val($('#relation_visit_zipcode').val());
			$('#relation_post_city').val($('#relation_visit_city').val());
			$('#relation_post_country').val($('#relation_visit_country').val());
		});   

		// Get relation post address details and add them to billing address
		$('#relation_same2').click(function() {
			$('#relation_billing_address').val($('#relation_post_address').val());
			$('#relation_billing_zipcode').val($('#relation_post_zipcode').val());
			$('#relation_billing_city').val($('#relation_post_city').val());
			$('#relation_billing_country').val($('#relation_post_country').val());
		});   
	}
	
	// ==================================================
	// 		Master-slave listboxes
	// ==================================================

	// Get current page and decide if code needs to be active for page
	url	= $(location).attr('href');
	if (url.indexOf("relations") > 0 || url.indexOf("insurances") > 0 || url.indexOf("contacts") > 0){
		// Set id's of listboxes
		if (url.indexOf("relations") > 0){
			master = '#relation_industry';
			slave = '#relation_branch';
		}
		else if (url.indexOf("insurances") > 0){
			master = '#ins_insurance_branch';
			slave = '#ins_insurance_insurance_type';
		}
		else if (url.indexOf("contacts") > 0){
			master = '#contact_relation_id';
			slave = '#contact_has_boss';
		}

		// Get all values from slave listbox and then filter listbox
		trigger_filter(master, slave);
	}



	// ==================================================
	// 		Settings tabs
	// ==================================================

	// Get current page and decide if code needs to be active for page
	url	= $(location).attr('href');
	if (url.indexOf("users") > 0 || url.indexOf("insurances") > 0 || url.indexOf("categories/settings") > 0){
	
		// Activate tabs 
		var tabs = $('ul.settings_tabs');
		
		tabs.each(function(i) {
	
			// Get all tabs
			var tab = $(this).find('a');
	
			tab.click(function(e) {	
				//Get Location of tab's content
				var contentLocation = $(this).attr('a');
	
				e.preventDefault();
				
				//Make Tab Active
				tab.removeClass('active');
				$(this).addClass('active');
					
				//Show Tab Content & add active class
				$(contentLocation).show().addClass('active').siblings().hide().removeClass('active');
			});
		});
	}


	
	// ==================================================
	// 		Functions
	// ==================================================



	// Function to filter the slave listbox, based on the master listbox value
	function filter_slave(master, slave, slaves){
		// Get the selected master value
	  var master = $(master + ' :selected').text();
		var escaped_master = master.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
		var optgroup = "optgroup[label=" + escaped_master + "]";

		// Filter the slaves of the selected master
    var option_empty = "<option value=''></option>";
    var options = $(slaves).filter(optgroup).html();
    if (options){
    	$(slave).html(option_empty + options);
    }
    else {
    	$(slave).empty();
      $(slave).html(option_empty);
    }
	}

	// Function to trigger the filter for the slave listbox
	function trigger_filter(master, slave){
		// Get all slaves from slave listbox
		slaves = $(slave).html();
		if (slaves != null && slaves.indexOf("selected=\"selected\"") > 0){
			selected_slave = $(slave + ' :selected').text();
			selected_slave_id = $(slave + ' :selected').val();
			$(slave).empty();
			$(slave).html("<option selected='selected' value='" + selected_slave_id + "'>" + selected_slave + "</option>");
		}
		else {
			$(slave).empty();
		}
		
		// Filter slave listbox if master already has value
		master_html = $(master).html();
		if (master_html != null){
			if (master.indexOf("selected=\"selected\"") > 0){
				filter_slave(master, slave, slaves);
			}
		}

		// Filter the slave selectbox when a choice in the master listbox is made
		$(master).change(function() {
			filter_slave(master, slave, slaves);
		});
	}

	
});







