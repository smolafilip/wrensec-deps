General
=======

Contains various opensource Maven artifacts which might nog be available in public repositories at the time of writing to build Wren:AM. 

This repository must be seen as a temporary solution to ensure we can build Wren:AM. The goal is to replace all the artifacts in this that are installed here by artifacts built from verifiable, opensource repositories. The idea is to chip off artifacts installed by these scripts one by one and replace them by artifacts built from verifiable sources. In the end the goal is to make this entire repository obsolete.

Scripts
=======

`install_wrenam_13-5_deps.sh` installs the dependencies in the users `~/,m2/repository` directory needed to build Wren:AM 13.5 (`sustaining/13.5` branch).

`install_wrenam_13_deps.sh` installs the dependencies in the users `~/,m2/repository` directory needed to build Wren:AM 13 (`sustaining/13` branch). **WARNING: This script does not yet install all dependencies needed to do a full Wren:AM 13 build!**. It will currently get you about 70% of the entire Wren:AM 13 build.