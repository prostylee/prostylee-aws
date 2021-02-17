/* Amplify Params - DO NOT EDIT
	ENV
	REGION
Amplify Params - DO NOT EDIT */

exports.handler = function afterConfirmationTrigger(event, context, callback) {
  const AWS = require('aws-sdk');
  const cognitoISP = new AWS.CognitoIdentityServiceProvider({
    apiVersion: '2016-04-18'
  });

  // Add user to group
  const groupRequest = {
    GroupName: event.userPoolGroupName || "BUYER",
    UserPoolId: event.userPoolId,
    Username: event.userName
  };

  cognitoISP
    .adminAddUserToGroup(groupRequest)
    .promise()
    .then(() => callback(null, event))
    .catch(err => callback(err, event));

  // Auto Verification
  // const verificationRequest =  {
  //   UserAttributes: [
  //     {
  //       Name: "email_verified",
  //       Value: "true"
  //     },
  //     {
  //       Name: "phone_number_verified",
  //       Value: "true"
  //     }
  //   ],
  //   UserPoolId: event.userPoolId,
  //   Username: event.userName
  // }
  // cognitoISP.adminUpdateUserAttributes(verificationRequest, function(err, data) {
  //   if (err) {
  //     console.log(err);
  //   }
  //   callback(null, event);
  // });
};