(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(setq-default fill-column 80)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; Disable tab \t character for indent
(setq-default indent-tabs-mode nil)

;; (defun fontify-frame (frame)
;;   (set-frame-parameter frame 'font "Terminus-10")) ;;"PragmataPro-10"))

;;(fontify-frame nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(tool-bar-mode -1)
(menu-bar-mode -1)
(delete-selection-mode 1)
;;(setq-default line-spacing 5)

(setq show-paren-delay 0)
(setq visible-bell 1)
(show-paren-mode 1)
(column-number-mode 1)
(scroll-bar-mode -1)
;; (speedbar 1)
;; (speedbar-add-supported-extension ".scala")
;; (speedbar-add-supported-extension ".hs")

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                 'fullboth)))))

(define-key key-translation-map [dead-circumflex] "^")

;; Make new frames fullscreen by default. Note: this hook doesn't do
;; anything to the initial frame if it's in your .emacs, since that file is
;; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)

;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)
(add-to-list 'load-path "~/lib/emacs/haskell-style/")
(require 'haskell-style)
(require 'haskell-indent)
;;(require 'haskell-menu)

(add-hook 'haskell-mode-hook 'haskell-style)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
;;(add-hook 'haskell-mode-hook 'turn-on-inf-haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector
   [unspecified "#202020" "#ac4142" "#90a959" "#f4bf75" "#6a9fb5" "#aa759f" "#6a9fb5" "#e0e0e0"] t)
 '(background-color "#002b36")
 '(background-mode dark)
 '(column-number-mode t)
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (grandshell)))
 '(custom-safe-themes
   (quote
    ("a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "2b5aa66b7d5be41b18cc67f3286ae664134b95ccc4a86c9339c886dfd736132d" "ad9fc392386f4859d28fe4ef3803585b51557838dbc072762117adad37e83585" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "96b023d1a6e796bab61b472f4379656bcac67b3af4e565d9fb1b6b7989356610" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "024b0033a950d6a40bbbf2b1604075e6c457d40de0b52debe3ae994f88c09a4a" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a233249cc6f90098e13e555f5f5bf6f8461563a8043c7502fb0474be02affeea" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "7ed6913f96c43796aa524e9ae506b0a3a50bfca061eed73b66766d14adfa86d1" "2affb26fb9a1b9325f05f4233d08ccbba7ec6e0c99c64681895219f964aac7af" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(fci-rule-color "#f6f0e1")
 '(foreground-color "#839496")
 '(gnus-logo-colors (quote ("#0d7b72" "#adadad")))
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")))
 '(haskell-tags-on-save t)
 '(inhibit-startup-screen t)
 '(linum-format " %7i ")
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#f6f0e1")
 '(vc-annotate-color-map
   (quote
    ((20 . "#e43838")
     (40 . "#f71010")
     (60 . "#ab9c3a")
     (80 . "#9ca30b")
     (100 . "#ef8300")
     (120 . "#958323")
     (140 . "#1c9e28")
     (160 . "#3cb368")
     (180 . "#028902")
     (200 . "#008b45")
     (220 . "#077707")
     (240 . "#259ea2")
     (260 . "#358d8d")
     (280 . "#0eaeae")
     (300 . "#2c53ca")
     (320 . "#0000ff")
     (340 . "#0505cc")
     (360 . "#a020f0"))))
 '(vc-annotate-very-old-color "#a020f0"))
;; (autoload 'ghc-init "ghc" nil t)
;; (autoload 'ghc-debug "ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; (defun my-scala-save-hook ()
;;   (if (and (ensime-connected-p)
;;            (buffer-modified-p))
;;       (ensime-format-source))
;;   nil)

;; (add-hook 'scala-mode-hook
;;           (lambda()
;;             (add-hook 'local-write-file-hooks
;;                       '(lambda()
;;                          (save-excursion (my-scala-save-hook))))))

(defun lam () (interactive) (insert "λ"))
(defun alpha () (interactive) (insert "α"))
(defun beta () (interactive) (insert "β"))
(defun ceta () (interactive) (insert "γ"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminus" :foundry "xos4" :slant normal :weight normal :height 105 :width normal)))))
