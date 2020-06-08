Homebrew-StarCheat
==================
This repo is a tab for homebrew containing a formula for [StarCheat](https://github.com/wizzomafizzo/starcheat)

How to use
----------
**Notice:** From now on you have to install the required dependency Pillow (image library) by yourself (because of issues building it from source). To do so just also run: `pip3 install --upgrade Pillow`.

To install StarCheat (dev version partly compatibile with StarBound 1.0+) just `brew install chrmoritz/starcheat/starcheat` and optionally `brew linkapps starcheat` to link the build `.app` into your `~/Applications` folder.

It will be updated with every `brew update` as normal and is listed in `brew outdated` if there is a new version available. In this case just run `brew upgrade starcheat` to install the new version.
