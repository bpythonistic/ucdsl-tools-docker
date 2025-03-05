;; melpa packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; electric indent
(setq electric-indent-mode nil) 

;; uc file syntax highlighting
;; (require 'merlin)
;; (autoload 'merlin-mode "merlin" nil t nil)
;; (add-hook 'tuareg-mode-hook 'merlin-mode t)

;; uc mode
(require 'ucdsl-mode)
(add-to-list 'auto-mode-alist '("\\.uc\\'" . ucdsl-mode))
(setq exec-path
    (append
    '("/home/headless/.opam/5.1.1/bin")
    exec-path))
(setenv "PATH"
    (concat
        "/home/headless/.opam/5.1.1/bin:/usr/bin/z3:"
        (getenv "PATH")))

;; Set the coding system
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; Change warning level
(setq warning-minimum-level :emergency)

;; Disable welcome screen
(setq inhibit-startup-screen t)

;; move where backup files are placed
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; User version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
)
