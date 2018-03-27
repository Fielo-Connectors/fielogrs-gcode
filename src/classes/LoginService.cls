global class LoginService implements gcode_glc.GalleryInterface {
    global String ssoInit(){
        Id userId = UserInfo.getUserId();
        String domain = URL.getSalesforceBaseUrl() + Site.getPathPrefix();
        FieloPLT__Member__c member = [Select Id From FieloPLT__Member__c Where FieloPLT__User__c = :userId ORDER BY CreatedDate LIMIT 1];
        return FieloGRS.LoginService.login(member.Id) == 'success' ? null : 'fail';
    }
}