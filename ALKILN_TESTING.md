# Isolated ALKiln prerequisites for Prop19

The enabled scenario was seeded with ALDashboard’s static YAML generator and reviewed against the actual `PROP19.yml` mandatory order, PDF field expressions, and `PYLSupport:theme.yml`. It selects one beneficiary, uses the real terminal download ID, checks its completion text, and downloads the named PDF. Rows for addresses and unrelated fields not used by this form were removed. The publisher asks for `users[0]` separately from the form's client, so synthetic publisher-name rows are included.

## Current blocker: private package access

`docassemble.PYLSupport` is a **private** GitHub repository (confirmed using repository metadata). A pristine GitHub sandbox cannot authenticate the `git+https` dependency declared in setup.py. The observed browser artifact is a 404 at the interview URL after package installation; it is not evidence of a bad legal answer. This PR remains a draft until an authenticated fresh install and full ALKiln run pass.

The required private revision is pinned in setup.py:

- Repository: `LemmaLegalConsulting/docassemble-PYLSupport`
- Commit: `28e5a7e9b1637a1ead3a9c4d5f7fd528549dbaa9`
- Distribution/import namespace: `docassemble.PYLSupport`

Before marking ready, provide read access **inside the temporary docassemble container's dependency installer**, not only to the runner checkout. A narrowly scoped credential limited to the dependency repository can be stored as repository/organization secret `ALKILN_DEPENDENCY_TOKEN`. That secret is **not wired into the current stock isolated-server action**: the action installs the main package during server startup, before later workflow steps can install dependencies. Either use a controlled test image with the pinned private dependency already installed, or adapt the server-start/install stages to install the authorized private dependency before the main package. A complete adaptation must be reviewed and tested once the dedicated credential is available. Do not commit credentials or use a production account.

The import of this package's own `box.py` also requires `boxsdk`, now declared as a dependency. `PYLSupport` catches publication errors, so successful Box delivery is not asserted by this download scenario. If Box delivery is to be tested, provide a disposable `box.com` configuration with `client_id`, `client_secret`, `access_token`, and test `default_parent_folder` in the isolated server; never use client data or production destinations.

## Validation

- Selected interview and local includes reviewed; Gherkin syntax checked.
- Initial source-loading failure reproduced locally; isolated artifacts confirmed the subsequent 404 caused by unavailable package installation.
- Static fixture review completed; complete browser validation and unused-row review remain blocked on private dependency provisioning. The scenario remains enabled so the prerequisite is visible in CI.
