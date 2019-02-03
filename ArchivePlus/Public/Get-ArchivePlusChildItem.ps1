# Compress-Archive and Expand-Archive cmdlets were introduced with PowerShell v5
#Requires -Version 5

function Get-ArchivePlusChildItem {
<#
.SYNOPSIS
  Gets the items and child items in the archive specified.
.DESCRIPTION
  Gets the items and child items in the archive specified. Extracts the archive to a temporary
  location and runs Get-ChildItem against the extracted contents to provide results.  The archive
  file item is included as an additional property on the items returned.
.PARAMETER Path
  Specifies the path to the archive file.
.PARAMETER Name
  Gets only the names of the items in the archive file.
.PARAMETER Recurse
  Gets the items in the specified archive and in all child items of the expanded archive.
.PARAMETER Depth
  Enables you to control the depth of recursion.
.PARAMETER FileHash
  Adds a file hash property to each file item in the archive file.
.PARAMETER Algorithm
  Specifies the cryptographic hash function to use for computing the hash value of the contents of the specified file.
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

  [CmdletBinding(DefaultParameterSetName='Standard')]
  [OutputType([System.Object])]
  [OutputType([System.String])]
  Param (
    [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string] $Path,

    [switch] $Recurse,

    [ValidateScript({Try { [uint32] $_ | Out-Null; $true } catch { $false }})]
    [Parameter(Mandatory=$false)]
    [string] $Depth,

    [switch] $Name,
    
    [Parameter(ParameterSetName='AddHash',Mandatory=$false)] 
    [switch] $FileHash,

    [Parameter(ParameterSetName='AddHash',Mandatory=$false)] 
    [ValidateSet('SHA1','SHA256','SHA384','SHA512','MD5')]
    [string] $Algorithm = 'SHA256',

    [ValidateScript({Test-Path -Path $_ -PathType Container})]
    [Parameter(Mandatory=$false)]
    [string] $WorkingPath = $env:TEMP
  )

  Begin {

    $archivePath = Get-ChildItem -Path $Path
    $rootPath = Join-Path -Path $env:TEMP -ChildPath 'ArchivePlus'
    if (-not(Test-Path -Path $rootPath -PathType Container)) {
      Write-Verbose "Creating root working folder [$rootPath]..."
      $rootPath = New-Item -Path $rootPath -ItemType Directory -ErrorAction Stop
      Write-Verbose "Creating root working folder [$($rootPath.FullName)] complete."
    }
    $destinationPath = Join-Path $rootPath -ChildPath (Get-Date -Format FileDateTime)
    Write-Verbose "Creating archive working folder [$destinationPath]..."
    $destinationPath = New-Item -Path $destinationPath -ItemType Directory -ErrorAction Stop
    Write-Verbose "Creating archive working folder [$($destinationPath.FullName)] complete."

  }

  Process {

    Expand-Archive -Path $Path -DestinationPath $destinationPath
    [hashtable] $childItemParms = [ordered] @{
      'Path'     = $destinationPath
      'Name'     = if ($Name) { $true } else { $false }
      'Recurse'  = if ($Recurse) { $true } else { $false }
    }
    if (-not([string]::IsNullOrEmpty($Depth))) {
      $childItemParms.Add('Depth', [uint32] $Depth)
    }
    Write-Debug "Parameters for 'Get-ChildItem': $(New-Object -TypeName PSObject -Property $childItemParms)"
    if ($Name) {
      Get-ChildItem @childItemParms
    }
    else {
      foreach ($item in (Get-ChildItem @childItemParms)) {
        if (($FileHash) -and (-not($item.PSIsContainer))) {
          $fileHashInfo = Get-FileHash -Path $item -Algorithm $Algorithm
          Add-Member -InputObject $item -MemberType NoteProperty -Name 'Hash' -Value $fileHashInfo.Hash
          Add-Member -InputObject $item -MemberType NoteProperty -Name 'Algorithm' -Value $fileHashInfo.Algorithm
        }
        Add-Member -InputObject $item -MemberType NoteProperty -Name 'RelativeName' -Value ($item.FullName.Substring($destinationPath.FullName.Length + 1))
        Add-Member -InputObject $item -MemberType NoteProperty -Name 'ArchiveFileInfo' -Value $archivePath -PassThru
      }
    }

  }

  End {

    if (Test-Path -Path $destinationPath -PathType Container) {
      Write-Verbose "Removing archive working folder [$destinationPath]..."
      Remove-Item -Path $destinationPath -Recurse -Confirm:$false
      Write-Verbose "Removing archive working folder [$destinationPath] complete."
    }
    if ((Test-Path -Path $rootPath -PathType Container) -and ($null -eq (Get-ChildItem -Path $rootPath))){
      Write-Verbose "Removing root working folder [$rootPath]..."
      Remove-Item -Path $rootPath -Confirm:$false
      Write-Verbose "Removing root working folder [$rootPath] complete."
    }

  }

}
