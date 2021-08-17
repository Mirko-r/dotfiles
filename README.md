<div align="center">
  <h1>Mirko's dotfiles</h1>
</div>

## Table of content

- [Bash Config](#bash)
- [Vim Config](./vim/)
- [Neofetch Config](./neofetch)

<div align="center" id="bash">

<h1>Bash config files</h1>

<img src="https://juncotic.com/wp-content/uploads/2014/07/Gnu-bash-logo.svg_.png">

</div>

## Requirements

- Cargo

- Python

- Pip

## Installation

```
$> git clone https://github.com/Mirko-r/dotfiles.git
$> cd bash
$> chmod u+x install.sh
$> ./install.sh
```

## Features

- ### Bat

### Syntax highlighting

`bat` supports syntax highlighting for a large number of programming and markup
languages:

![Syntax highlighting example](https://imgur.com/rGsdnDe.png)

### Git integration

`bat` communicates with `git` to show modifications with respect to the index
(see left side bar):

![Git integration example](https://i.imgur.com/2lSW4RE.png)

### Show non-printable characters

You can use the `-A`/`--show-all` option to show and highlight non-printable
characters:

![Non-printable character example](https://i.imgur.com/WndGp9H.png)

### Automatic paging

By default, `bat` pipes its own output to a pager (e.g `less`) if the output is too large for one screen.
If you would rather `bat` work like `cat` all the time (never page output), you can set `--paging=never` as an option, either on the command line or in your configuration file.
If you intend to alias `cat` to `bat` in your shell configuration, you can use `alias cat='bat --paging=never'` to preserve the default behavior.

#### File concatenation

Even with a pager set, you can still use `bat` to concatenate files :wink:.
Whenever `bat` detects a non-interactive terminal (i.e. when you pipe into another process or into a file), `bat` will act as a drop-in replacement for `cat` and fall back to printing the plain file contents, regardless of the `--pager` option's value.



- ### TheFuck

```
➜ apt-get install vim
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?

➜ fuck
sudo apt-get install vim [enter/↑/↓/ctrl+c]
[sudo] password for nvbn:
Reading package lists... Done
...

```



