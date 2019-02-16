# ArchivePlus
ArchivePlus is a PowerShell module which supplements the native ```Compress-Archive``` and ```Expand-Archive``` cmdlets.  Functions provided include ```Get-ArchivePlusChildItem``` which allows you to list the contents of a zip file and ```Compare-ArchivePlus``` which enables you to perform content (file-by-file hash-based) comparsions between two zip files.

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
Modeled after the built-in ```Get-ChildItem``` cmdlet but specialized for archive files
```powershell
PS C:\> Compress-Archive -Path .\apples.txt,.\oranges.txt,.\lemons.txt -DestinationPath .\fruit_mix_I.zip
PS C:\> Compress-Archive -Path .\lemons.txt,.\bananas.txt,.\strawberries.txt -DestinationPath .\fruit_mix_II.zip
PS C:\> Get-ArchivePlusChildItem -Path .\fruit_mix_I.zip

    Directory: C:\Users\ryanl\AppData\Local\Temp\ArchivePlus\20190214T2100082230

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         2/3/2019   4:23 PM             38 apples.txt
-a----         2/3/2019   4:25 PM             38 lemons.txt
-a----         2/3/2019   4:24 PM             38 oranges.txt

PS C:\> Get-ArchivePlusChildItem -Path .\fruit_mix_II.zip

    Directory: C:\Users\ryanl\AppData\Local\Temp\ArchivePlus\20190214T2100134692

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         2/3/2019   4:24 PM             38 bananas.txt
-a----         2/3/2019   4:25 PM             38 lemons.txt
-a----         2/3/2019   4:24 PM             38 strawberries.txt

PS C:\> # Pipeline Support
PS C:\> 'c:\food\fruit_mix_I.zip','c:\food\fruit_mix_II.zip' | Get-ArchivePlusChildItem

    Directory: C:\Users\ryanl\AppData\Local\Temp\ArchivePlus\20190216T1503048865

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         2/3/2019   4:23 PM             38 apples.txt
-a----         2/3/2019   4:25 PM             38 lemons.txt
-a----         2/3/2019   4:24 PM             38 oranges.txt

    Directory: C:\Users\ryanl\AppData\Local\Temp\ArchivePlus\20190216T1503049426

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         2/3/2019   4:24 PM             38 bananas.txt
-a----         2/3/2019   4:25 PM             38 lemons.txt
-a----         2/3/2019   4:24 PM             38 strawberries.txt
```
### Compare-ArchivePlus
Modeled after the built-in ```Compare-Object``` cmdlet but specialized for archive files
```powershell
PS C:\> Compare-ArchivePlus -ReferenceArchivePath .\fruit_mix_I.zip -DifferenceArchivePath .\fruit_mix_II.zip

Name             Hash                             SideIndicator
----             ----                             -------------
bananas.txt      1487064BFA051F0B591740AC993BB639 =>
strawberries.txt A36A3240037C8E29653531F7D32FCC56 =>
apples.txt       30F61BE97022CA6D50D0F24933D256A8 <=
oranges.txt      AB542B90DE97A29ACC04FFDE5D00A3A3 <=

PS C:\> Compare-ArchivePlus -ReferenceArchivePath .\fruit_mix_I.zip -DifferenceArchivePath .\fruit_mix_II.zip -IncludeEqual -ExcludeDifferent

Name       Hash                             SideIndicator
----       ----                             -------------
lemons.txt D4BF34009B33C1A940EFFDB7A2CBC60B ==
```
## Author(s)

* **Ryan Leap** - *Initial work*

## License

Licensed under the MIT License.  See [LICENSE](LICENSE.md) file for details.

## Acknowledgments

* Followed .psm1 PowerShell module template found here: https://github.com/mikefrobbins/Plaster
