public class FieloGRS_MultiMemberDispatcherCtrl {
	@AuraEnabled
    public static FieloPLT__Member__c setCurrentMember(FieloPLT__Member__c member) {
        FieloGRS.UserService.enableAdminPermission(true);
        update new User(
            Id = UserInfo.getUserId(),
            FieloGRS__MemberId__c = member.Id
        );
        FieloGRS.UserService.enableAdminPermission(false);
        return member;
    }
}