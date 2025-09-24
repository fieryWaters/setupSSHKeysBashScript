# SSH Setup Scripts

Scripts for setting up passwordless SSH authentication to remote servers. Includes a dedicated script for GitHub SSH key setup and git configuration. Also provides utilities for managing SSH server settings on Ubuntu.

## Getting Started

```bash
git clone https://github.com/fieryWaters/setupSSHKeysBashScript.git
cd setupSSHKeysBashScript
```

## Main Scripts

### setup_ssh_keys_on_remote.sh
**Runs on:** macOS/Linux/WSL
**Target:** Any SSH server

The streamlined script for setting up SSH key authentication. This script:
- Generates an SSH key pair locally (stored in ~/.ssh/)
- Transfers the public key to your remote server's ~/.ssh/authorized_keys
- Appends host configuration to your local ~/.ssh/config file
- Tests the connection to verify everything works

**Usage:**
```bash
./setup_ssh_keys_on_remote.sh
```

You'll be prompted for:
- Key file name
- Remote server username
- Remote server IP address

After setup, you can connect using: `ssh [keyname]`

### newServerSetup/setupGithubKeys.sh
**Runs on:** macOS/Linux/WSL

Automates GitHub SSH key setup for developers:
- Generates a 4096-bit RSA key specifically for GitHub (uses `id_rsa` filename)
- Configures Git with your username and email
- Tests the GitHub SSH connection

**Usage:**
```bash
./newServerSetup/setupGithubKeys.sh
```

## Ubuntu Server Scripts

### Password Authentication
- `enablePasswordLogin.sh` - Re-enables password authentication (requires sudo)
- `disablePasswordLogin.sh` - Disables password authentication (requires sudo)

### Server Management
Located in `newServerSetup/`:
- `enableSshServer.sh` / `disableSshServer.sh` - Start/stop SSH server and configure autostart
- `enableLidCloseSleep.sh` / `disableLidCloseSleep.sh` - Control laptop lid suspend behavior


## Contributing

Feel free to submit issues or pull requests for improvements.