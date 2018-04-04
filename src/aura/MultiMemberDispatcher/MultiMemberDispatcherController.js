({
	updateMember: function(component, event, helper){
        console.log('updateMember');
        var newMember = event.getParam('member');
        // Create the action
        var action = component.get("c.setCurrentMember");
        
        console.log(newMember);
        
        if (newMember) {
	        action.setParams({ member : newMember });            
        }
    
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            console.log(component.isValid());
            var member = response.getReturnValue();
            if (component.isValid() && state === "SUCCESS") {
                var refreshView = false;
                if(component.get('v.member')!=null) {
                    refreshView = true;
                }
                component.set('v.member', member);
                if (refreshView) {
                    $A.get("e.force:refreshView").fire();
                }
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
    
        // Send action off to be executed
        $A.enqueueAction(action);
	}
})