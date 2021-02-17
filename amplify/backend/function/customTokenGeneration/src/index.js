/* Amplify Params - DO NOT EDIT
	ENV
	REGION
Amplify Params - DO NOT EDIT */

exports.handler = function beforeTokenGenerationTrigger(event, context, callback) {
    // console.log('Request ' + JSON.stringify(event.request));
    event.response = {
        claimsOverrideDetails: {
            claimsToAddOrOverride: {
                ogranizationId: 1,
                ogranizationName: "Adidas"
            },
            // claimsToSuppress: ["cognito:groups"],
            // "groupOverrideDetails": {
            //     "groupsToOverride": ["DEFAULT_GROUP1"]
            // }
        }
    };

    // Return to Amazon Cognito
    callback(null, event);
};