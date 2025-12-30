# ANAVI Word Clock

Open source 8x8 NeoPixel word clock.

# Case

The case is designed using the free and open-source tool OpenSCAD and requires a custom stencil font.

## Installing the Stencil Font on Ubuntu

Follow the steps below to install the Arial stencil font on an Ubuntu Linux distribution:

*  Copy the font file:

```
sudo mkdir /usr/share/fonts/anavi
sudo cp Arial-BoldStencila.ttf /usr/share/fonts/anavi
sudo chmod -R --reference=/usr/share/fonts/opentype /usr/share/fonts/anavi
```

NOTE: Root privileges are required to install fonts system-wide.

* Update the font cache:

```
sudo fc-cache -fv
```

* Verify the installation:

```
fc-list | grep -i arial
```

The font should appear in the output list. The font name reported by fc-list must be used exactly in the OpenSCAD text() function.

* Launch OpenSCAD

Restart OpenSCAD if it was already running so it can detect the newly installed font.

# License

The project is released under the [Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/).

Note: This is a human-readable summary of (and not a substitute for) the [license](https://creativecommons.org/licenses/by-sa/4.0/legalcode).

You are free to:

Share — copy and redistribute the material in any medium or format Adapt — remix, transform, and build upon the material for any purpose, even commercially. The licensor cannot revoke these freedoms as long as you follow the license terms. Under the following terms:

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits. Notices:

You do not have to comply with the license for elements of the material in the public domain or where your use is permitted by an applicable exception or limitation. No warranties are given. The license may not give you all of the permissions necessary for your intended use. For example, other rights such as publicity, privacy, or moral rights may limit how you use the material.

You will have to provide a link to the original creator of the project http://www.anavi.technology on any documentation or website.

Credit can be attributed through a link to the creator website: http://www.anavi.technology
