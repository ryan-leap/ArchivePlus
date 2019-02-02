# Compress-Archive and Expand-Archive cmdlets were introduced with PowerShell v5
#Requires -Version 5

function Compare-ArchivePlus {
<#
.SYNOPSIS
  Compares two archive files.
.DESCRIPTION
  Compares two archive files - one is the "reference archive" and the other is the "difference archive".  Modeled
  after the built-in 'Compare-Object' cmdlet, but specialized for archive file comparison.
.PARAMETER ReferenceArchivePath
  Specifies the path to the archive file used as a reference for comparison.
.PARAMETER DifferenceArchivePath
  Specifies the path to the archive file to be compared to the reference archive.
.OUTPUTS
  System.Object
.NOTES
   Author: Ryan Leap
   Email: ryan.leap@gmail.com
#>

  [CmdletBinding()]
  [OutputType([System.Object])]
  Param (
    [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
    [Parameter(Mandatory=$true)]
    [string] $ReferenceArchivePath,

    [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
    [Parameter(Mandatory=$true)]
    [string] $DifferenceArchivePath
  )

  Begin {}

  Process {
    $compareParms = @{
      'ReferenceObject'  = (Get-ArchivePlusChildItem -Path $ReferenceArchivePath -Recurse -FileHash)
      'DifferenceObject' = (Get-ArchivePlusChildItem -Path $DifferenceArchivePath -Recurse -FileHash)
      'Property'         = 'Name','Hash'
    }
    Compare-Object @compareParms
  }

  End {}

}
