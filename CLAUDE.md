# SUSE video workspace (HyperFrames)

This folder holds several video projects, one subfolder each, all built with HyperFrames (HTML rendered to video by seeking a paused GSAP timeline). Each project has its own generated `CLAUDE.md` / `AGENTS.md` with the framework rules. **This file covers what is shared: how we make a video and what it should look like.** Start every HyperFrames job with the `/hyperframes` skill, as the project files say.

```
hyperframe/
  mise.toml            tools (node, ffmpeg), the pinned CLI version, all tasks
  scripts/lib.sh       helpers the tasks use
  shared/brand/        SUSE fonts and logos, copied into every new project
  <project>/           index.html, assets/, BRIEF.md, renders/   (renders/ is git-ignored)
```

## Commands

Run from this folder. The project name can be left out only when there is a single project.

```bash
mise install                          # node 24 + ffmpeg
mise run list                         # projects
mise run new <name>                   # scaffold + brand assets + BRIEF.md
mise run check <project>              # lint, layout, motion, contrast: run after every change
mise run preview:bg <project>         # Studio preview for review (agents use :bg, then preview:stop)
mise run render:hd  <project>         # <project>/renders/<project>-1080p.mp4
mise run render:4k  <project>         # <project>/renders/<project>-4k.mp4  (same layout, supersampled)
mise run render:all <project>         # both
mise run render:hd <project> -- --start 40 --end 60   # extra flags go after --; writes *-partial.mp4
```

One CLI version (`HYPERFRAMES_VERSION` in `mise.toml`) renders every project. Projects' own `npm run` scripts may pin an older one; use the mise tasks for deliverables.

## Making a video

1. **Brief first.** Fill `BRIEF.md` (message, destination, aspect, length, whether there is a voiceover). Everything the video claims must come from the requester's material in there. Keep a short version log in it: what changed and why.
2. **Copy before pictures.** Write the scene list and the on-screen copy as words, get a yes, then build. One idea per scene, a header plus at most three short lines.
3. **Build in one `index.html`** (root timeline, one scene `<section class="clip">` per beat). Procedural animation is a pure function of time `t` driven from one linear proxy tween, so any seek renders the same frame. No `Math.random`, no `Date.now`.
4. **Voiceover leads, the picture follows.** When there is a voice, record or generate it before polishing the visuals, then time to it (next section).
5. **Verify before every handoff.** `mise run check`, then `npx hyperframes snapshot --at <times of the voice cues>` and look at the frames. For audio, `ffmpeg -i out.mp4 -vn -af volumedetect -f null -` (aim for a mean near -18 dB, peak under -1 dB). Short test renders with `-- --start/--end` are cheap; do them for anything audible.
6. **Deliver.** `render:all`. Report length, resolution and anything you could not check (you cannot listen to audio).

### Timing the picture to a voiceover

Authoring against a draft voice and re-timing afterwards is normal; do not rewrite tweens by hand.

1. `npx hyperframes transcribe assets/<voice>.mp3 -m medium.en` gives word-level timestamps. Group them into sentences and note when each scene's topic is first spoken.
2. Keep the authored timeline `tl` as it is and drive it through a time map. **Anchors** are `[authoredTime, filmTime]` pairs, one per scene start plus a few inner beats:

   ```js
   const WARP = [[0,0],[24,22.58],[36,32.08] /* …[film, authored] pairs … */];
   const warp = (T) => { for (let i = 0; i < WARP.length - 1; i++) { const [n0,a0]=WARP[i],[n1,a1]=WARP[i+1];
     if (T <= n1) return a0 + (Math.max(T,n0)-n0)*(a1-a0)/(n1-n0); } return WARP[WARP.length-1][1]; };
   const film = gsap.timeline({ paused: true }), drive = { t: 0 };
   film.fromTo(drive, {t:0}, {t:LENGTH, duration:LENGTH, ease:"none", onUpdate:()=>tl.time(warp(drive.t), false)}, 0);
   window.__timelines["main"] = film;          // register film, not tl
   ```
   Every clip's `data-start`/`data-duration` must be mapped through the same table, and the root `data-duration` set to the film length.
3. Keep slopes between roughly 0.7 and 1.5 around fades and typewriters. If a mapping would stretch a fade more than 2x, move the authored cue instead of adding an anchor.
4. Scene change on a spoken topic change: the new scene starts on the first word of the new topic, and the old scene stays on screen until the voice has finished its last word. Give scene switches room: 0.8 s of silence for a topic change, about 2 s when something leaves the frame (a vault rolling off, a zoom out).
5. To add a pause, split the voiceover in the silence between two words into clips with `data-media-start`, start each later clip later, and shift every anchor after the cut by the pause. Cut inside the gap, never inside a word.
6. Words and visuals meet at the spoken moment: text may appear up to about half a second before its words, never after them, and reveals follow the order the voice says them.

## House style: SUSE

**Canvas.** 1920×1080, 30 fps, 16:9. 4K is produced by supersampling, never by authoring at 3840. Keep text inside the 90 % action-safe area (72 px left margin is the rule) and key text inside 80 %.

**Type.** `SUSE` for everything, weight 400 body / 500 headings. `SUSE Mono` (500) for datelines, URLs, code, labels and captions. Both fonts live in `shared/brand/fonts/` and must be loaded with `@font-face` from `assets/fonts/`. Sentence case, no all caps, no emoji.

**Palette.** Dark pine background, one calm green family, one warm accent that means *attention*.

| Token | Hex | Use |
|---|---|---|
| `--pine` | `#0c322c` | background |
| `--pine2` | `#01564a` | tiles, pods, recessed shapes |
| `--jungle2` | `#025937` | cards |
| `--jungle` | `#30ba78` | pills, bullet marks on cards, success |
| `--mint` | `#90ebcd` | secondary text, datelines, accents, caret |
| `--persimmon` | `#fe7c3f` | the attacker or threat, product names in headers, warnings. Sparingly. |
| `--fog6` | `#bababa` | scene headers, quiet text |
| `--white` | `#ffffff` | hook and end-card titles, body text on cards |

**Components** (copy the markup of an existing scene instead of inventing variants).
- **Scene header:** top 80 px, left 72 px, 56 px / 500, colour fog, product names wrapped in a persimmon `.hl` span. Chapter headers use the typewriter reveal (24 characters/s, mint caret). Hook and end-card titles are white and larger (62 to 72 px).
- **Bullets always go in a card, never loose.** Card: `--jungle2`, 24 px radius, soft drop shadow, left 72 / top about 290, 880 px wide, 40 px lines, small mint square marks. Card appears first, then the lines one by one. Several categories in one card: each gets a jungle pill (30 px, pine text) with its explanation underneath.
- **Persistent logo, top right:** the horizontal SUSE logo for a hook; once the product is introduced, the stacked product logo (about 138×124 at 1710/52). Never both at once, never redrawn: use the files in `shared/brand/logos/`.
- **Illustration:** flat 2D, drawn as inline SVG in the palette above, rounded corners, consistent line weight. No photos, gradients, stock icons or 3D. Persimmon is reserved for the thing that should worry the viewer. Logos of other products only when the requester supplied the file; otherwise name them in text.
- **End card:** white title, mint subline, `SUSE Mono` links, one white rounded QR code per link (at least 360 px) with a small mono caption under it ("KubeCon 2026 blog"). Two links means two codes side by side, links listed under them.

**Motion.** Calm and deliberate; the viewer has to read.
- Reveals: fade up 0.6 s, `power3.out`, rising 28 px (14 to 30 px for small items). Exits: fade 0.5 s, `power2.in`. Stagger related items by 0.4 to 1 s.
- Camera moves (zooms, pans) 2 to 2.4 s with ease-in-out. Scene changes are fades or camera moves, no wipes or spins.
- Hold the final frame; never loop.

**Sound.** A voiceover video gets a bed of calm ambient music at about 0.18, swelling to 0.4 once the voice has ended and fading out over the last 4 s. For a chapter that has a place (the factory), add a matching bed (industrial, about 0.12) and a one-shot ambience (about 0.2), dip the calm bed to about 0.05 underneath and crossfade clip copies by 2 s. Sound effects are rare and quiet. Find music and effects with `npx hyperframes media-use resolve --type bgm|sfx --intent "..."`.

**Pacing.** Short films in this style run 2 to 3 minutes at about 140 words a minute, a new scene every 10 to 15 s. The end card holds at least 12 s after the voice so people can scan the codes.

## Facts and data

- Only claim what the requester's brief says. Numbers and certifications they supplied (SLSA level, SBOM coverage, air-gapped, regulatory readiness) are theirs: copy them exactly and note "requester-supplied, not independently verified" in `BRIEF.md`.
- Name products exactly: SUSE AI Factory, SUSE Application Collection, SUSE Rancher Prime, SUSE Security Vulnerability Scanner / Runtime Enforcer / Admission Controller, SUSE Linux Enterprise. Third-party technology (Kata Containers, gVisor, NVIDIA OpenShell, Landlock) is never presented as a SUSE product.
- Keep the spelling the project already uses on screen (the AI Factory film writes "Defence in depth").
- No credentials, tokens, customer data or personal data in compositions, briefs or transcripts. If something sensitive turns up in source material, redact it and tell the requester.
