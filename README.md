<!-- jr-brand:start -->
<div align="center">
  <a href="https://jannikreinhard.com/">
    <img src="https://raw.githubusercontent.com/JayRHa/.github/main/assets/readme/brand-header.png" alt="Jannik Reinhard — Driving AI with passion" width="100%">
  </a>
  <h1>Intune Device Troubleshooter</h1>
  <p><strong>PowerShell-based troubleshooting tool for diagnosing and resolving issues on Intune-managed Windows devices.</strong></p>
  <p>
  <a href="https://jannikreinhard.com/"><img src="https://img.shields.io/badge/Website-146CDD?style=flat-square&amp;logo=wordpress&amp;logoColor=white" alt="Website"></a>
  <a href="https://github.com/JayRHa"><img src="https://img.shields.io/badge/GitHub-081427?style=flat-square&amp;logo=github&amp;logoColor=white" alt="GitHub"></a>
  <a href="https://www.linkedin.com/in/jannik-r/"><img src="https://img.shields.io/badge/LinkedIn-0795FF?style=flat-square&amp;logo=linkedin&amp;logoColor=white" alt="LinkedIn"></a>
  <a href="https://x.com/jannik_reinhard"><img src="https://img.shields.io/badge/X-081427?style=flat-square&amp;logo=x&amp;logoColor=white" alt="X"></a>
  <a href="https://www.youtube.com/@jannikreinhard"><img src="https://img.shields.io/badge/YouTube-146CDD?style=flat-square&amp;logo=youtube&amp;logoColor=white" alt="YouTube"></a>
  </p>
  <p><sub>Driving AI with passion · Microsoft Foundry · Intune · Azure</sub></p>
</div>
<!-- jr-brand:end -->

## Highlights

- Unified single-device view with Intune + Entra ID context
- Built-in device actions (`Sync`, `Restart`, `Shutdown` when available)
- Actionable recommendations based on current device signals
- One-click remediation trigger for individual devices
- Deep links to Intune admin center and Azure portal from key IDs

## Screenshots

| Device overview | Device actions |
| --- | --- |
| ![Overview](assets/overview.png) | ![Actions](assets/action.png) |

| Recommendations | Remediation trigger |
| --- | --- |
| ![Recommendations](assets/recommendations.png) | ![Remediation](assets/remediation.png) |

## Requirements

- Windows host with PowerShell and WPF support
- Access to Microsoft Intune and Microsoft Graph
- User account with sufficient Intune/Entra admin rights

The tool uses Microsoft Graph `beta` profile.

## Graph Scopes Requested by the Tool

On sign-in, the app requests:

- `User.Read.All`
- `User.Read`
- `Group.Read.All`
- `DeviceManagementManagedDevices.PrivilegedOperations.All`
- `DeviceManagementApps.Read.All`
- `DeviceManagementConfiguration.Read.All`
- `DeviceManagementManagedDevices.Read.All`

If remediation/group operations fail in your tenant, validate additional delegated permissions and role assignments for group write and remediation assignment operations.

## Quickstart

```powershell
git clone https://github.com/JayRHa/IntuneDeviceTroubleshooter.git
cd IntuneDeviceTroubleshooter
```

Unblock bundled DLLs once (recommended):

```powershell
Get-ChildItem .\libaries\*.dll | Unblock-File
```

Run the app:

```powershell
powershell -ExecutionPolicy Bypass -File .\Start-DeviceTroubleshooter.ps1
```

The script installs `Microsoft.Graph` automatically if it is missing.

## How Remediation Triggering Works

When you start a remediation script for one selected device, the tool:

1. Uses (or creates) a security group named `MDM-Remediation-Trigger-{ScriptName}`
2. Adds the selected device to that group
3. Assigns the remediation script to the group (if not already assigned)
4. Runs the remediation on the next service cycle

The group prefix can be adjusted in `Start-DeviceTroubleshooter.ps1`.

## Notes and Limitations

- Device list is designed for managed `Windows` and `macOS` devices
- Remediation tab is shown for Windows devices
- Some API calls rely on Microsoft Graph `beta` behavior

## Troubleshooting

- Startup fails while loading DLLs: run `Get-ChildItem .\libaries\*.dll | Unblock-File`
- Graph sign-in fails: ensure Microsoft Graph outbound access, allowed consent for scopes, and sufficient Intune/Entra role permissions
- Remediation does not apply: check group creation/member add and verify remediation assignment + device eligibility in Intune

## Author

- Jannik Reinhard
- Website: https://jannikreinhard.com
- X: https://x.com/jannik_reinhard
- LinkedIn: https://www.linkedin.com/in/jannik-r/

## License

MIT. See `LICENSE`.

<!-- jr-brand-footer:start -->

---

<div align="center">
  <p><sub>Built and maintained by <a href="https://jannikreinhard.com/">Jannik Reinhard</a> · Microsoft MVP for Security and AI Platform.</sub></p>
  <p><a href="https://www.buymeacoffee.com/jannikreinf">Support the open-source work</a></p>
  <p><strong>Stay healthy, Cheers Jannik</strong></p>
</div>

<!-- jr-brand-footer:end -->
