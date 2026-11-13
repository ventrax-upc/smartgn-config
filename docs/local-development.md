# Local development

## Start

Start a standalone Config Server from this repository:

```powershell
./scripts/start-local.ps1 -Build
```

The script creates `.env` from `.env.example` only when needed. The template supplies credentials for the local Admin Server at `http://localhost:8089`; start that service separately when you want to see Config registered in Admin. In the complete platform, Config and Admin start together through the 11-service Compose project. Run `./scripts/start-integrated.ps1` from `../smartgn-api-gateway` and see [integrated local SmartGN](../../smartgn-api-gateway/docs/integrated-local.md).

## Verify health and published configuration

```powershell
./scripts/smoke-local.ps1
```

The smoke check waits for Actuator health and fetches every configured application document for the `local` profile. Each response must identify the expected application, include the requested profile, and contain a property source.

To inspect a document directly, use `http://127.0.0.1:8088/smartgn-admin/local`. Stop the standalone container with `docker compose down`.
