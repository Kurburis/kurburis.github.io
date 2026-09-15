;;; Load with M-x load-file to enable ox-hugo for this Emacs session.
(let ((root (file-name-directory (directory-file-name
                                 (file-name-directory load-file-name)))))
  (add-to-list 'load-path (expand-file-name ".tools/ox-hugo" root)))
(require 'ox-hugo)
(load (expand-file-name "citations.el" (file-name-directory load-file-name)) nil t)
(message "ox-hugo ready: use C-c C-e H H in a website Org file")
