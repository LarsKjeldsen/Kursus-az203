var azure = require('azure-sb');
 
function checkForMessages(sbService, queueName, callback) {
  sbService.receiveQueueMessage(queueName, { isPeekLock: true }, function (err, lockedMessage) {
    if (err) {
      if (err == 'No messages to receive') {
        console.log('No messages');
      } else {
        callback(err);
      }
    } else {
      callback(null, lockedMessage);
    }
  });
}
 
function processMessage(sbService, err, lockedMsg) {
  if (err) {
    console.log('Error on Rx: ', err);
  } else {
    console.log('Rx: ', lockedMsg);
    sbService.deleteMessage(lockedMsg, function(err2) {
      if (err2) {
        console.log('Failed to delete message: ', err2);
      } else {
        console.log('Deleted message.');
      }
    })
  }
}
 
var idx = 0;
function sendMessages(sbService, queueName) {
  var msg = 'Message from Nodejs to servicebus # ' + (++idx);
  sbService.sendQueueMessage(queueName, msg, function (err) {
   if (err) {
     console.log('Failed Tx: ', err);
   } else {
     console.log('Sent ' + msg);
   }
  });
}
 

/*
  get Azure connectionString
*/

var config      = require("./package.json")
var connStr     = config.azure.servicebus 
var queueName   = config.azure.queue_name

if (!connStr) throw new Error('Must provide valid connection string');

console.log('Connecting to queue ' + queueName);

var sbService = azure.createServiceBusService(connStr);

sbService.createQueueIfNotExists(queueName, function (err) {
  if (err) {
   console.log('Failed to create queue: ', err);
  } else {

   // checkForMessages every 5 seconds --> receive and delete messages.
   // setInterval(checkForMessages.bind(null, sbService, queueName, processMessage.bind(null, sbService)), 5000);


   // sendMessages every 15 seconds --> 4 messages every one minute
   setInterval(sendMessages.bind(null, sbService, queueName), 15000);

  }
});

