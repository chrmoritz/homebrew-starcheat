Homebrew-StarCheat
==================
This repo is a tab for homebrew containing a formula for [StarCheat](https://github.com/wizzomafizzo/starcheat)

How to use
----------
To install StarCheat just `brew tap chrmoritz/starcheat` and then `brew install starcheat` and optionally `brew linkapps starcheat` to link the build `.app` into your `/Applications` folder. You can also install a in development version with `brew install starcheat --HEAD` or pass a `--without-app` to any of the install commands to not create a `.app`.

It will be updated with every `brew update` as normal and is listed in `brew outdated` if there is a new version available. In this case just run `brew upgrade starcheat` to install the new version.
