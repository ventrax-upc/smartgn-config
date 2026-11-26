# SmartGN Config

## Overview

Serves configuration for SmartGN applications from native profiles. Provides the configuration documents consumed when the integrated services start.

**Stack**  Java 25, Spring Boot, Spring Cloud Config.

## Run locally

The [integrated startup guide](https://github.com/ventrax-upc/smartgn-api-gateway/blob/develop/README.md#start-all-13-repositories-locally) covers all 13 repositories. The commands below describe this component.

Requirements are Docker Desktop with the Linux engine and PowerShell 7. Keep the SmartGN repositories as siblings for the integrated stack.

```powershell
./scripts/start-local.ps1 -Build
```

Run `./scripts/start-integrated.ps1` from the sibling `smartgn-api-gateway` repository.

| Endpoint | Local URL |
| --- | --- |
| Example configuration document | [Open](http://localhost:8088/smartgn-admin/local) |
| Health | [Open](http://localhost:8088/actuator/health) |

## Configuration

Standalone settings use the variables in `.env.example`. Copy it to an ignored `.env` when the local startup script requires it. Integrated credentials and generated files are stored under `.local` in the Gateway repository. Native configuration documents live in `src/main/resources/shared-configs`.

## Verification

```powershell
./scripts/smoke-local.ps1
```

Run the integrated smoke from the Gateway repository to verify cross-service workflows.

## Repository layout

- `src/main` contains the service implementation.
- `docs` contains service documentation.
- `scripts` contains local startup and verification commands.
- `tools` contains verification helpers and supporting assets.
- `fixtures/db.json` defines demo fixtures for local verification.

## Documentation

- [Local development](docs/local-development.md)

## Acceptance scenarios

See the [Gherkin acceptance scenarios](docs/acceptance/scenarios.gherkin). These are acceptance specifications. Use the verification commands above to run the automated checks.

## License

Distributed under the [MIT License](LICENSE).
