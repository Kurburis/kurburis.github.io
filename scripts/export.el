;;; Export this website without loading the personal Emacs configuration.
(let* ((root (file-name-directory (directory-file-name
                                 (file-name-directory load-file-name))))
       (enable-local-variables nil)
       (enable-local-eval nil)
       (org-export-use-babel nil))
  (add-to-list 'load-path (expand-file-name ".tools/ox-hugo" root))
  (require 'ox-hugo)
  (load (expand-file-name "scripts/citations.el" root) nil t)
  (dolist (file (directory-files (expand-file-name "org" root) t "\\.org$"))
    (with-current-buffer (find-file-noselect file)
      (let ((org-confirm-babel-evaluate t))
        (org-hugo-export-to-md)))))
