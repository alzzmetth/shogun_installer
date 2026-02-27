# SHOGUN  
## Package Management System

Shogun adalah lightweight, cross-platform binary package installer yang dirancang untuk mendistribusikan, memverifikasi, dan mengelola perangkat lunak berbasis repository terstruktur dengan kontrol integritas tingkat tinggi.

Berbeda dengan wrapper terhadap package manager sistem operasi, Shogun mengelola repository independen yang memetakan:

> Package → Version → Architecture → Source URL → SHA256 → Metadata

Shogun dikembangkan dengan pendekatan keamanan dan konsistensi distribusi sebagai fondasi utama.

---

# Executive Overview

Shogun dibangun untuk mengatasi kebutuhan distribusi binary yang:

- Konsisten
- Terkontrol
- Terverifikasi
- Multi-arsitektur
- Independen dari package manager OS

Shogun cocok digunakan untuk:

- Developer environment bootstrap
- Internal tool distribution
- DevOps automation
- Binary deployment terkontrol
- Lightweight package management

---

# Core Features

### Cross-Platform Architecture
- Windows
- Linux (planned build target)
- macOS (planned build target)

### Repository-Based Distribution
- Custom repository index
- Structured metadata mapping
- Centralized package definition

### Integrity Verification
- SHA256 checksum validation
- Verified / Unverified status system
- Hash comparison before execution

### Multi-Architecture Support
- x86 (i386)
- x64
- ARM

### Version Control Support
- Install specific version
- Stable/default resolution
- Version metadata inspection

### CLI Driven
- Search packages
- Inspect metadata
- Install versioned packages
- Structured output display

---

# Installation

Download the appropriate binary for your operating system.

Windows:
shogun.exe
Salin kode

Linux / macOS:
shogun
Salin kode

Add the binary to your system PATH to enable global CLI access.

---

# Command Reference

## Search Packages
shogun search 
Salin kode

Example:
shogun search qemu
Salin kode

Displays available packages with:
- Architecture
- Version
- Verification status

---

## Inspect Package Metadata
shogun info 
Salin kode

Example:
shogun info openjdk
Salin kode

Output includes:
- Name
- Version
- Architecture
- File size
- SHA256 checksum
- Verification state
- Source URL

---

## Install Package

Install specific version:
```
shogun install [name package]
```
```
Example:
shogun install openjdk
```


If version is not specified, Shogun resolves the default/stable version from repository metadata.

---

# Installation Workflow

1. Resolve package metadata from repository index
2. Detect operating system and architecture
3. Download binary to temporary directory
4. Calculate SHA256 checksum
5. Validate against repository record
6. Execute installer or extract archive
7. Log installation result

If checksum mismatch occurs:
- Installation halts
- Execution is blocked

---

# Verification Model

Shogun implements integrity validation using SHA256 hashing.

Verification States:

- Verified — Checksum matches database index


Security Roadmap:

- Signed repository index
- Public key verification
- Mandatory verification enforcement
- Strict trust policy configuration

---


