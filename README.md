# macOS openSUSE

Install an openSUSE VM on macOS using [xhyve].
Based on [https://github.com/rimusz-lab/xhyve-ubuntu]:https://github.com/rimusz-lab/xhyve-ubuntu

## Download openSUSE

15.0 Leap tested

## Install xhyve

```
brew install xhyve
```

## Get booting kernel

```
sudo ./prepare.sh ~/Downloads/downloaded-install-media-path.iso
```

## Create storage and boot to ISO

```
sudo ./install.sh ~/Downloads/downloaded-install-media-path.iso
```

After booting, install openSUSE just like you normally would.

Pro tip: Don't resize your terminal while you're going through the installer.


## TODO

copy kernel to the host boot folder

## Start your new OS

```
sudo ./start.sh
```

## First steps

Here are some things you should probably do after logging in.

```
echo "export TERM=xterm-256color" >> $HOME/.bashrc
vncserver
```

`xterm` is important because it'll install the `resize` command. You'll need to
manually resize the terminal dimensions because we're using a serial TTY or
something.

The default terminal is `vt220`, which doesn't have colors by default. We're
probably more used to `xterm`.

Everytime you resize your terminal, you need to run `resize`. Otherwise, your
output will get jacked.

## Reboot

That's it! You don't really need to reboot, but here's what that looks like.

```
jaime@xhyve:~$ sudo poweroff
[  636.675689] reboot: System halted
jaime@mac:~$ sudo ./start.sh
```

## Links

[xhyve-ubuntu]:https://github.com/rimusz-lab/xhyve-ubuntu
[xhyve]:https://github.com/machyve/xhyve
[bhyve_uefi]:https://people.freebsd.org/%7Egrehan/bhyve_uefi/

