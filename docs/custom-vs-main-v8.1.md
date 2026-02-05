# Custom vs Main (v8.1)

This document records what the `custom` branch changed on top of the upstream `main` around the `v8.1` baseline.

## Reference points

- Baseline (main tag): `v8.1` (`aa1045f`)
- Latest main pulled/merged: `origin/main` (`3290216`)
- Custom head after merge: `custom` (`650f20d`)

## What custom added/changed (v8.1-related)

Custom started tracking generated skin outputs in git (instead of ignoring them):

- Added: `config.yaml`
- Added: `demo.png`
- Added: `dark/` output files (`*.yaml`, `.*.keyboard`, etc.)
- Added: `light/` output files (`*.yaml`, `.*.keyboard`, etc.)

`.gitignore` was updated to stop ignoring the files above, so they can be committed.

## Custom commits that introduced these changes

- `7728085` chore: add v8.1 config and demo
- `3ba1047` chore: add v8.1 dark skin assets
- `2f22b3b` chore: add v8.1 light skin assets
- `aefe732` chore: track generated skin outputs

## How main was updated on custom

Custom merged the latest upstream main into the branch:

- `650f20d` Merge remote-tracking branch 'origin/main' into custom

## Verification commands

These are the commands used to verify the delta:

```bash
git diff --name-status origin/main..HEAD -- config.yaml demo.png .gitignore dark light
git diff --stat origin/main..HEAD -- config.yaml demo.png .gitignore dark light
```
