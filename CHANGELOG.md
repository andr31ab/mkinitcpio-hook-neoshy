# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1-1] - 2025-04-25
### Added
- Support for specifying the source device and image path in a single `src_rootfs` parameter (`<device_identifier>:/path/to/image.img`).
- Added flexible parsing for device identifiers: `UUID=`, `PARTUUID=`, `LABEL=`, `PARTLABEL=`, and raw `/dev/...` paths are now all supported.
- Improved error handling and logging during hook execution.

### Changed
- Reworked device resolution logic for better reliability during early boot.
- Simplified and hardened internal logic compared to previous versions.

---

## [1.0-2] - 2025-04-13
### Fixed
- Hardened parent directory resolution for container file mount, eliminating a potential security issue where a maliciously crafted path could lead to unexpected or unauthorized behavior.

### Changed
- Improved path validation logic during early boot hook execution.

---

## [1.0-1] - 2025-04-12
### Added
- Initial implementation of `neoshy` mkinitcpio hook for pre-encrypt container file mounting.
