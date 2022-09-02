- README.md

```Leaving installer default with essentials.
Copy config(s) into place and modify if you wish to use them.

- spectrwm --
  NOTE: Update custom spectrwm_post_run.sh with your requirements --
  cp -Rvp ~/.config/spectrwm/spectrwm.conf ~/.config/spectrwm/spectrwm.conf.orig
  cp -Rvp .config/spectrwm/spectrwm.conf ~/.config/spectrwm/
  cp -Rvp .config/spectrwm/spectrwm_post_run.sh ~/.config/spectrwm/
  cp -Rvp .config/spectrwm/dmemu_custom ~/bin/

- alacritty --
  cp -Rvp .config/alacritty/alacritty.yml ~/.config/alacritty/

- Xresources --
  cp .Xresources ~/

- gtk css --
  NOTE: gtk theming uses; Arc-Dark and vimix-icons --
  cp -Rvp .gtkrc-2.0 ~/
  cp -Rvp .config/gtk-2.0 ~/.config/
  cp -Rvp .config/gtk-3.0 ~/.config/
```
