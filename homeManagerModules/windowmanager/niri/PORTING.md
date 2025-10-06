# Hyprland → Niri Port Notes

## Summary
- Hyprland input, environment, workspace, and launcher bindings now map directly to the new Niri configuration in `homeManagerModules/windowmanager/niri/default.nix`.
- Startup daemons and desktop services from Hyprland's `exec-once` section are reproduced via `spawn-at-startup`, and window placement for Thunderbird, Discord, and EasyEffects is handled with `open-on-workspace` rules.
- Floating utility dialogs (Pavucontrol, network editor, calculator, etc.) and terminal opacity rules are mirrored through Niri window rules where supported.

## Feature coverage overview
| Area | Hyprland behaviour | Niri equivalent |
| --- | --- | --- |
| Input focus & touchpad | `follow_mouse`, tap-to-click, natural scroll | `focus-follows-mouse.enable`, tap, natural scroll, middle-click emulation |
| Launchers & shell actions | Rofi, hyprlock, wallpaper switcher, notifications | Same commands mapped via `binds` + `spawn-at-startup` |
| Audio & brightness keys | `wpctl`, `qs` helpers | Identical commands bound to XF86 keys |
| Screenshots | `grim` + `slurp` variants | Same shell pipelines reused |
| Workspace selection | `Super+[0-9]`, `Super+Shift`, `Super+Alt` combos | Generated via `config.lib.niri.actions` helpers |
| Window positioning | `movewindow`, `splitratio`, workspace cycling | `consume-or-expel-window-*`, `set-column-width`, `focus-workspace-*` |
| Floating utilities | Hyprland `windowrule` entries | Niri `window-rules` for Pavucontrol, NM editor, Bitwarden, Calculator, mpv/Clapper, Steam popups, etc. |
| Autostart apps | `exec-once` block | `spawn-at-startup` array |

## Partial or unsupported features
- **Special workspace / scratchpad**: Hyprland's `movetoworkspacesilent special` and `togglespecialworkspace` do not have native Niri counterparts. A future workaround would require an external script managing a hidden workspace and custom bindings.
- **Window pinning**: `pin` to keep floating windows above others isn't exposed in Niri yet.
- **Force kill via compositor**: `hyprctl kill` has no direct match. The current mapping closes windows gracefully and falls back to `quit { skip-confirmation = true; }` for exiting Niri.
- **Monitor workspace moves**: Hyprland's `workspace, m±1` moves the active workspace between monitors. Niri currently offers only focus switching (`focus-monitor-left/right`).
- **Mouse drag bindings**: `bindm` combinations for moving/resizing windows with Super + mouse buttons are not implemented; Niri handles pointer-driven moves internally but lacks configurable bindings today.
- **Advanced window rule geometry**: Hyprland rules that set size/position (`size 45%`, `center`, `keepaspectratio`, `move on start`, etc.) are not replicated because Niri's window rules expose only floating mode, opacity, and target workspace.
- **Decoration effects**: Hyprland blur, rounding, and animation beziers aren't transferable. Niri's layout section only supports borders, focus ring, shadows, and gaps.
- **Touch gesture plugins**: Hyprland's `touch_gestures` plugin has no Niri analogue.
- **Global menu (Kando)**: `Ctrl+Space` radial menu binding relies on Hyprland's `global` keyword; Niri lacks a direct integration hook.
- **Session / VRR toggles**: Misc settings like `vrr`, `vfr`, DPMS toggles, and splash suppression do not map cleanly to Niri configuration knobs.

## Potential follow-ups
- Track upcoming Niri releases for scratchpad-like functionality or monitor workspace transfers, updating bindings when APIs appear.
- Investigate a small wrapper script to emulate special workspaces and pinning using floating layer surfaces.
- Expand window rules if additional applications require floating or workspace targeting once their Wayland app IDs are confirmed.
