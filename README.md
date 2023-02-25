<h1 align="center">
  <img src="./media/icon.png" alt="Hanko" width="130">
  <br>
  Hanko 
  <br>
</h1>

<h4 align="center">A next-generation GPG key manager with hardware security key support.</h4>

<p align="center">
  <a href="https://github.com/lfroms/hanko/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/lfroms/hanko"></a>
  <img alt="GitHub contributors" src="https://img.shields.io/github/contributors/lfroms/hanko">
  <a href="https://github.com/lfroms/hanko/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/lfroms/hanko"></a>
  <a href="https://github.com/lfroms/hanko"><img alt="GitHub license" src="https://img.shields.io/github/license/lfroms/hanko"></a>
</p>

<p align="center">
  <img alt="Hanko screenshot" src="./media/screenshot.png">
</p>

## About

⚠️ **Hanko is a work-in-progress. Contributions are welcome!**

Hanko _[HAHN-ko]_, named for the personalized Japanese stamp often used in lieu of handwritten signatures, is a modern GPG key manager that makes it easy to create, edit, and organize GPG keys. Hanko aims to be a modern alternative to GPG Keychain from GPGTools and is written in Swift and SwiftUI.

### Key Features

- Human-friendly user interface that makes it easy for anyone to manage keys.
- Support for managing and configuring hardware security keys such as the YubiKey.

Hanko uses [gpgme](https://gnupg.org/software/gpgme/index.html) under the hood and does not interact with the `gpg` command line tool directly.

<p align="center">
  <img alt="Key creation in Hanko" src="./media/key_creation.png">
</p>

## Contributions

Hanko is currently a work-in-progress, but any and all contributions are welcome.

## License

Hanko is released under the [GPL-3.0 License](LICENSE) unless otherwise noted.
