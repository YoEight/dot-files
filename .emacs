(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(setq-default fill-column 80)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; (require 'whitespace)
;; (setq whitespace-style '(face lines-tail))
;; (setq whitespace-line-column 80)
;; (global-whitespace-mode t)

;; (add-to-list 'load-path "~/lib/emacs/haskell-mode/")
;; (require 'haskell-mode-autoloads)
(require 'speedbar)
(speedbar-add-supported-extension ".hs")
;; (add-to-list 'Info-default-directory-list "~/lib/emacs/haskell-mode/")
;;(load "~/lib/emacs/haskell-mode/haskell-site-file")
;;(set-default-font "Ubuntu Mono-10")

;; Disable tab \t character for indent
(setq-default indent-tabs-mode nil)

;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)
(tool-bar-mode -1)
(delete-selection-mode 1)
;;(setq-default tab-width 4)

(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "CamingoCode-10"))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;;(defun toggle-fullscreen (&optional f)
;;  (interactive)
;;  (let ((current-value (frame-parameter nil 'fullscreen)))
    ;; (set-frame-parameter nil 'fullscreen
    ;;                      (if (equal 'fullboth current-value)
    ;;                          (if (boundp 'old-fullscreen) old-fullscreen nil)
    ;;                        (progn (setq old-fullscreen current-value)
    ;;                               'fullboth)))))

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                 'fullboth)))))

 (defun switch-toggle-fullscreen ()
   (interactive)
     (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

(global-set-key [f11] 'switch-toggle-fullscreen)
;;(global-set-key "^" 'next-line)
(define-key key-translation-map [dead-circumflex] "^")

;; Make new frames fullscreen by default. Note: this hook doesn't do
;; anything to the initial frame if it's in your .emacs, since that file is
;; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)

;; Fontify current frame
(fontify-frame nil)

;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)
(add-to-list 'load-path "~/lib/emacs/haskell-style/")
(require 'haskell-style)
(require 'haskell-indent)
(require 'haskell-menu)
(eval-after-load "haskell-mode"
         '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

(eval-after-load "haskell-cabal"
         '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(eval-after-load "haskell-mode"
       '(progn
         (define-key haskell-mode-map (kbd "C-x C-d") nil)
         (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
         (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
         (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
         (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
         (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
         (define-key haskell-mode-map (kbd "C-c M-.") nil)
         (define-key haskell-mode-map (kbd "C-c C-d") nil)))
(add-hook 'haskell-mode-hook 'haskell-style)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
;;(add-hook 'haskell-mode-hook 'turn-on-inf-haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent) -- this one
;;(add-hook 'haskell-mode-hook 'haskell-style)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; (autoload 'ghc-init "ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

;;(add-to-list 'load-path "~/lib/emacs/scala-mode2/")
(require 'scala-mode2)
;;(add-to-list 'load-path "~/lib/emacs/scala-mode")
;;(require 'scala-mode-auto)
;; (add-to-list 'exec-path "~/lib/emacs/ensime")
;; (add-to-list 'load-path "~/lib/emacs/ensime/elisp")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(defun my-scala-save-hook ()
  (if (and (ensime-connected-p)
           (buffer-modified-p))
      (ensime-format-source))
  nil)

(add-hook 'scala-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion (my-scala-save-hook))))))

(defun lam () (interactive) (insert "λ"))
(defun alpha () (interactive) (insert "α"))
(defun beta () (interactive) (insert "β"))
(defun ceta () (interactive) (insert "γ"))


;;(setq default-input-method "MacOSX")
;;(setq mac-command-modifier 'meta)
;;(setq mac-option-modifier 'none)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(column-number-mode t)
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (fogus)))
 '(custom-safe-themes (quote ("0ebe0307942b6e159ab794f90a074935a18c3c688b526a2035d14db1214cf69c" "dc46381844ec8fcf9607a319aa6b442244d8c7a734a2625dac6a1f63e34bc4a6" "91b5a381aa9b691429597c97ac56a300db02ca6c7285f24f6fe4ec1aa44a98c3" "e26780280b5248eb9b2d02a237d9941956fc94972443b0f7aeec12b5c15db9f3" "c7359bd375132044fe993562dfa736ae79efc620f68bab36bd686430c980df1c" "7d4d00a2c2a4bba551fcab9bfd9186abe5bfa986080947c2b99ef0b4081cb2a6" "33c5a452a4095f7e4f6746b66f322ef6da0e770b76c0ed98a438e76c497040bb" "90b5269aefee2c5f4029a6a039fb53803725af6f5c96036dee5dc029ff4dff60" "29a4267a4ae1e8b06934fec2ee49472daebd45e1ee6a10d8ff747853f9a3e622" "710446afa9aea3758320ed972d79195bb13c45a11bbf407b5b577d0e7eda0ca3" "86f4407f65d848ccdbbbf7384de75ba320d26ccecd719d50239f2c36bec18628" "cff3cab936a3d2d675a8a0a6ffcfb6acb2d0c78abf3620cb04d26dbee1aa740a" "ef2df7dbeb79e0ffaba14efbd7e59aac0121c388f5d127f4b32d9dffaa973b1f" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "31bfef452bee11d19df790b82dea35a3b275142032e06c6ecdc98007bf12466c" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "52b5da0a421b020e2d3429f1d4929089d18a56e8e43fe7470af2cea5a6c96443" default)))
 '(display-time-mode t)
 '(exec-path (quote ("/home/yorick/lib/emacs/ensime/bin" "/usr/bin" "/home/yorick/.cabal/bin")))
 '(fci-rule-color "#383838")
 '(foreground-color "#839496")
 '(haskell-program-name "ghci \"+.\"")
 '(haskell-tags-on-save nil)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#073642" . 0) ("#546E00" . 20) ("#00736F" . 30) ("#00629D" . 50) ("#7B6000" . 60) ("#8B2C02" . 70) ("#93115C" . 85) ("#073642" . 100))))
 '(inhibit-startup-screen t)
 '(linum-format " %7i ")
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "mail.gandi.net")
 '(smtpmail-smtp-service 587)
 '(vc-annotate-background "#2b2b2b")
 '(vc-annotate-color-map (quote ((20 . "#bc8383") (40 . "#cc9393") (60 . "#dfaf8f") (80 . "#d0bf8f") (100 . "#e0cf9f") (120 . "#f0dfaf") (140 . "#5f7f5f") (160 . "#7f9f7f") (180 . "#8fb28f") (200 . "#9fc59f") (220 . "#afd8af") (240 . "#bfebbf") (260 . "#93e0e3") (280 . "#6ca0a3") (300 . "#7cb8bb") (320 . "#8cd0d3") (340 . "#94bff3") (360 . "#dc8cc3"))))
 '(vc-annotate-very-old-color "#dc8cc3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(load-file (let ((coding-system-for-read 'utf-8))
;;                (shell-command-to-string "agda-mode locate")))
