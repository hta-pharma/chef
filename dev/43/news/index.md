# Changelog

## chef 0.1.1

- Added comprehensive examples to all exported functions for better
  documentation and CRAN compliance.
- Removed dependency on {testr} package and replaced with base
  {testthat}/{withr} equivalents for better CRAN compatibility.
- Improved test robustness by ensuring that changes to adam functions
  only invalidate targets that use those functions.
- Fixed Windows path handling issues.
- Updated test snapshots to use snapshot values.
- Moved {qs}, {future}, {future.callr}, and {tarchetypes} from Imports
  to Suggests in DESCRIPTION.
- Added BugReports field to DESCRIPTION and improved package metadata.

## chef 0.1.0

- Initial release.
