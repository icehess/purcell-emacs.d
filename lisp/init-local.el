;;; init-local.el --- user customization file    -*- lexical-binding: t no-byte-compile: t -*-

(require 'init-elixir)
(require 'init-c)


;; Fonts
(defun centaur-setup-fonts ()
    "Setup fonts."
    (when (display-graphic-p)
        ;; Set default font
        (cl-loop for font in '("FantasqueSansM Nerd Font" "FantasqueSansM Nerd Font Mode" "Fantasque Sans Mono" "Cascadia Code" "Fira Code" "Jetbrains Mono"
                                  "SF Mono" "Hack" "Source Code Pro" "Menlo"
                                  "Monaco" "DejaVu Sans Mono" "Consolas")
            when (font-installed-p font)
            return (set-face-attribute 'default nil
                       :family font
                       :height (cond ((eq system-type 'darwin) 170)
                                   ((eq system-type 'windows-nt) 120)
                                   (t 120))))

        ;; Set mode-line font
        ;; (cl-loop for font in '("Menlo" "SF Pro Display" "Helvetica")
        ;;          when (font-installed-p font)
        ;;          return (progn
        ;;                   (set-face-attribute 'mode-line nil :family font :height 120)
        ;;                   (when (facep 'mode-line-active)
        ;;                     (set-face-attribute 'mode-line-active nil :family font :height 120))
        ;;                   (set-face-attribute 'mode-line-inactive nil :family font :height 120)))

        ;; Specify font for all unicode characters
        (cl-loop for font in '("Segoe UI Symbol" "Symbola" "Symbol")
            when (font-installed-p font)
            return (if (< emacs-major-version 27)
                       (set-fontset-font "fontset-default" 'unicode font nil 'prepend)
                       (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend)))

        ;; Emoji
        (cl-loop for font in '("Noto Color Emoji" "Apple Color Emoji" "Segoe UI Emoji")
            when (font-installed-p font)
            return (cond
                       ((< emacs-major-version 27)
                           (set-fontset-font "fontset-default" 'unicode font nil 'prepend))
                       ((< emacs-major-version 28)
                           (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend))
                       (t
                           (set-fontset-font t 'emoji (font-spec :family font) nil 'prepend))))

        ;; Specify font for Chinese characters
        (cl-loop for font in '("LXGW WenKai Screen" "WenQuanYi Micro Hei Mono" "PingFang SC" "Microsoft Yahei UI" "Simhei")
            when (font-installed-p font)
            return (progn
                       (setq face-font-rescale-alist `((,font . 1.3)))
                       (set-fontset-font t 'han (font-spec :family font))))))

(centaur-setup-fonts)
(add-hook 'window-setup-hook #'centaur-setup-fonts)
(add-hook 'server-after-make-frame-hook #'centaur-setup-fonts)

;; Misc.
;; (setq confirm-kill-emacs 'y-or-n-p)

;; Enable proxy
;; (proxy-http-enable)
;; (proxy-socks-enable)

;; Display on the specified monitor
;; (when (and (> (length (display-monitor-attributes-list)) 1)
;;            (> (display-pixel-width) 1920))
;;   (set-frame-parameter nil 'left 1920))

;; (put 'cl-destructuring-bind 'lisp-indent-function 'defun)
;; (put 'pdf-view-create-image 'lisp-indent-function 'defun)
;; (put 'treemacs-create-theme 'lisp-indent-function 'defun)

(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))

(custom-set-variables
    ;; custom-set-variables was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
 '(warning-suppress-log-types '((comp))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init-local)

;;; init-local.el ends here
