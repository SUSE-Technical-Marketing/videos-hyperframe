# SUSE video workspace

Videos for SUSE, built with [HyperFrames](https://hyperframes.heygen.com): each video is an HTML page that gets rendered to MP4 frame by frame, so every render is identical. This folder holds one subfolder per video, a shared toolchain, and the SUSE brand assets.

## Videos

| Project | What it is |
|---|---|
| [`suse-ai-factory`](suse-ai-factory/) | "Stop AI hacks at every step": SUSE AI Factory explainer for KubeCon NA 2026. 16:9, about 2:40, voiceover and music, ends on two QR codes. |

## Setup

You need [mise](https://mise.jdx.dev) (`brew install mise`). It installs Node and ffmpeg; the HyperFrames CLI itself is fetched on demand at a pinned version.

```bash
mise trust          # once: lets mise read mise.toml in this folder
mise install        # Node 24 + ffmpeg
mise run doctor     # shows what you will render with
```

## Everyday commands

Run these from this folder. The project name can be left out while there is only one project.

| Command | What it does |
|---|---|
| `mise run list` | list the projects |
| `mise run preview <project>` | open the Studio preview (Ctrl-C to stop) |
| `mise run check <project>` | lint, layout, motion and contrast check; run it after every change |
| `mise run render:hd <project>` | 1080p MP4 |
| `mise run render:4k <project>` | 4K MP4 (same layout, supersampled) |
| `mise run render:all <project>` | both |
| `mise run new <name>` | start a new video (see below) |

Finished files land in `<project>/renders/`:

```
suse-ai-factory/renders/suse-ai-factory-1080p.mp4
suse-ai-factory/renders/suse-ai-factory-4k.mp4
```

To render only a stretch, for a quick look at one scene, pass flags after `--` (the project name is then required). The result is saved as `...-partial.mp4`, so it never replaces a full render:

```bash
mise run render:hd suse-ai-factory -- --start 40 --end 60
```

`mise tasks` lists everything, including `preview:bg` / `preview:stop` (background preview, which is what Claude Code uses).

## Starting a new video

```bash
mise run new kubecon-recap
```

This scaffolds the project, copies in the SUSE fonts and logos from `shared/brand/`, and creates a `BRIEF.md` to fill in first: the message, where it plays, how long it is, and the source material every claim must come from. Then open the folder in [Claude Code](https://claude.com/claude-code) and ask for the video. The workflow and house style are in [`CLAUDE.md`](CLAUDE.md), which Claude reads automatically.

## Layout

```
hyperframe/
  mise.toml          tools, pinned HyperFrames version, all tasks
  CLAUDE.md          how to make a video and the SUSE style (read by Claude Code)
  scripts/lib.sh     helpers behind the tasks
  shared/brand/      SUSE fonts and official logos, copied into each new project
  <project>/
    index.html       the composition: scenes, animation, timing
    assets/          fonts, logos, voiceover, music, images (renders only read this folder)
    BRIEF.md         what the video is for, source material, version log
    renders/         output MP4s (not in git)
```

## Good to know

- **One engine version for everything.** `HYPERFRAMES_VERSION` in `mise.toml` pins the CLI, so a video re-rendered months later looks the same. To move up, change it, run `mise run check <project>`, then re-render. A project's own `npm run` scripts may pin an older version; use the mise tasks for deliverables.
- **Quality.** Renders use the `delivery` preset. Set `HF_QUALITY=draft` in front of a command for a fast, rough render.
- **Git.** Renders, caches and the downloaded music cache are ignored; sources (including voiceover and music in `assets/`) are tracked.
- **If a task says the config is not trusted,** run `mise trust` in this folder.
