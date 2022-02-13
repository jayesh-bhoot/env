(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(cond
  ((eq system-type 'darwin) (set-frame-font "MonoLisa 16" nil t))
  ((eq system-type 'gnu/linux) (set-frame-font "MonoLisa 16" nil t)))
(set-face-bold-p 'bold nil)
(global-visual-line-mode 1)
(setq sentence-end-double-space nil) 
(setq-default line-spacing 5) 

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(package-selected-packages (quote (htmlize ox-hugo)))
  '(user-mail-address "jayesh@bhoot.sh"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

