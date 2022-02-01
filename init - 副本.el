;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;; (setq debug-on-error t)


;; 版本校验
(let ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "26.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

;;(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ; 设定源码加载路径
;;(require 'init-benchmarking) ;; Measure startup time


;; 定义常量
(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;; Adjust garbage collection thresholds during startup, and thereafter

(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))


;; boot config


;; 设置仓库镜像
(setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
                         ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))

(require 'package)

;; 设置仓库
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; (add-to-list 'load-path (expand-file-name "elpa" user-emacs-directory))

(eval-when-compile
  (add-to-list 'load-path (expand-file-name "elpa/use-package-20210207.1926" user-emacs-directory))
  (add-to-list 'load-path (expand-file-name "elpa/bind-key-20210210.1609" user-emacs-directory))
  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字 
  (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t 
  (setq use-package-always-demand nil) 
  (setq use-package-expand-minimally t) 
  (setq use-package-verbose t)
  (require 'use-package))

;; (use-package init-zhoujp)


;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))


(setq inhibit-compacting-font-caches t)

(setq custom-file (locate-user-emacs-file "custom.el"))


(use-package init-benchmarking :defer t)
;; (require 'init-utils)
(use-package init-utils :defer t)
;; (require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
(use-package init-site-lisp :defer t)
;; Calls (package-initialize)
;; (require 'init-elpa)      ;; Machinery for installing required packages
(use-package init-elpa :defer t)
;; (require 'init-exec-path) ;; Set up $PATH
(use-package init-exec-path :defer t)


;; Allow users to provide an optional "init-preload-local.el"
;; (require 'init-preload-local nil t)
;; (use-package init-preload-local)

;; Load configs for specific features and modes
;; (require-package 'diminish)
(use-package diminish :defer t)
;; (maybe-require-package 'scratch)
;; (require-package 'command-log-mode)
(use-package command-log-mode :defer t)
;; (require 'init-frame-hooks)
(use-package init-frame-hooks :defer t)
;; (require 'init-xterm)
(use-package init-xterm :defer t)
;; (require 'init-themes)
(use-package init-themes :defer t)
;; (require 'init-osx-keys)
(use-package init-osx-keys :defer t)
;; (require 'init-gui-frames)
(use-package init-gui-frames :defer t)
;; (require 'init-dired)
(use-package init-dired :defer t)
;; (require 'init-isearch)
(use-package init-isearch :defer t)
;; (require 'init-grep)
(use-package init-grep :defer t)
;; (require 'init-uniquify)
(use-package init-uniquify :defer t)
;; (require 'init-ibuffer)
(use-package init-ibuffer :defer t)
;; (require 'init-flycheck)
(use-package init-flycheck :defer t)
;; (require 'init-recentf)
(use-package init-recentf :defer t)
;; (require 'init-minibuffer)
(use-package init-minibuffer :defer t)
;; (require 'init-hippie-expand)
(use-package init-hippie-expand :defer t)
;; (require 'init-company)
(use-package init-company :defer t)
;; (require 'init-windows)
(use-package init-windows :defer t)
;; (require 'init-sessions)
(use-package init-sessions :defer t)
;; (require 'init-mmm)
(use-package init-mmm :defer t)

;; (require 'init-editing-utils)
(use-package init-editing-utils :defer t)
;; (require 'init-whitespace)
(use-package init-whitespace :defer t)

;; (require 'init-vc)
(use-package init-vc :defer t)
;; (require 'init-darcs)
(use-package init-darcs :defer t)
;; (require 'init-git)
(use-package init-git :defer t)
;; (require 'init-github)
(use-package init-github :defer t)

;; (require 'init-projectile)
(use-package init-projectile :defer t)

;; (require 'init-compile)
(use-package init-compile :defer t)
;; (require 'init-crontab)
(use-package init-crontab :defer t)
;; (require 'init-textile)
(use-package init-textile :defer t)
;; (require 'init-markdown)
(use-package init-markdown :defer t)
;; (require 'init-csv)
(use-package init-csv :defer t)
;; (require 'init-erlang)
;; (require 'init-javascript)
;; (use-package init-javascript :defer t)
;; (require 'init-php)
;; (require 'init-org)
(use-package init-org :defer t)
;; (require 'init-nxml)
;; (require 'init-html)
;; (require 'init-css)
;; (require 'init-haml)
;; (require 'init-http)
(use-package init-http :defer t)
;; (require 'init-python)
(use-package init-python :defer t)
;; (require 'init-haskell)
(use-package init-haskell :defer t)
;; (require 'init-elm)
(use-package init-elm :defer t)
;; (require 'init-purescript)
;; (require 'init-ruby)
;; (require 'init-rails)
;; (require 'init-sql)
(use-package init-sql :defer t)
;; (require 'init-ocaml)
;; (require 'init-j)
(use-package init-j :defer t)
;; (require 'init-nim)
(use-package init-nim :defer t)
;; (require 'init-rust)
;; (require 'init-toml)
;; (require 'init-yaml)
(use-package init-yaml :defer t)
;; (require 'init-docker)
(use-package init-docker :defer t)
;; (require 'init-terraform)
(use-package init-terraform :defer t)
;; (require 'init-nix)
(use-package init-nix :defer t)
;; (maybe-require-package 'nginx-mode)

;; (require 'init-paredit)
;; (require 'init-lisp)
(use-package init-lisp :defer t)
;; (require 'init-slime)
(use-package init-slime :defer t)
;; (require 'init-clojure)
(use-package init-clojure :defer t)
;; (require 'init-clojure-cider)
(use-package init-clojure-cider :defer t)
;; (require 'init-common-lisp)
(use-package init-common-lisp :defer t)


(when *spell-check-support-enabled*
  ;;   (require 'init-spelling))
  (use-package init-spelling :defer t))

;; (require 'init-misc)
(use-package init-misc :defer t)

;; (require 'init-folding)
(use-package init-folding :defer t)
;; (require 'init-dash)
(use-package init-dash :defer t)

;;(require 'init-twitter)
;; (require 'init-mu)

;; (require 'init-ledger)
(use-package init-ledger :defer t)
;; Extra packages which don't require any configuration

;; (require-package 'sudo-edit)
(use-package sudo-edit :defer t)
;; (require-package 'gnuplot)
(use-package gnuplot :defer t)
;; (require-package 'lua-mode)
(use-package lua-mode :defer t)
;; (require-package 'htmlize)
(use-package htmlize :defer t)
;; (when *is-a-mac*
;;   (require-package 'osx-location))
;; (maybe-require-package 'dotenv-mode)
;; (maybe-require-package 'shfmt)

;; (when (maybe-require-package 'uptimes)
;;  (setq-default uptimes-keep-count 200)
;;  (add-hook 'after-init-hook (lambda () (require 'uptimes))))

;;(when (fboundp 'global-eldoc-mode)
;;  (add-hook 'after-init-hook 'global-eldoc-mode))

;; (require 'init-direnv)
(use-package init-direnv :defer t)


;; Allow access from emacsclient
;; (add-hook 'after-init-hook
;;          (lambda ()
;;            (require 'server)
;;            (unless (server-running-p)
;;              (server-start))))

;; Variables configured via the interactive 'customize' interface
;; (when (file-exists-p custom-file)
;;  (load custom-file))

;; Locales (setting them earlier in this file doesn't work in X)
;; (require 'init-locales)

;; Allow users to provide an optional "init-local" containing personal settings
;; (require 'init-local nil t)

;; (require 'init-zhoujp)

(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-bright))
 '(package-selected-packages
   '(wgrep anzu diff-hl diredfl disable-mouse default-text-scale dimmer color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized exec-path-from-shell gnu-elpa-keyring-update fullframe seq)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
