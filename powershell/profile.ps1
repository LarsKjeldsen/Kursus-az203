$ProfileHOME =  "${Env:USERPROFILE}\Documents\WindowsPowerShell"

function sublime 	{ &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }

function c    		    { cls          }

function touch 		    { New-Item "$args" -ItemType File}

function profile-edit 	{ sublime $profile }
function profile-reload { . $profile }
function profile-dir 	{ cd "${Env:USERPROFILE}\Documents\WindowsPowerShell"  }

function rm             { rm -Recurse -Force $args} 

function ..             { cd .. $args} 

function f             { explorer.exe .} 
function finder        { explorer.exe $args} 

function  deploy 	   { npm run deploy}
function  gs 	   	   { git status}

function pshome { cd $env:USERPROFILE\Documents\WindowsPowerShell  ;  }



