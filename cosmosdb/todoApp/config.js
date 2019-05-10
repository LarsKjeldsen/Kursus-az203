var config = {}

config.port = process.env.PORT || '3000'

// Azure CosmosDB --> account 
config.host = process.env.HOST || "https://cosmos2020.documents.azure.com:443/"

// Azure cosmodDB --> keys --> Read/Write keys --> PRIMARY KEY
config.authKey = process.env.AUTH_KEY || "WLj1uXajGxXIQd0l4l2dkNyGnX6dErD8Bbrx0hExr2Sq9GpRt6W6vMSgE5iJKqjXWn0ojlGeGD03MIJj7aPIbQ=="

config.databaseId = "ToDoList"
config.collectionId = "Items"


module.exports = config;