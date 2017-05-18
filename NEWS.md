# Change Log
All notable changes to this project will be documented in this file.
This project tries to adhere to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

### Removed

### Deprecated 


## [0.2.*] unpublished yet, 

This version of badgecreatr has breaking changes with previous versions.
It was a major overhaul of the badgecreatr package with help from Florian Privé, Stephanie Locke,
and Andrie de Vries. I realized I never used the package as I originally intended, but I added one or two
badges by name. So I have exported all the functions for interactive use. And added new badges.

### Added
- R-version badge will be updated when you re-knit the readme.rmd to readme (thanks  Florian Privé @privefl)
- Vignette that explains badges
- Badge for r-documentation
- Badges for github stars and github forks. 
- Badge for last-change without R code (static)
- All badges can be added individually and start with `badge_*`: badge_projectstatus, badge_travis, badge_codecov , 
badge_minimal_r_version,
badge_cran, badge_packageversion, badge_last_change,
badge_last_change_static, badge_rdocumentation,
badge_github_star, badge_github_fork, badge_licence, badge_rank,
badge_cran_*
- Badge for package rank
- Badge for CRAN downloads
- Badge for CRAN release variants, from metacran (r-pkg.org)
- Vignette extending badgecreatr
- Added 'moved' as an option in project status badge. (Although you still need to modify that link.)
- set default project_status to "concept"


### Removed
- dependency on stringr @andrie

### Deprecated 
- **old function names ending in *badge:** projectstatusbadge, travisbadge,
codecovbadge, minimal_r_version_badge, cranbadge, packageversionbadge, and
last_change_badge.


### Fixed 
- when you rerun the command, no superflous lines will be added.  
- searches for licence badge and codecov badge didn't work. 
tx Stephanie Locke @steplocke for both these fixes.
- added location for all badges so that the badges can be used in other locations and not only in the top folder.
- Use only base R - remove dependency on stringr
- Use read.dcf() to read DESCRIPTION
- Simplify github access functions using git2r
Thanks Andrie de Vries @andrie for these huge improvements
- renamed changelog to news

### Security 

## [0.1.0] 2016-07-03
### Added
- r version badge
- changed the search results for badges into TRUE FALSE in stead of linenumber.
- existing badges will be recognized and not duplicated. 


### Removed
- nothing
### Deprecated 
- nothing
### Fixed 
- recognition of badges already placed. 

### Security 
- nothing

## [0.0.2] 2016-07-02
Currently creates badges for  Codecov, last change, travis, projectstatus
and licence. 
### Added
- Codecov badge
- last change
- travis
- projectstatus
- cran 
- packageversion

### Removed
-nothing
### Deprecated 
- nothing
### Fixed 
- nothing
### Security 
- nothing

## [0.0.1] - 2016-06-24
### Added
Started project with readme and several functions 
### Removed
- nothing
### Deprecated 
- nothing
