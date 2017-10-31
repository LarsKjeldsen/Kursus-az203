<#
	 Jalal Hejazi profile 2017
#>


$ProfileHOME =  "${Env:USERPROFILE}\Documents\WindowsPowerShell"


########################################################
# Helper Functions
function whoami 	{ (get-content env:\userdomain) + "\" + (get-content env:\username); }

function run-as-user  {  runas /user:test powershell  }

function sublime 	{ &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }
function s    		{ &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args      }

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


function IPv4Address {
     $IP   =   ipconfig | select-string -pattern "IPv4" -casesensitive 
     $IPv4 =   $IP.ToString().Replace("IPv4 Address. . . . . . . . . . . :","").Trim()  
     Write-host  $IPv4   
}

function IPv4Neighbor {
    $IP   =   ipconfig | select-string -pattern "IPv4" 
    $IPv4 =   $IP.ToString().Replace("IPv4 Address. . . . . . . . . . . :","").Trim()  

    $myOwnAddress =  $IPv4.Substring(0, $IPv4.Length - 3) 
    
    Get-NetNeighbor | 
        where { $_.IPAddress -like "$myOwnAddress*"  } | 
            select  @{ name='Neighbor IPv4Address'; expression={$_.IPAddress}  }
}


########################################################
# Prompt
function prompt
{
    $nextId = (get-history -count 1).Id + 1;
    $promptText = "[" + $nextId + "] $(Get-Date -format t) >";

    $wi = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $wp = new-object 'System.Security.Principal.WindowsPrincipal' $wi
        #hvis man er i en bestemt rolle
        if ( $wp.IsInRole("Administrators") -eq 1 )
        {   
            #prompt farve
            $color = "Red"
                #titel på det vindue man arbejder i - get-location delen viser altid den nuværende sti i vinduetitlen, fremfor at den står i commandlinjen
                $title = "**ADMIN** - " + (get-location).Path;
        }
        else
        {
            s#prompt farve
            $color = "Green"
                $title = (get-location).Path;
        }

    write-host $promptText -NoNewLine -ForegroundColor $color 
        #ændre $host sådan at man kan hente ting ud af sin profile
        $host.UI.RawUI.WindowTitle = $title;

    return " "
}
########################################################

########################################################
# Custom 'cd' command to maintain directory history
if( test-path alias:\cd ) { remove-item alias:\cd }
$GLOBAL:PWD = get-location;
$GLOBAL:CDHIST = [System.Collections.Arraylist]::Repeat($PWD, 1);
function cd {
	$cwd = get-location;
	$l = $GLOBAL:CDHIST.count;

	if ($args.length -eq 0) {
		set-location $HOME;
		$GLOBAL:PWD = get-location;
		$GLOBAL:CDHIST.Remove($GLOBAL:PWD);
		if ($GLOBAL:CDHIST[0] -ne $GLOBAL:PWD) {
			$GLOBAL:CDHIST.Insert(0,$GLOBAL:PWD);
		}
		$GLOBAL:PWD;
	}
	elseif ($args[0] -like "-[0-9]*") {
		$num = $args[0].Replace("-","");
		$GLOBAL:PWD = $GLOBAL:CDHIST[$num];
		set-location $GLOBAL:PWD;
		$GLOBAL:CDHIST.RemoveAt($num);
		$GLOBAL:CDHIST.Insert(0,$GLOBAL:PWD);
		$GLOBAL:PWD;
	}
	elseif ($args[0] -eq "-l") {
		for ($i = $l-1; $i -ge 0 ; $i--) {
			"{0,6}  {1}" -f $i, $GLOBAL:CDHIST[$i];
		}
	}
	elseif ($args[0] -eq "-") {
		if ($GLOBAL:CDHIST.count -gt 1) {
			$t = $CDHIST[0];
			$CDHIST[0] = $CDHIST[1];
			$CDHIST[1] = $t;
			set-location $GLOBAL:CDHIST[0];
			$GLOBAL:PWD = get-location;
		}
		$GLOBAL:PWD;
	}
	else {
		set-location "$args";
		$GLOBAL:PWD = pwd;
		for ($i = ($l - 1); $i -ge 0; $i--) {
			if ($GLOBAL:PWD -eq $CDHIST[$i]) {
				$GLOBAL:CDHIST.RemoveAt($i);
			}
		}

		$GLOBAL:CDHIST.Insert(0,$GLOBAL:PWD);
		$GLOBAL:PWD;
	}

	$GLOBAL:PWD = get-location;
}
########################################################


$host.PrivateData.ErrorBackgroundColor = 15

## Fjerne den gule farvet prompt 
## remove-module psreadline




####################################################################
# For remoting 

$PC2     = "192.168.1.102" 
$PC3     = "192.168.1.103"

$Group   = $PC2 , $PC3

# $login  = New-PSSession -Credential $Env:USERNAME -ComputerName $Group

####################################################################



# find the path where powershell lives
function pshome { cd $env:USERPROFILE\Documents\WindowsPowerShell  ;  }








