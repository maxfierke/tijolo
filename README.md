<img align="left" src="./icons/tijolo.svg" width="100" height="100" />

# THIS BRANCH STILL A WORKING IN PROGRESS

This is the GTK4 port branch, still a working in progress and probably unusable yet.

# Tijolo

Lightweight, keyboard-oriented IDE for the masses.

[![AUR](https://img.shields.io/aur/version/tijolo)](https://aur.archlinux.org/packages/tijolo)
![Build Status](https://github.com/hugopl/tijolo/actions/workflows/ci.yml/badge.svg?branch=main)

## Project status

**Alpha**. I'm already using it in my daily work and also to write itself.

The [TODO](./TODO.md) works like a roadmap and also list things I'm working on, it can give you a better idea of the project
status.

## How it looks like?

<img align="left" src="./screenshots/0.1.0-code.png" />

See more [screenshots](https://github.com/hugopl/tijolo/tree/master/screenshots).

## Project goals

- Run fast, something you don't see very often in new desktop applications.
- Have a simple distraction free UI.
- Keyboard focused user interface.
- Easy/fast code navigation.
- ♥️ Git.
- ♥️ Language Servers.

## Installing

### Archlinux

There's a AUR package for every release.

```
$ yay -S tijolo
```

There's also AUR package available for latest git version, named `tijolo-git`.

### Ubuntu

There should be a home made Ubuntu package for every release, check the
[github release page](https://github.com/hugopl/tijolo/releases).

If you want to create a package from git, clone the repository then run `./packages/make-ubuntu-package`, this will generate
a docker image, build Tijolo inside that image, create a debian package then copy it back, out of the container. Not best
approach to build a deb package but works on non-deb machines.

## Compiling from source

You will need:

 - Crystal compiler version >= 1.0.0.
 - GTK3.
 - GTKSourceView4.
 - [Vte](https://gitlab.gnome.org/GNOME/vte).
 - GIR packages for these GTK libraries.
 - [libGit2](https://libgit2.org/).
 - [editorconfig-core](https://github.com/editorconfig/editorconfig-core-c).

Then the usual:

```
$ make
$ sudo make install
```

Tijolo use [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font, you can _make install_ them if you don't already have
them installed:

```
$ sudo make install-fonts
```

To uninstall:

```
$ sudo make uninstall uninstall-fonts
```

## Usage

Pass a directory of a file under a git repository to open a project. Just call it without arguments to see a list of available projects.

## Contributing

1. Fork it (<https://github.com/hugopl/tijolo/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Any ideas/suggestions, fill in an issue.

## Contributors

- [Hugo Parente Lima](https://github.com/hugopl) - creator and maintainer
