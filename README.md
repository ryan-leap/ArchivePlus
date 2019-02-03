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
Modeled after the built-it 'Get-ChildItem' cmdlet but specialized for archive files
```powershell
PS C:\> Compress-Archive -Path .\apples.txt,.\bananas.txt,.\lemons.txt,.\oranges.txt -DestinationPath .\fruit_mix_I.zip
PS C:\> Compress-Archive -Path .\lemons.txt,.\oranges.txt,.\pineapples.txt,.\strawberries.txt -DestinationPath .\fruit_mix_II.zip
PS C:\> Get-ArchivePlusChildItem -Path .\fruit_mix_I.zip

    Directory: C:\Users\ryanl\AppData\Local\Temp\ArchivePlus\20190203T1636550585

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         2/3/2019   4:23 PM             38 apples.txt
-a----         2/3/2019   4:24 PM             38 bananas.txt
-a----         2/3/2019   4:25 PM             38 lemons.txt
-a----         2/3/2019   4:24 PM             38 oranges.txt

PS C:\> Get-ArchivePlusChildItem -Path .\fruit_mix_II.zip

    Directory: C:\Users\ryanl\AppData\Local\Temp\ArchivePlus\20190203T1636551932

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         2/3/2019   4:25 PM             38 lemons.txt
-a----         2/3/2019   4:24 PM             38 oranges.txt
-a----         2/3/2019   4:25 PM             38 pineapples.txt
-a----         2/3/2019   4:24 PM             38 strawberries.txt

```
### Compare-ArchivePlus
Modeled after the built-in 'Compare-Object' cmdlet but specialized for archive files
```powershell
PS C:\> Compare-ArchivePlus -ReferenceArchivePath .\fruit_mix_I.zip -DifferenceArchivePath .\fruit_mix_II.zip

Name             Hash                                                             SideIndicator
----             ----                                                             -------------
pineapples.txt   4FD2A3C375B927F66136C90ECB4333AA4F8BFE0610A14368570033BEF11DDB38 =>
strawberries.txt 02155196DBF346CC9CAA0FA7D53F548F2A5FFA0B694E81A757F79A81BB03EA4C =>
apples.txt       D1AE1043BBE88B85C5F4707362205DEC02946ECEDF554829AC06FA175C8AB142 <=
bananas.txt      A15C57E921636CFEC19E350CBD42FE3579AA98C80233B65A41B40BB5400A18A2 <=

PS C:\> Compare-ArchivePlus -ReferenceArchivePath .\fruit_mix_I.zip -DifferenceArchivePath .\fruit_mix_II.zip -IncludeEqual -ExcludeDifferent

Name        Hash                                                             SideIndicator
----        ----                                                             -------------
lemons.txt  156BFD0E31A293C915FAB14D622666F9ABD7E11D3147200C3B618D77E2F4DF25 ==
oranges.txt 48FE555BCA60A1332D3E99BD6B8F21E47E7F33C9454FCBCD11CA11751F588796 ==
```
## Author(s)

* **Ryan Leap** - *Initial work*

## License

Licensed under the MIT License.  See [LICENSE](LICENSE.md) file for details.

## Acknowledgments

* Followed .psm1 PowerShell module template found here: https://github.com/mikefrobbins/Plaster
