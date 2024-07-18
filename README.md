# QuickBMS scripts for Shiro Games

This repository contains supplementary materials for games by Shiro.

## Usage

1. Download [QuickBMS](https://aluigi.altervista.org/quickbms.htm) of 0.12 version or later (will not work on anything lower than 0.11, but no guarantees it will keep working on later versions, just saying)
2. Clone this repo or download any specific `*.bms` file
3. Copy in one location on your fastest drive QuickBMS, BMS script and game's package file, create two sub-directories there `extracted` and `repak`
4. To unpack:
	1. Run QuickBMS binary `quickbms_4gb_files.exe` (from Windows explorer or CLI if you nerd), provide it path to script, arhive and then to output directory (`extracted`)
	2. Wait for it to cook
	3. ?!
	4. PROFIT!
5. (OPTIONAL) Investigate, read, view and enjoy extracted materials
6. (OPTIONAL) If you need to change something - change
7. To pack back:
	0. Backup original archive
	1. It is not safe and easy to pack back if you did chages that lead to increase of size of original file
	2. Safest and easiest is to change in place, i.e. recoloring textures, since result will occupy the same memory space
	3. If you only changed a few files put them in `repak` directory, and use it next step, otherwise use whole `extracted` dir
	4. Run QuickBMS batch script `reimport_4gb_files.bat`, provide path to BMS script, archive to change and input directory (see above)
	5. ?!
	6. PROFIT
	7. Always try to test by copy-pasting changed archive back to the game directory and running game. If it crashes, roll back
	8. If this method doesnt work - you are doomed and no reimport2 (`-r -r`) or reimport3 (`-r -r -r`) hack can help you
	9. I can do it manually, and will try to write guide one day, stay tuned

## BMS Scripts
### Source

All started from QBMS script for Evoland 2 (another Shiro's game) by `Allen` whoever is this great man.
Source where i got this file is long forgotten. All working links are welcome in PR.

### Northgard
I coninued updating this script for Northgard game and now after it was significantly improved, can publish it (to some degree) my work.
Of course original creator not to be forgotten.

Supported formats:
- `RES.PAK` (script: `./northgard_res_pak.bms`) - script to (un/)pack file with most of the game's data, including textures, models, sounds, and, most notably, data.cdb (`steamapps\common\Northgard\res.pak`)

Unsupported formats:
- editor resources (`steamapps\common\Northgard\NGEditor\resources.pak`, `nw_100_percent.pak` and `nw_200_percent.pak`) - all three have ID string of `05 00 00 00 01 00 00 00` and probably are compressed.

Additional info is always welcome.

# Copyleft
Author: Sanctus-Susanin, original by: Allen.

You can do with this codebase whatever your want IF you preserve names of all previous authors and link to this repository.