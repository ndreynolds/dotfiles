;;; Basic Config

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

(setq linum-format " %4d ")
(global-linum-mode 1)

(line-number-mode 1)
(column-number-mode 1)

(setq-default indent-tabs-mode nil)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 160
                    :weight 'normal
                    :width 'normal)

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;; Package Init

(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)


;;; Package Configuration

(use-package flx :demand t)
(use-package counsel :demand t)
(use-package counsel-projectile :demand t)
(use-package swiper)
(use-package ivy
  :demand t
  :init
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy)))
  :config
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x))

(use-package projectile
  :init
  (setq projectile-completion-system 'ivy)
  :config
  (projectile-mode +1))

(use-package evil
  :init
  (setq evil-want-Y-yank-to-eol t)
  :config
  (evil-mode 1)
  (evil-set-initial-state 'term-mode 'emacs))

(use-package evil-commentary
  :config
  (evil-commentary-mode))

(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1))

(use-package evil-magit)

(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ;; Buffers
    "b" 'counsel-switch-buffer
    "<left>" 'previous-buffer
    "<right>" 'next-buffer

    ;; Projects
    "p" 'counsel-projectile-switch-project
    "<SPC>" 'counsel-projectile-find-file
    "s" 'counsel-projectile-git-grep

    ;; Git
    "g" 'magit-status

    ;; Notes
    "n" '(lambda () (interactive) (counsel-find-file "~/org/"))

    ;; Misc
    "w" '(lambda () (interactive) (counsel-find-file "~/code/wiki/wikidata/"))
    "z" '(lambda () (interactive) (find-file "~/.emacs.d/init.el"))))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package elixir-mode
  :commands elixir-mode
  :mode "\\.exs?\\'")

(use-package fish-mode
  :mode "\\.fish\\'")

(use-package haskell-mode
  :mode (("\\.hs\\(c\\|-boot\\)?\\'" . haskell-mode)
         ("\\.lhs\\'" . literate-haskell-mode)
         ("\\.cabal\\'" . haskell-cabal-mode)))

(use-package ruby-mode
  :mode "\\.rb\\'")

(use-package solarized-theme
  :demand t
  :config
  (load-theme 'solarized-light t))

(use-package org-mode
  :commands org-mode
  :mode ("\\.org\\'" "\\.page\\'"))
