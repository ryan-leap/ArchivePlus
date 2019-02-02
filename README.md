# ArchivePlus
ArchivePlus is a PowerShell module which supplements the native Compress-Archive and Expand-Archive cmdlets

## Installing
#### Download from GitHub repository

* Download the repository from https://github.com/ryan-leap/ArchivePlus
* Unblock the zip file ((on Windows) Right Click -> Properties -> [v/] Unblock)
* Extract the ArchivePlus folder to a module path (e.g. $home\Documents\WindowsPowerShell\Modules)

## Usage
```powershell
# Import the module
Import-Module -Name ArchivePlus

# Get the available commands
Get-Command -Module ArchivePlus

# Get help
Get-Help ArchivePlus
```

## Examples
### Get-ArchivePlusChildItem
```powershell
# Gets the items in the archive specified
Get-ArchivePlusChildItem -Path "$env:temp\classical_mix.zip"

# Gets the items and child items in the archive specified
Get-ArchivePlusChildItem -Path "$env:temp\classical_mix.zip" -Recurse
```
## Author(s)

* **Ryan Leap** - *Initial work*

## License

Licensed under the MIT License.  See [LICENSE](LICENSE.md) file for details.

## Acknowledgments

* Followed .psm1 PowerShell module template found here: https://github.com/mikefrobbins/Plaster
