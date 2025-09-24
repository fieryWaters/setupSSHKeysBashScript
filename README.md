# SSH Setup Scripts

A collection of bash scripts for streamlined SSH key management and server configuration. The primary scripts work on both macOS and Linux, making it easy to set up secure SSH connections between your local machine and remote servers.

## Main Scripts

### setup_ssh_keys_on_remote.sh
**Platform:** macOS/Linux → Ubuntu server

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
**Platform:** macOS/Linux

Automates GitHub SSH key setup for developers:
- Generates a 4096-bit RSA key specifically for GitHub (uses `id_rsa` filename)
- Configures Git with your username and email
- Tests the GitHub SSH connection

**Usage:**
```bash
./newServerSetup/setupGithubKeys.sh
```

## Additional Utilities

### Password Authentication Management
- `enablePasswordLogin.sh` - Re-enables password authentication on Ubuntu servers
- `disablePasswordLogin.sh` - Disables password authentication for enhanced security (requires sudo)

### Server Utilities (Ubuntu/Debian)
Located in `newServerSetup/`:
- `enableSshServer.sh` / `disableSshServer.sh` - Manage SSH server service
- `enableLidCloseSleep.sh` / `disableLidCloseSleep.sh` - Control laptop lid behavior (useful for laptop servers)

## Requirements

- **Local machine:** macOS or Linux with bash and ssh-keygen
- **Remote servers:** Ubuntu/Debian with SSH server installed

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/fieryWaters/setupSSHKeysBashScript.git
cd setupSSHKeysBashScript
```

2. Run the appropriate script for your needs (scripts are already executable)

## Security Notes

- After setting up SSH keys, consider disabling password authentication on your server using `disablePasswordLogin.sh`

## Contributing

Feel free to submit issues or pull requests for improvements.