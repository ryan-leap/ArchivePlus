function Get-ArchivePlusChildItem {
<#
.SYNOPSIS
  Gets the items and child items in the archive specified.
.DESCRIPTION
  Gets the items and child items in the archive specified. Extracts the archive to a temporary
  location and runs Get-ChildItem against the extracted contents to provide results.
.PARAMETER Path
  Specifies the path to an archive (zip) file.
.PARAMETER Name
  Gets only the names of the items in the archive.
.PARAMETER Recurse
  Gets the items in the specified archive and in all child items of the expanded archive.
.PARAMETER Depth
  Enables you to control the depth of recursion.
.OUTPUTS
  System.Object
.OUTPUTS
  System.String
.NOTES
   Author: Ryan Leap
   Email: ryan.leap@gmail.com
#>

  [CmdletBinding()]
  [OutputType([System.Object])]
  [OutputType([System.String])]
  Param (
    [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string] $Path
  )

  Begin {}

  Process {

  }

  End {}

}
