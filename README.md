# Configsaver
A small FastApi Docker service for saving arbitrary json to disk. No authentication and no validation.

Uses nonroot user uid 999 - JSON gets saved to `/configs` which can be mounted to a folder on the host using docker. This folder needs to be writable for 999.