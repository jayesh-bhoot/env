(require 'package)
;; built-in GNU ELPA and MELPA are the only ones required.
;; There is MELPA and MELPA stable. But the latter has very few number of packages.
;; So use normal MELPA only.
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
 
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(cond
 ((eq system-type 'darwin) (set-frame-font "Consolas 18" nil t))
 ((eq system-type 'gnu/linux) (set-frame-font "Consolas 13" nil t)))
(set-face-bold-p 'bold nil)
(global-visual-line-mode 1) ; wrap lines
(setq sentence-end-double-space nil) ; enable single space after punctuation for M-a and M-e
; why not setq? Just for information, evaluating (setq line-spacing 2) in a buffer increases the line spacing.
; You can add (setq-default line-spacing 2) to your .emacs file to change it globally.
; setq wouldn't work because line-spacing is a buffer-local variable.
(setq-default line-spacing 5) 


(setq org-special-ctrl-a/e t)
(setq org-refile-targets '(nil . (:maxlevel 10)))
(setq org-tags-column 0)
(setq org-cycle-separator-lines -1)
(setq org-startup-indented t)
(setq org-M-RET-may-split-line nil)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-todo-keywords '((sequence "TODO" "|" "DONE" "CNCL")))

(setq org-publish-project-alist
      '(("bhoot.sh"
	 :base-directory "~/projects/bhoot.sh"
	 :publishing-directory "~/projects/bhoot.sh"
	 :publishing-function org-html-publish-to-html
	 :link-home "index.html"
	 :with-title nil
	 :html-postamble nil
	 :html-preamble  "
<h1 class=\"title\">%t</h1>
<p class=\"author\">Author: %a</p>
<p class=\"date\">Created: %d</p>
<p class=\"date\">Last Updated: %C</p>
")))

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

