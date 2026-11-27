---
workflow: general-video
flow: automation
storyboard: no
message: "Stop AI hacks at every step - four places SUSE closes the AI supply chain"
destination: linkedin-feed-landscape
aspect: "16:9"
length: 120
language: en
---

# SUSE - Secure the AI Supply Chain (KubeCon NA 2026)

Full storyboard, copy, brand rules and fact guardrails supplied by the requester on 2026-11-06 (7 scenes, silent-first, 1080x1350, 30 fps, 60 s).

## Notes
- The Drive folder "SUSE selected assets" was not reachable through the Drive connector, so the five spot illustrations are drawn flat line icons in the on-pine palette (`assets/svg/*-on-pine.svg`). Logo geometry is the official SUSE_Logo-hor_L_Green-White-neg_sRGB, padding trimmed.
- Single root composition by request; lint warnings that suggest sub-compositions are accepted.

## v2 (2026-11-06)
- 1920x1080, 120 s, same copy and storyboard, slower pacing for readability.
- SUSE logo (Green-White-neg) top right for the whole film; the bottom-left end-card logo is replaced by it.

## v3 (2026-11-06)
- Adds the second SUSE blog, "Walls and guards: why AI agents need both isolation and policy".
- 120 s, 16:9. The requested 60 s timing was doubled to keep the 2 minute length: hook 0-10, essence 10-24, steps 24-72 (12 s each), walls and a guard 72-88, recap 88-104, end card 104-120.
- Hook: the dot breaks through a thin Persimmon-outlined sandbox (square corners) before taking the first pod.
- Guardrails: Kata Containers, gVisor and OpenShell are not SUSE products; only "SLES 16 supports OpenShell and Landlock". NVIDIA named in text only, no logo. SUSE AI Factory not mentioned.
- Shield and safe icons are the drawn on-pine versions from v1 (library folder unreachable).

## v4 (2026-11-07) - SUSE AI Factory
- Scene 2 (10-24 s) now introduces SUSE AI Factory: drawn factory with open doors, two chimneys with animated smoke, headline "Here's how SUSE AI Factory stops it", plus "Defence in depth" copy. The old "ordinary weaknesses / poisoned Python libraries" lead-in is removed.
- Scene 3 (24-36 s) zooms into the door onto an empty conveyor belt; a cardboard box is dropped at 26 s. Headline "Built on SUSE Linux Enterprise base containers", bullets "Full SLSA L3 provenance and attestation" and "100% SBOM". Replaces the Application Collection / Vulnerability Scanner card (step 1); the attacker path world now starts at step 2 (36 s).
- SUSE AI Factory is now named in the film (v3 guardrail lifted by request). SLSA L3 and 100% SBOM are requester-supplied claims.

## v4b (2026-11-08)
- Scene 3 is now a static-belt pan: belt and box stay at 2/3 across the frame, cogwheels and foreground props (crate stacks, pallet, post, floor marks) scroll left. Flat 2D box in the brand line style.
- New scene 4 (36-48 s, same conveyor shot): the box opens on top and packages drop in. Header "AI Dependencies from SUSE Application Collection" with the product name in Persimmon, card with "1000+ Python libraries", "Built from verified source", "Full provenance and attestation".
- Typewriter headers on scenes 2, 3 and 4.
- Length is now 132 s: everything from the old step 2 onward moved back 12 s.

## v5 (2026-11-08) - Kata scene (48-60 s), in progress
- New scene: lid closes, box turns x-ray (packages + the persimmon agent dot pushing at the walls), a gantry arm lifts it and lowers it into a steel "microVM" vault, lid slides on, host kernel tile at right. Header "The agent runs in its own Kata Containers sandbox"; Kata is not a SUSE product.
- Scene 2 copy: "Layer after layer. The attacker has to get past all of them." (count removed).
- Planned next: OpenShell (60-72 s), cluster + Vulnerability Scanner (72-84 s), then Runtime Enforcer, Admission Controller, recap, end card. Old castle / stolen-credentials step is to be removed. Film is temporarily 144 s with the old steps still in place after 60 s.

## v6 (2026-11-08) - OpenShell scene (64-76 s)
- Kata scene slowed (agent fights the box first, bulging sides; arm arrives at 52.6 s) and extended to 16 s; Kata Containers highlighted in persimmon; card gains "Technology Preview on SUSE Rancher Prime: RKE2"; host kernel tile removed.
- New scene: a guard (shield badge, "OpenShell") at the vault's single port. Request packets carry a key icon: decoy key (fog) goes in, real key (jungle) comes out for approved addresses; unknown addresses bounce back. Header "NVIDIA OpenShell guards the only way out"; card includes the requester-supplied line "SUSE Linux Enterprise Server 16 supports OpenShell and Landlock". OpenShell and NVIDIA are named in text only (no logo).
- Film is 160 s for now; old steps 2-4, castle, recap and end card still follow from 76 s and will be reworked (cluster scene next).

## v7 (2026-11-08) - cluster scene (76-88 s), OpenShell logo
- OpenShell guard now uses the real logo (assets/openshell-logo.png, supplied by the requester from the snapcraft dashboard); text label removed; request packets 1.5x bigger. At the end of the scene the box and vault roll off to the right.
- New scene: the vault arrives as a pod among 11 others in a "cluster" frame; a scan beam sweeps left to right, badges appear (green check, two persimmon "!" for exploitable pods). Header "In the cluster, every pod is scanned by SUSE Security Vulnerability Scanner"; card: "Scans every pod as it arrives", "Ranks what's really exploitable: KEV + EPSS". The gantry arm and rail fade out after the Kata scene.
- Film is 172 s for now; old steps 2-3 (Runtime Enforcer, Admission Controller), castle, recap and end card follow from 88 s and still need reworking.

## v8 (2026-11-08) - Runtime Enforcer scene (88-100 s)
- Zoom from the cluster grid (2x) onto a neighbouring pod; the agent's vault pod stays in view and calm. Other pods and the cluster frame dim during the zoom.
- The enforcer learns the pod's normal processes (app, worker, proxy; meter fills), switches to enforcing (shield badge), then a poisoned persimmon package drops in, starts `$ sh`, and is blocked ("blocked: not in the profile"). Callback to the hook (poisoned libraries) and the dependency packages scene.
- Header "SUSE Security Runtime Enforcer blocks everything off-script"; card "eBPF learns normal behaviour", "Then blocks the rest"; tag "Now available".
- The factory zoom now uses the full frame (shell fades near the door); logo hands over around the zoom (regular SUSE logo until 21.8 s, stacked AI Factory logo from 24.5 s).
- Film is 184 s for now; Admission Controller (reworked from the old step 3), recap and end card still follow from 100 s; the old castle / stolen-credentials step is still in and is to be removed.

## v9 (2026-11-08) - Admission Controller scene (106-122 s); old steps removed
- Runtime Enforcer scene stretched to 18 s (88-106 s); second card line appears once enforcing.
- New scene (106-122 s): the camera zooms back out, a shield gate sits at the cluster entrance, pods queue up from the left. Normal pods pass and are scheduled (the neighbouring pod pulses); a `privileged` pod and a `hostPath` pod are turned away ("rejected before it runs"). Header "SUSE Security Admission Controller checks every pod before it runs"; card "Checks every pod at the door", "Privileged and hostPath pods are rejected before they ever run".
- Removed the old path-world steps (Runtime Enforcer step, Admission step, stolen credentials) and the castle scene. The old world SVG/script stays dormant (hidden) and can be deleted later.
- Recap (122-138 s) first line now "Layer after layer."; end card 138-154 s. Film is 154 s.

## v10 (2026-11-08) - recap (122-138 s)
- Recap rebuilt around "Defence in depth": header "Defence in depth, inside the factory and around it"; card with three groups (Built right: SLE base containers + Application Collection; Contained: Kata Containers + NVIDIA OpenShell; Guarded: Vulnerability Scanner, Runtime Enforcer, Admission Controller); concentric rings (built right > contained > guarded, agent dot in the centre) that appear inside-out with the bullets.
- Admission Controller scene copy tightened (policy check, privileged denied, verifies image signatures; untrusted pod rejected); cluster sits 60 px lower when zoomed out.
- Footer line keeps the original requester claims: on premises and air-gapped, built on open source, ready for the Cyber Resilience Act (not independently verified).

## v11 (2026-11-08) - SUSE Rancher Prime scene (76-88 s)
- New scene between OpenShell and the Vulnerability Scanner: the vault arrives in the cluster, a "SUSE Rancher Prime" hub reaches every pod through dotted management lines with mint pulses. Header "SUSE Rancher Prime manages the cluster and its workloads".
- Card (to be confirmed by the requester): "Deploys and manages workloads across your clusters" (general capability, not checked against docs), "Installs and configures security policies from one UI" (Rancher UI extension for the Admission Controller policies), "Compliance reporting in the same UI" (Rancher Prime support offering).
- Scanner, Runtime Enforcer, Admission Controller, recap and end card moved back 12 s. Film is 170 s. The earlier 158 s export is out of date.
- The old path-world code and unused CSS were deleted before this.

## v12 (2026-11-08) - Rancher Prime wording across scenes
- Rancher Prime scene card: "Create and manage clusters across clouds and on-premise", "Deploys and manages workloads across your clusters".
- Vulnerability Scanner card gains "Full vulnerability reports from within SUSE Rancher Prime"; Admission Controller card gains "Install and manage policies from SUSE Rancher Prime" (requester wording). In the Admission scene the zoomed-out cluster sits 90 px lower to clear the taller card.

## v13 (2026-11-08) - recap with Rancher Prime
- Recap has a fourth pill "Managed: Delivered and managed from SUSE Rancher Prime" and a matching outermost dotted ring labelled "SUSE Rancher Prime". The footer line (on premises and air-gapped, built on open source, ready for the Cyber Resilience Act) is larger (36 px) and mint, on screen from 148 s to 156 s. Recap runs 134-157 s, end card 157-173 s, film 173 s.
