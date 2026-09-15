;;; Load the website's self-contained CSL export support.
(let* ((root (file-name-directory (directory-file-name
                                 (file-name-directory load-file-name))))
       (deps (expand-file-name "vendor/citation" root)))
  (dolist (name '("citeproc" "dash" "s" "f" "queue" "string-inflection" "parsebib" "compat"))
    (add-to-list 'load-path (expand-file-name name deps)))
  (require 'oc-csl)
  (setq org-cite-csl-locales-dir deps)
  (with-eval-after-load 'ox-hugo
    (setq org-hugo-citations-plist '(:bibliography-section-heading "Publications"))))
