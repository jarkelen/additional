/*
* Skeleton V1.1
* Copyright 2011, Dave Gamache
* www.getskeleton.com
* Free to use under the MIT license.
* http://www.opensource.org/licenses/mit-license.php
* 8/17/2011
*/

$(document).ready(function() {
	// Get current page and decide if code needs to be active for page
	var url	= $(location).attr('href');
	if (url.indexOf("employees") > 0){

		// Activate tabs
		var tabs = $('ul.vertical_tabs_ajax');

		tabs.each(function(i) {

			//Get all tabs
			var tab = $(this).find('a');

			tab.click(function(e) {
				//Get Location of tab's content
				var contentLocation = $(this).attr('href');

				//Let go if not a hashed one
				if(contentLocation.charAt(0)=="#") {
					e.preventDefault();

					//Make Tab Active
					tab.removeClass('active');
					$(this).addClass('active');

					//Show Tab Content & add active class
					$(contentLocation).show().addClass('active').siblings().hide().removeClass('active');

				}
			});
		});
	}
});
