# AGENTS

## Project overview
- Jekyll static site using the Just the Docs theme, published on GitHub Pages.
- Content is mainly lab materials and course notes.

## Content locations
- `_labs/` for lab pages (front matter: `layout: lab`, `course`, `type`, `lab_nr`, `subject`, `description`).
- `_exercises/` for exercise sheets (front matter: `layout: exercise`, `course`, `type`, `lab_nr`, `topic`).
- `_announcements/` for announcements (front matter: `layout: default`, `type`, `title`).
- `assets/` for images and downloads.
- `_site/` is generated output; do not edit by hand.

## Local preview
- `bundle install`
- `bundle exec jekyll serve`

## Conventions
- Filenames usually encode course and number (for example `RTO-7.md`, `ex_RBD_1.md`, `2024-01-10-*.md`).
- Keep YAML front matter at the top of each content file.
