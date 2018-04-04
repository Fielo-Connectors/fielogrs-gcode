global class FieloGRS_LoginService implements gcode_glc.GalleryInterface {
    global String ssoInit(){
    	String result = 'fail';
    	try {
	        Id userId = UserInfo.getUserId();
	        User currentUser = [Select Id, FieloGRS__MemberId__c From User Where Id = :userId LIMIT 1];
	        result = FieloGRS.LoginService.login(currentUser.FieloGRS__MemberId__c) == 'success' ? null : 'fail';
        	return result;
    	} catch(Exception e) {
    		System.debug(e);
    	}
    	return result;
    }
}