# Personal research website

Catppuccin Mocha PaperMod with a mauve accent and IBM Plex Mono. Write content in Org files.

## Preview

The build tools are already available in this workspace. Run:

```sh
make serve
```

Open http://localhost:1313. Stop the server with `Ctrl-C`.

For a fresh checkout, install Emacs, Make, curl, and tar first. Then run:

```sh
make setup
make serve
```

The setup script downloads pinned ox-hugo dependencies and Hugo 0.166.0 for Linux x86_64.
On other platforms, install Hugo 0.166.0 separately.

## Write content

| Org source | Page |
| --- | --- |
| `org/bio.org` | Homepage: introduction, education, experience, awards |
| `org/papers.org` | Papers |
| `org/team.org` | Team |
| `org/datasets.org` | Datasets |

Replace the sample text with your information. Change the site name and description in `hugo.toml`.
Keep the export keywords at the top of each Org file.
Use normal Org headings, lists, and links:

```org
* 2026
** Paper title
Author names · Venue

A short description.

[[https://example.org/paper.pdf][PDF]] · [[https://github.com/OWNER/REPO][Code]]
```

Export after each edit with `make export`. Hugo refreshes the preview when the generated Markdown changes.
The `content/` directory contains generated Markdown. Edit its Org sources instead.
GitHub Actions exports the Org files again before each deployment.

## Doom Emacs

Your local Doom configuration enables `(org +roam2 +dragndrop +hugo)` in `~/nixos-config/doom/init.el`.
After package synchronization, restart Emacs to activate the exporter.

For this session, run `M-x load-file` and select `scripts/doom.el` from this project.
This loads the downloaded exporter without changing your Doom configuration.
Open an Org file, then press `C-c C-e H H` to export it.
You can also run `M-x org-hugo-export-to-md`.

For permanent installation, add this declaration to your Doom `packages.el`:

```elisp
(package! ox-hugo
  :recipe (:host github :repo "kaushalmodi/ox-hugo")
  :pin "b7dc44dc28911b9d8e3055a18deac16c3b560b03")
```

Add this configuration to your Doom `config.el`:

```elisp
(after! ox
  (require 'ox-hugo))
```

Run `doom sync`, then restart Emacs. Use the session loader or permanent installation as needed.
The project build works independently of your personal Doom configuration.

## Publish with GitHub Pages

1. Create a GitHub repository. Use `USERNAME.github.io` for a personal site at the domain root.
2. Set `baseURL` in `hugo.toml` to your website URL, including its final slash.
3. Commit the project files, including `themes/PaperMod`, and push them to the repository's `main` branch.
4. Open the repository's **Settings → Pages**.
5. Select **GitHub Actions** as the source.
6. Run **Publish website** from the **Actions** tab if the first push did not deploy.

The workflow exports Org, builds Hugo, and deploys the `public/` directory.
Later pushes to `main` publish automatically.
The workflow obtains the deployment URL from GitHub Pages, including a project repository subpath.

GitHub publishing is not connected yet. This workspace does not currently contain an initialized Git repository.

## Design

- Colors, spacing, and typography: `assets/css/extended/research.css`
- Homepage layout: `layouts/home.html`
- Local fonts: `static/fonts/`
- Font declarations: `layouts/_partials/extend_head.html`
- Navigation and site settings: `hugo.toml`

Keep custom changes outside `themes/PaperMod` to simplify theme updates.
The current theme emits two Hugo deprecation warnings. They do not prevent the build.

## References

- [ox-hugo usage](https://ox-hugo.scripter.co/doc/usage/)
- [PaperMod](https://github.com/adityatelange/hugo-PaperMod)
- [Hugo on GitHub Pages](https://gohugo.io/host-and-deploy/host-on-github-pages/)
- [Third-party versions and licenses](THIRD_PARTY.md)

## Papers with Citar

`org/papers.org` uses native Org citations. Citar provides the selection menu in Emacs.
The file reads `org/publications.bib`, a copy of your publication metadata from Zotero.
It contains nine distinct publications after four duplicate records were removed.
The import keeps bibliographic fields and omits attachment paths, abstracts, and personal notes.
Your Zotero library remains unchanged. This copy does not synchronize automatically.

To add an existing entry:

1. Open `org/papers.org` in Doom Emacs.
2. Put the cursor inside its `[cite/nocite:...]` expression.
3. Run `M-x citar-insert-citation` and select the entry.
4. Save the file.
5. Run `make export` or press `C-c C-e H H`.

The `nocite` style selects entries for the bibliography without an inline citation.
`#+print_bibliography:` renders the selected publications.
The project CSL style sorts them by date, newest first, and includes venue and DOI links.
Long author lists use “et al.”; full author lists remain in the bibliography file.

For a new publication, copy its BibTeX entry into `org/publications.bib` first.
Keep its citation key identical to Zotero's key. Copy public metadata fields only.
Then select that entry with Citar in the Org file.

Example:

```org
#+bibliography: publications.bib
#+cite_export: csl publications.csl

[cite/nocite:@krilasevicLearningGeneralizedNash2023]

#+print_bibliography:
```

The build loads citation dependencies from `vendor/citation/`.
Doom already has `citeproc` installed. `scripts/doom.el` also loads the project citation configuration when needed.
CSL export produces HTML, so Hugo permits HTML in the Markdown generated from your Org files.

Source: [Org citations in ox-hugo](https://ox-hugo.scripter.co/doc/org-cite-citations/).
