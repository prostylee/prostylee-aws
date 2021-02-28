/* Amplify Params - DO NOT EDIT
	ENV
	REGION
Amplify Params - DO NOT EDIT */

const axios = require('axios');
const AWS = require('aws-sdk');
const cognitoISP = new AWS.CognitoIdentityServiceProvider({
  apiVersion: '2016-04-18'
});

const DEFAULT_GROUP_NAME = "BUYER";

exports.handler = function afterConfirmationTrigger(event, context, callback) {
  console.log('afterConfirmationTrigger ' + JSON.stringify(event));
  
  addUserToGroup(event, context, callback);
  // autoVerifyUser(event, context, callback);
  signUpUserWithBackend(event, context, callback);
};

function signUpUserWithBackend(event, context, callback) {
  const req = {
    "username": event.userName,
    "userStatus": event.request.userAttributes["cognito:user_status"],
    "enabled": true,
    "groups": [DEFAULT_GROUP_NAME],
    "userInfo": event.request.userAttributes
  };
    
  axios
    .post('http://52.77.35.71:8090/api/v1/oauth/sign-up', req)
    .then((res) => {
      console.log(`statusCode: ${res.statusCode}`)
      console.log(res);
    })
    .catch((error) => {
      console.error(error)
    });
}

function addUserToGroup(event, context, callback) {

  // Add user to group
  const groupRequest = {
    GroupName: event.userPoolGroupName || DEFAULT_GROUP_NAME,
    UserPoolId: event.userPoolId,
    Username: event.userName
  };

  cognitoISP
    .adminAddUserToGroup(groupRequest)
    .promise()
    .then(() => callback(null, event))
    .catch(err => callback(err, event));
}

function autoVerifyUser(event, context, callback) {
  // Auto Verification
  const verificationRequest =  {
    UserAttributes: [
      {
        Name: "email_verified",
        Value: "true"
      },
      {
        Name: "phone_number_verified",
        Value: "true"
      }
    ],
    UserPoolId: event.userPoolId,
    Username: event.userName
  }
  cognitoISP.adminUpdateUserAttributes(verificationRequest, function(err, data) {
    if (err) {
      console.log(err);
    }
    callback(null, event);
  });
}