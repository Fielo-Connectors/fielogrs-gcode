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
	},
    refreshMember: function(component, event, helper){
        console.log('refreshMember');
        var newMember = event.getParam('member');
        component.set('v.member', newMember);
        $A.get("e.force:refreshView").fire();
	},
    doInit: function(component, event, helper){
        console.log('calling doInit');        
        $A.createComponent(
            "gcode_glc:Gallery",
            {                
                "grsproduct": "Storefront",
                "appid": "Storefront_Fielo",
                "ssoInitClass": "LoginService",
                "routeOption": "Gallery"
            },
            function(newButton, status, errorMessage){
                console.log('adding...');
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    console.log(component);
                    var body = component.get("v.body");
                    body.push(newButton);
                    console.log(newButton);
                    component.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }
        );
    }
})