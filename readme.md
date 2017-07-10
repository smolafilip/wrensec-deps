# General

Contains various opensource Maven artifacts which might not be available in public repositories at the time of writing to build Wren:AM and Wren:IDM. 

This repository must be seen as a temporary solution to ensure we can build Wren:AM and Wren:IDM. The goal is to replace all the artifacts that are installed here by artifacts built from verifiable opensource repositories. The idea is to chip off artifacts installed by these scripts one by one and replace them by artifacts built from verifiable sources. The goal is to make this entire repository obsolete.

# Scripts

`install_wrenam_13-5_deps.sh` installs dependencies needed to build Wren:AM 13.5 (`sustaining/13.5` branch) into the user's local maven repository (`~/.m2/repository`).

`install_wrenam_13_deps.sh` installs dependencies needed to build Wren:AM 13 (`sustaining/13` branch) into the user's local maven repository (`~/.m2/repository`).
**WARNING: This script does not yet install all dependencies needed to do a full Wren:AM 13 build!** It will currently get you about 70% of the entire Wren:AM 13 build.

`install_openidm_4.0.2_deps.sh` installs dependencies needed to build Wren:IDM 4.0.2 into the user's local maven repository (`~/.m2/repository`).

`install_openidm_5.0.0_deps.sh` installs dependencies needed to build Wren:IDM 5.0.0 into the user's local maven repository (`~/.m2/repository`).

`install_openidm_5.5.0_deps.sh` installs dependencies needed to build Wren:IDM 5.5.0 into the user's local maven repository (`~/.m2/repository`).
