# Zebra Password Changer CLI

[![maintenance-status](https://img.shields.io/badge/maintenance-as--is-yellow.svg?style=for-the-badge)](https://gist.github.com/angelside/364976fbcf7001a5da7e79ad8ed91fec)
![Nim](https://img.shields.io/badge/Nim-FFE953.svg?style=for-the-badge&logo=Nim&logoColor=black)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
[![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciICB2aWV3Qm94PSIwIDAgNDggNDgiIHdpZHRoPSI0OHB4IiBoZWlnaHQ9IjQ4cHgiPjxwYXRoIGZpbGw9IiM0Y2FmNTAiIGQ9Ik0yNCw1QzEzLjUsNSw1LDEzLjYsNSwyNC4xYzAsOC4yLDUuMSwxNS4xLDEyLjMsMTcuOWw0LjItMTEuNUMxOC44LDI5LjUsMTcsMjcsMTcsMjQgYzAtMy45LDMuMS03LDctN3M3LDMuMSw3LDdjMCwzLTEuOCw1LjUtNC41LDYuNUwzMC43LDQyQzM3LjksMzkuMiw0MywzMi4zLDQzLDI0LjFDNDMsMTMuNiwzNC41LDUsMjQsNXoiLz48cGF0aCBmaWxsPSIjMmU3ZDMyIiBkPSJNMTcuOSw0My4zbC0wLjktMC40QzkuMiw0MCw0LDMyLjQsNCwyNC4xQzQsMTMsMTMsNCwyNCw0YzExLDAsMjAsOSwyMCwyMC4xIGMwLDguMy01LjIsMTUuOS0xMi45LDE4LjhsLTAuOSwwLjRsLTQuOC0xMy4zbDAuOS0wLjRjMi4zLTAuOSwzLjgtMy4xLDMuOC01LjZjMC0zLjMtMi43LTYtNi02cy02LDIuNy02LDZjMCwyLjUsMS41LDQuNywzLjgsNS42IGwwLjksMC40TDE3LjksNDMuM3ogTTI0LDZDMTQuMSw2LDYsMTQuMSw2LDI0LjFjMCw3LjEsNC4zLDEzLjcsMTAuNywxNi41bDMuNS05LjZDMTcuNiwyOS43LDE2LDI3LDE2LDI0YzAtNC40LDMuNi04LDgtOCBzOCwzLjYsOCw4YzAsMy0xLjYsNS43LTQuMiw3bDMuNSw5LjZDMzcuNywzNy44LDQyLDMxLjMsNDIsMjQuMUM0MiwxNC4xLDMzLjksNiwyNCw2eiIvPjwvc3ZnPg==)](./LICENSE)

> Zebra Password Changer CLI is a _"blazingly fast 🤣"_ CLI tool that allows changing Zebra printer's web interface password with socket protocol. Written with **Nim** 👑 programming language.

## 📦 Installation

No installation, no dependencies, it's in binary format.

## 🚀 Compilation

> ⚠️ You must compile it yourself until any binary is released.

This cli tool is built with **Nim** programming language. For binary compilation, you need to install [nim toolchain](https://nim-lang.org/install.html) and you can use the below command inside the tool root directory. _The custom compilation configurations in the `config.nims` file will be used._ The command will create `./bin/zebra-password-changer` binary file.

Default compilation

```bash
$ nim c ./src/main.nim
```

Custom binary file name sample

```bash
$ nim c -o:./bin/my-super-duper-cli-app ./src/main.nim
```

A full walkthrough can be like below

```bash
$ git clone https://github.com/angelside/zebra-password-changer-cli-nim.git
$ cd zebra-password-changer-cli-nim
$ nim c ./src/main.nim
$ ./bin/zebra-password-changer help
```

> ℹ️ It's a single binary file, you can move the file anywhere and/or can add it to PATH.


## 🔨 Usage

CLI tool has two parameters: the printer's IP address and the new password (4 digits, only numbers). _We don't have to know the current password._

```bash
$ ./bin/zebra-password-changer <IP_ADDRESS> <PASSWORD>
```

### 📋 Sample usages and results

successful

```
$ ./bin/zebra-password-changer <IP_ADDRESS> <PASSWORD>
== Zebra password changer ==

[OK] 172.18.197.202 : password has been changed.
```

with errors

```
$ ./bin/zebra-password-changer <IP_ADDRESS> <PASSWORD>
== Zebra password changer ==

[ERROR] IP address is invalid.
[ERROR] Password is invalid! Please enter a 4-digit number.
```

OSError / device offline

```
$ ./bin/zebra-password-changer <IP_ADDRESS> <PASSWORD>
== Zebra password changer ==

[ERROR] Failed to connect: No route to host
```

version command

```
$ ./bin/zebra-password-changer version
== Zebra password changer ==

VERSION
    zebra-password-changer v0.1.0 - linux-amd64 nim-v1.6.6
```

help command

```
$ ./bin/zebra-password-changer help
== Zebra password changer ==

USAGE
    zebra-password-changer <IP_ADDRESS> <PASSWORD>
    zebra-password-changer  [command]

COMMANDS
    help     show CLI help
    version  show CLI version

DESCRIPTION
    CLI tool that allows changing Zebra printer's password
```

## 💥 Features

- Simple CLI colours
- Argument checks & help command
- Ip address validation
- Password validation

## 🎯 Tested Zebra printer models

- ZD 620 - ZD 621
- GK 420d

## 🤝 Contributing

Before contributing issues or pull requests, could you review the [Contributing Guidelines](./.github/CONTRIBUTING.md) first?

## 💬 Questions?

Feel free to [open an issue](https://github.com/angelside/zebra-password-changer-cli-nim/issues/new).

## 🤩 Support

💙 If you like this project, give it a ⭐ and share it with friends!

## 🏛️ License

This project is open-sourced software licensed under the [MIT license](./LICENSE).
