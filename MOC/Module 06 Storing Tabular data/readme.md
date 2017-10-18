## Module 6: Storing Tabular Data in Azure

1) Start creating Storage account. 
	* Local Redundent Storage (always 3 copies on the same DataCenterRegion )
	* Zone Redundent Storage ( same region multiple Zones  )
	* geo  Redundent Storage ( Cross regions )
	* ReadAccess geo Redundent Storage


Can get Access from VMS, on-promises, any programmering language. 

Storage Types: 
* Azure SQL Database (Relational DB)
* Table (NoSQL === JSON DB)
* BLOB  (vhd)
* Queue (scaling)
* Share (linux/windows filesystem access)


Tools available :
		* https://azure.microsoft.com/da-dk/features/storage-explorer/
		* extenstions from Visual Studio: search for Cloud Explorer  

```
	<storageAccountName> = ms532storage
	<SAS-Token>: (Shared Access Signature ==> token key ==> easy for REST API )

	* https://<storageAccountName>.blob.core.windows.net/<SAS-Token>
	* https://<storageAccountName>.file.core.windows.net/<SAS-Token>
	* https://<storageAccountName>.queue.core.windows.net/<SAS-Token>
	* https://<storageAccountName>.table.core.windows.net/<SAS-Token>
```



## Azure Table/NoSQL Storage

The name Table is key:value pairs (like JSON)

NoSQL examples from my web projects: 

* REST API with JSON (Screen Data)
* https://fullstack-ng4.itacademy.dk/ (CRUD)
* https://couchdb.itacademy.dk/ (Admin)

