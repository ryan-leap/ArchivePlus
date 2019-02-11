# Compress-Archive and Expand-Archive cmdlets were introduced with PowerShell v5
#Requires -Version 5

function Compare-ArchivePlus {
<#
.SYNOPSIS
  Compares two archive files.
.DESCRIPTION
  Compares two archive files.  One is the "reference archive" and the other is the "difference archive".  Modeled
  after the built-in 'Compare-Object' cmdlet, but specialized for archive file comparison.
.PARAMETER ReferenceArchivePath
  Specifies the path to the archive file used as a reference for comparison.
.PARAMETER DifferenceArchivePath
  Specifies the path to the archive file to be compared to the reference archive.
.PARAMETER Property
  Specifies an array of properties of the reference and difference archive contents (files/folders) to compare.
.PARAMETER ExcludeDifferent
  Indicates that this cmdlet displays only the characteristics of compared files that are equal.
.PARAMETER IncludeEqual
  Indicates that this cmdlet displays characteristics of compared files that are equal. By default, only characteristics
  that differ between the reference and difference archive files are displayed.
.PARAMETER PassThru
  Returns an object representing the item with which you are working.
.EXAMPLE
  Compare-ArchivePlus -ReferenceArchivePath .\fruit_mix_I.zip -DifferenceArchivePath .\fruit_mix_II.zip
  Compares the reference and difference archive files
.EXAMPLE
  Compare-ArchivePlus -ReferenceArchivePath .\fruit_mix_I.zip -DifferenceArchivePath .\fruit_mix_II.zip  -IncludeEqual -ExcludeDifferent
  Compares the reference and difference archive files identifying items which are equal
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
    [string] $DifferenceArchivePath,

    [Parameter(Mandatory=$false)]
    [Object[]] $Property = @('Name','Hash'),
    
    [switch] $ExcludeDifferent,

    [switch] $IncludeEqual,

    [switch] $PassThru
  )

  Begin {}

  Process {
    $compareParms = @{
      'ReferenceObject'  = (Get-ArchivePlusChildItem -Path $ReferenceArchivePath -Recurse -FileHash -Algorithm MD5)
      'DifferenceObject' = (Get-ArchivePlusChildItem -Path $DifferenceArchivePath -Recurse -FileHash -Algorithm MD5)
      'ExcludeDifferent' = if ($ExcludeDifferent) { $true } else { $false }
      'IncludeEqual'     = if ($IncludeEqual) { $true } else { $false }
      'PassThru'         = if ($PassThru) { $true } else { $false }
      'Property'         = $Property
    }
    Write-Debug "Parameters for 'Compare-Object': $(New-Object -TypeName PSObject -Property $compareParms)"
    Compare-Object @compareParms
  }

  End {}

}
