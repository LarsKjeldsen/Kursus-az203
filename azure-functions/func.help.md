
                  %%%%%%
                 %%%%%%
            @   %%%%%%    @
          @@   %%%%%%      @@
       @@@    %%%%%%%%%%%    @@@
     @@      %%%%%%%%%%        @@
       @@         %%%%       @@
         @@      %%%       @@
           @@    %%      @@
                %%
                %

Azure Functions Core Tools (1.0.4)
Function Runtime Version: 1.0.11232.0
Usage: func [context] [context] <action> [-/--options]

Contexts:
azure      Commands to log in to Azure and manage resources
function   Commands for creating and running functions locally
host       Commands for running the Functions host locally
settings   Commands for managing environment settings for the local Functions host
templates  Commands for listing available function templates

Actions: 
new     Create a new function from a template. Aliases: new, create
    --language [-l] Template programming language, such as C#, F#, JavaScript, etc.
    --template [-t] Template name
    --name [-n]     Function name

init    Create a new Function App in the current folder. Initializes git repo.  
    --no-source-control [-n] Skip running git init. Default is false.

run     Run a function directly  
    <FunctionName> Function to run
    --timeout [-t]   Time (in seconds) to wait until local Functions host is ready
    --content [-c]   content to pass to the function, such as HTTP body
    --file [-f]      File name to use as content
    --debug [-d]     Attach a debugger to the host process before running the function
    --no-interactive Don't prompt or expect any stdin.


