![preview](./preview.png)
Encrypting your drive with LUKS 🗝
=================================

April 11th

Abstract
--------

The Linux Unified Key Setup (LUKS) is a disk encryption specification
created by Clemens Fruhwirth in 2004 and was originally intended for
Linux. - Wikipedia

Sometimes you want to store some information securily and on a tight
leash. It may be your tax return or some high school love letters you
used to write. Where would you put it? Upload it somewhere and hope no
one gets it? Not exactly, the moment you upload it to some server, uncle
Bob or Sam have your piece of data on their machines. Surely, you can
encrypt every file and move it that way, fair enough. Can get a bit
cumbersome really quick.

Best way to keep your data safe is on a piece of paper with some ink
splattered on it. That\'s not very feasible for our needs. This is a
quick and dirty cheatsheet on how to use LUKS to full encrypt your flash
drive and keep it close to your heart. This is the same thing Ubunt does
when you tell it to encrypt your disk.

This is not an exhaustive guide or a full walkthrough of what LUKS is
and how it works. Just something to get youstarted. Possible cloud
solutions at the end

### Preparation

Backup all your data on your thumb drive, because we will need to erase
everything from it and rewrite the filesystem tables.

NOTE: `%` symbolizes the shell prompt.

### Setting it up

Let `/dev/sdb` be your USB drive. Be careful, we don\'t want to
accidentally wipe everything out on your hard drive. Follow the
instructions

``` {.bash org-language="sh"}
% cryptsetup --verbose --verify-passphrase luksFormat /dev/sdb
```

Now, let\'s open the drive with LUKS and write a filesystem to it. Enter
your new passphrase and name where to map it, `sdb` is just an example.
It maps to `/dev/mapper/sdb`

``` {.bash org-language="sh"}
% cryptsetup open /dev/sdb sdb
```

Now we got access to the drive, let\'s write your favorite filesystem,
I\'ll go with `ext4`

``` {.bash org-language="sh"}
% mkfs.ext4 /dev/mapper/sdb
```

### Mounting the drive

Let\'s write something to the drive. `/mnt/flash` is some mounting
target

``` {.bash org-language="sh"}
% mount /dev/mapper/sdb /mnt/flash
```

That\'s it, you have access now

``` {.bash org-language="sh"}
% cd /mnt/flash
% touch man
% echo cat > fish
```

After we\'re done, do the usual thing by unmounting it

``` {.bash org-language="sh"}
% umount /mnt/flash
```

### closeLUKS

Don\'t forget we have to close the LUKS drive and dump the encryption
details

``` {.bash org-language="sh"}
% cryptsetup close sdb
```

### Closing thoughts

Voilà! You now have fully encrypted and secure drive. Next time, just
don\'t forget the sequence of cryptopen, mount, ???, unmount, and
cryptclose. If you are looking for trusty cloud solutions, try out
[Keybase](https://keybase.io/). It\'s a great e2e service for all your
needs
