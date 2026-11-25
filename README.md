# NetToolbox - Network Diagnostic Script

A CLI tool written in Bash that automates connectivity checks and basic DNS service verification.

## 🚀 Features
- Automatic detection of the active network interface, IP address (with CIDR mask), and gateway.
- Sequential diagnostics:
  
    -IP connectivity test via ICMP (`8.8.8.8`).
  
    -Domain name resolution test via DNS (`google.com`).
  
    -DNS record extraction via `dig`.

## 🛠️ Prerequisites
- Linux or macOS operating system.
- Required tools: `iproute2`, `bind-utils` (`dig`), `ping`.

## 💻 Usage
```bash
chmod +x nettoolbox.sh
./nettoolbox.sh
