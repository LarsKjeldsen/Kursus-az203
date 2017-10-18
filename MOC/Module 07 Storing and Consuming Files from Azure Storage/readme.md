## module 07 Storing and Consuming Files from Azure Storage

BLOB (Binary Large Objects)

```
Storage Account > 
	Blob Containers [images/videos/vhds/logs] > (Security on container level)
		Blobs ( data ) >  (Security on data level)

```

## Page Blobs (Random Access Storage type, heavy updates )

optimized for vhds files (max. 1 TB)


## Block Blobs (heavy streaming )

anything else like multimedia files (max 200 GB)


## Blob REST API 

```
http [GET | POST |PUT | DELETE]	https://<account>.blob.windows.net/<container>/<blob>/?rest


<public access>
https://ms532storage.blob.core.windows.net/test/vejen%20til%20success.png


<private access> is for simple REST API access 

https://ms532storage.file.core.windows.net/test/vejen%20til%20success.png?sv=2015-04-05&si=test-15F2F2371FE&sr=s&sig=n8JPMuRd53fNzrLWdJYzUXVp4BM5KEISlS07GT0fArM%3D


```

