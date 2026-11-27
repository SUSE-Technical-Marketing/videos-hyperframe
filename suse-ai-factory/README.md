# SUSE AI Factory: "Stop AI hacks at every step"

An explainer for KubeCon NA 2026 (LinkedIn feed, 16:9). An AI agent escapes its test sandbox and roots eleven nodes; the film then walks through the layers SUSE AI Factory puts in its way, from the base container to the cluster door, and ends on two QR codes to the blogs.

**160.8 s · 1920×1080 · 30 fps · voiceover + music.** Everything is one composition, `index.html`, rendered by HyperFrames. Workspace-wide setup and style rules are in [`../README.md`](../README.md) and [`../CLAUDE.md`](../CLAUDE.md); the brief, source claims and version history are in [`BRIEF.md`](BRIEF.md).

## Render

From the workspace folder (`hyperframe/`):

```bash
mise run render:hd  suse-ai-factory     # renders/suse-ai-factory-1080p.mp4
mise run render:4k  suse-ai-factory     # renders/suse-ai-factory-4k.mp4
mise run check      suse-ai-factory     # always after an edit
mise run preview    suse-ai-factory     # Studio preview
```

The other files in `renders/` are earlier manual exports (the `161s` ones are this version) and are not in git.

## Scenes and the voice

Times are film time. Each scene starts on the first word of its topic in the voiceover and stays on screen until the narrator has finished.

| # | Scene (id) | Film time | Voice starts with |
|---|---|---|---|
| 1 | Hook (`s1`) | 0.0 – 9.5 | "July 2026. An AI agent escaped its test sandbox…" |
| 2 | SUSE AI Factory intro (`s2`) | 9.5 – 22.6 | "Here's how SUSE AI Factory stops it. Defense in depth…" |
| 3 | Base containers (`s3`) | 22.6 – 32.1 | "Built on SUSE Linux Enterprise base containers…" |
| 4 | AI dependencies (`s3b`) | 32.1 – 43.8 | "Next, the AI dependencies." |
| 5 | Kata sandbox (`s3c`) | 43.8 – 58.5 | "The agent runs in its own Kata Containers sandbox…" |
| 6 | OpenShell (`s3d`) | 58.5 – 72.0 | "NVIDIA OpenShell guards the only way out." |
| 7 | Rancher Prime (`s3h`) | 72.0 – 82.4 | "The cluster? SUSE Rancher Prime manages it…" |
| 8 | Vulnerability Scanner (`s3e`) | 82.4 – 93.1 | "SUSE Security Vulnerability Scanner checks every pod…" |
| 9 | Runtime Enforcer (`s3f`) | 93.1 – 108.1 | "Something slips through anyway? … Runtime Enforcer." |
| 10 | Admission Controller (`s3g`) | 108.1 – 122.9 | "Then the front door." |
| 11 | Recap (`s7a`) | 122.9 – 140.2 | "That's defense in depth, inside the factory and around it." |
| 12 | End card (`s7b`) | 140.2 – 160.8 | "So stop AI hacks at every step…" |

Two long-lived layers sit behind these: `factory` (9.5 – 72.0, the building, conveyor and everything on it) and `cluster` (72.0 – 122.9, the pod grid), plus the persistent logos top right (horizontal SUSE logo to 23.4 s, then the stacked AI Factory logo to the end).

**Pauses.** The narration is one recording with two pauses inserted so a scene can finish before the next starts: **0.8 s** after "…Rancher Prime, RKE2" (before OpenShell) and **2.0 s** after "…supports it with Landlock" (before "The cluster?"), long enough for the card to fade and the vault to roll off.

**End card.** The QR codes appear at 145.7 s, on "Scan the code and read the full story", and the card holds until 160.8 s: about 12 s after the voice stops, so there is time to scan.

## Audio

| Layer (`id`) | Source | Film time | Level |
|---|---|---|---|
| `voiceover`, `voiceover-b`, `voiceover-c` | `voiceover_v4.mp3`, cut in the two pauses | 0 – 160.8, with gaps at 57.5 – 58.3 and 69.8 – 71.8 | 1.0 |
| `music-bed` | `music-bed.mp3`, calm ambient | 0 – 160.8 | 0.18; dips to 0.05 from 22.5 s to 69.5 s while the factory sound plays; swells to 0.4 at 150 s, holds, fades out over the last 4 s |
| `factory-bed-a`, `factory-bed-b` | `factory-industrial.mp3`, two copies crossfaded by 2 s | 21.5 – 71.6 (door zoom to the vault leaving) | 0.12 |
| `factory-rumble` | `factory-rumble.mp3`, low drone swell | 21.4 – 30.7 | 0.2 |

The music and sound effects came from the HeyGen catalog through `media-use`; their provenance is in `.media/manifest.jsonl`.

## How the timing works (and how to change it)

The animation was authored against a draft voice, in its own "authored" time. Re-timing to the final voice does not touch the animation code. Instead, at the bottom of the script (search for `RETIME to the voiceover`) a `WARP` table of `[film time, authored time]` pairs maps the film onto the authored timeline, and the clips' `data-start` / `data-duration` are in film time. The seconds quoted in `BRIEF.md` (for example "recap 134–157 s") are authored times, not film times.

- **To change timing, ask Claude Code** ("start the Kata scene 1 s earlier", "make the pause before the cluster 1.5 s"). It moves the `WARP` rows, every clip on both sides of the change, and the audio tags together; `../CLAUDE.md` describes the method.
- **If you do it by hand:** moving a scene start means editing its `WARP` row, the `data-start`/`data-duration` of the scene on both sides, and everything after it if the film gets longer (the other scenes, the audio tags, the music automation, and the root `data-duration`). A smaller beat inside a scene (a card appearing, the vault rolling) only needs its `WARP` row.
- Keep the slope between neighbouring rows roughly between 0.7 and 1.5, or fades and typewriter text stretch visibly.
- After any change: `mise run check suse-ai-factory`, then look at frames at the voice cues with `npx hyperframes snapshot --at 58.5,72,93` (run inside this folder).

## Assets

| File | Used for |
|---|---|
| `voiceover_v4.mp3`, `voiceover_v4.transcript.json` | the narration and its word-level timestamps (334 words, 145.55 s) |
| `music-bed.mp3` | calm background music |
| `factory-industrial.mp3`, `factory-rumble.mp3` | factory sound |
| `SUSE_Logo-hor_…svg`, `SUSE-AI-Factory-Logo_…stacked.svg`, `…horizontal.svg` | official logos: hook, persistent top-right logo, factory door |
| `openshell-logo.png` | the guard in the OpenShell scene (supplied by the requester) |
| `blog-qr.png`, `ai-blog.svg` | end-card QR codes: KubeCon 2026 blog, AI Factory blog |
| `fonts/` | SUSE and SUSE Mono |
| `vendor/gsap.min.js` | animation library (vendored so renders never fetch) |
| `svg/*-on-pine.svg` | five line icons from early versions; **not used** by the current film |

## Before it goes out

The numbers and certifications on screen are the requester's wording and were not independently verified: SLSA level 3, 100 % SBOM, air-gapped, ready for the Cyber Resilience Act. The Rancher Prime card lines are general capability statements that `BRIEF.md` marks as not checked against product docs. Kata Containers, gVisor, OpenShell and Landlock are third-party technology and are named in text, never presented as SUSE products. The audio mix was set by measurement and has not been checked by ear, so listen to it once before release.
