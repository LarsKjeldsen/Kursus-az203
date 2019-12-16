
## How to build software using docker

```powershell   
dotnet --version
cd c:\dev\ipcheck\
dotnet new console
code .
dotnet run
docker build --tag ipcheck .
docker images
docker container run ipcheck
```