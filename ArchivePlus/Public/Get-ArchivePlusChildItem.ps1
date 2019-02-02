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
.PARAMETER WorkingPath
  Specifies the path where this function will create temporary folder(s) to extract the archive contents
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
    [string] $Path,

    [ValidateScript({Test-Path -Path $_ -PathType Container})]
    [Parameter(Mandatory=$false)]
    [string] $WorkingPath = $env:TEMP
  )

  Begin {
    if (-not(Test-Path -Path (Join-Path -Path $env:TEMP -ChildPath 'ArchivePlus'))) {
      [string] $rootPath = New-Item -Path (Join-Path -Path $env:TEMP -ChildPath 'ArchivePlus') -ItemType Directory -ErrorAction Stop
    }
    [string] $destinationPath = New-Item -Path (Join-Path $rootPath -ChildPath (Get-Date -Format FileDateTime)) -ItemType Directory -ErrorAction Stop
  }

  Process {

  }

  End {
    if (Test-Path -Path $destinationPath -PathType Container) {
      Write-Verbose "Removing working folder [$destinationPath]..."
      # Remove-Item -Path $destinationPath -Recurse
      Write-Verbose "Removing working folder [$destinationPath] complete."
    }
  }

}
