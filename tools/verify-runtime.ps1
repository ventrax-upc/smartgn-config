[CmdletBinding()]
param(
    [string]$BaseUrl = 'http://127.0.0.1:8088',
    [int]$WaitSeconds = 90
)

$ErrorActionPreference = 'Stop'
$healthUri = $BaseUrl.TrimEnd('/') + '/actuator/health'
$deadline = (Get-Date).AddSeconds($WaitSeconds)
$health = $null

do {
    try {
        $health = Invoke-RestMethod -Method Get -Uri $healthUri -TimeoutSec 5
        if ($health.status -eq 'UP') { break }
    } catch {
        Start-Sleep -Seconds 2
    }
} while ((Get-Date) -lt $deadline)

if ($null -eq $health -or $health.status -ne 'UP') {
    throw "Config health did not report UP at $healthUri within $WaitSeconds seconds."
}
Write-Host "PASS Config Actuator health: $($health.status)"

$applications = @(
    'alerting-notifications-service',
    'api-gateway',
    'smartgn-admin',
    'smartgn-iam-service',
    'smartgn-installation-device-management',
    'smartgn-message-broker',
    'smartgn-monitoring',
    'smartgn-payments-billing',
    'smartgn-telemetry',
    'support-maintenance-service'
)

foreach ($application in $applications) {
    $uri = '{0}/{1}/local' -f $BaseUrl.TrimEnd('/'), $application
    $document = Invoke-RestMethod -Method Get -Uri $uri -TimeoutSec 10
    if ($document.name -ne $application) {
        throw "Config document '$application' returned unexpected name '$($document.name)'."
    }
    if ($document.profiles -notcontains 'local') {
        throw "Config document '$application' did not report the 'local' profile."
    }
    if ($null -eq $document.propertySources -or $document.propertySources.Count -lt 1) {
        throw "Config document '$application' did not include a property source."
    }
    Write-Host "PASS Config document: $application/local"
}
