<#!
.SYNOPSIS
	Function to kill active sessions to Nav database
.DESCRIPTION
	Function to kill SQL connections. Inspired by script from  Bryan Christian
.NOTES
	File Name: .PS1
	Author: Mathew Ealy
	Requires Powershell 5.0

.PARAMETERS

	-ServerInfo
The Name of the SQL server	
		
		Required?	True
		Position?                    0
		Default value
		Accept pipeline input?	false
		Accept wildcard characters?	false
	
	-Database
The database name

		Required?	True
		Position?                    1
		Default value
		Accept pipeline input?	false
		Accept wildcard characters?	True

.LINK
	https://github.com/MEaly58
#>
#Requires -RunAsAdministrator

function Kill-Connections 
{
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [String] $ServerInfo,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $Database
    )
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
    try 
    {
        $sqlServer = new-object ("Microsoft.SqlServer.Management.Smo.Server") $ServerInfo
        $sqlServer.KillAllProcesses($Database)
    }
    catch
    {
        Write-Error "Failed to kill connections to $database on $sqlserver.  Either database not found or cannot connect to server."
    }
    Write-Output "Active Connections to $database on $sqlserver terminated"
}
