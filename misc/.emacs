(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

; Follow buffers
(setq mouse-autoselect-window t)

(ctags-global-auto-update-mode)
(setq ctags-update-prompt-create-tags nil);you need manually create TAGS in your project

; jvd
(setenv "PATH" (concat (getenv "PATH") ":/Users/jdonsel/bin"))
(setq exec-path (append exec-path '("/Users/jdonsel/bin")))



(setq inhibit-splash-screen t)
(setq visible-bell nil)
;(setq tags-file-name "~/tags")

; truncate lines
(setq-default truncate-lines nil)
; enable column numbering
(column-number-mode t)
; Yank will overwrite current selection
(delete-selection-mode 1)

;(setq elpy-rpc-virtualenv-path ’current)

; no backups
; line numbers
;(global-linum-mode 1)
(setq make-backup-files nil)
; Highlight current line
(setq global-hl-line-mode t)
(setq grep-command "grep -r -nH ")
; Sentences end in a period and a single space
(setq sentence-end-double-space nil)
; Count lines even if they are long
(setq line-number-display-limit-width 10000)
;; yes-or-no -> y-or-n
(fset 'yes-or-no-p 'y-or-n-p)
; Treat '_' as a word character
(setq c-mode-hook '(lambda ()   (modify-syntax-entry ?_ "w")))
; Force horizontal splitting                                                                                                                 
(setq split-width-threshold nil)
(global-set-key [f3] 'buffer-menu)
(global-set-key [f4] 'find-file)
; revert buffer
(global-set-key "\M-r" 'revert-buffer)
(global-set-key [(control x) (control b)] 'buffer-menu)
(global-set-key "\C-]" 'comment-end-of-function)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-o") 'open-next-line)
(require 'misc)
(global-set-key "\M-f" 'forward-to-word)
;(global-set-key [\C-right] 'forward-to-word)
(global-set-key "\C-xg" 'rgrep)
(global-set-key [\C-up] '(lambda () (interactive) (previous-line) (previous-line) (previous-line) (previous-line) (previous-line)))
(global-set-key [\C-down] '(lambda () (interactive) (next-line) (next-line) (next-line) (next-line) (next-line)))
(global-set-key "\M-t" 'toggle-truncate-lines)
(global-set-key "\C-xl" 'copy-line)
(global-set-key "\C-x\C-o" 'other-window)
(global-set-key "\C-xm" 'my-bookmark-set)
(global-set-key "\C-xj" 'my-bookmark-jump)
; Prompts for a background color for selection
(global-set-key "\C-\M-y" 'facemenu-set-background)

;; org mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-directory "~/Dropbox/org/")
(setq org-agenda-files (list (concat org-directory "work.org")))
(add-hook 'org-mode-hook 'visual-line-mode) 
(require 'org-tree-slide)
(setq org-hide-emphasis-markers t)
(setq org-hide-leading-stars t)
(add-hook 'org-mode-hook (lambda () (set-face-attribute 'org-level-1 nil :height 2.5)))
(add-hook 'org-mode-hook (lambda () (set-face-attribute 'org-level-2 nil :height 1.5)))
(add-hook 'org-mode-hook (lambda () (set-face-attribute 'org-level-2 nil :height 1.0)))



;; Get rid of c-z minimizing the window
(global-set-key "\C-z" nil)

;; Helm
(require 'helm)
(require 'helm-ag)
;;(global-set-key "\C-x\C-f" 'helm-find-files)
(global-set-key "\C-\M-g" 'helm-do-ag)
(global-set-key "\M-i" 'helm-projectile-ag)
(projectile-global-mode 1)
(helm-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(define-key projectile-mode-map (kbd "C-c p") 'helm-projectile)


;; Clojure
; this gets invoked by 'run-lisp'
(setq inferior-lisp-program "~/bin/clojure")
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'prettify-symbols-mode)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Kill whitespace
(global-set-key "\C-\M-w" 'fixup-whitespace)


;; Paredit
;; Redefine some paredit keys
;; First we need to undefine the keys in paredit's map
(eval-after-load 'paredit '(progn (define-key paredit-mode-map [\C-\M-right] nil)))
(eval-after-load 'paredit '(progn (define-key paredit-mode-map [\C-\M-left] nil)))
(global-set-key [\C-\M-right] 'paredit-forward)
(global-set-key [\C-\M-left] 'paredit-backward)
 
; Recursive edit
;; Enter a recursive edit. C-M-c will bring back exactly there
(global-set-key (kbd "C-c r") (lambda ()
                                (interactive)
                                (message "Hit C-M-c to exit recursive edit")
                                (save-window-excursion
                                  (save-excursion
                                    (recursive-edit)))))
(defun my-bookmark-jump (r)
  (interactive "cRegister Name:")
  (jump-to-register r)
)
(defun my-bookmark-set (r)
  (interactive "cRegister Name:")
  (point-to-register r)
)
;; ^E in Vi
(defun ctrl-e-in-vi (n)
 (interactive "p")
 (scroll-down n))
;; ^Y in Vi
(defun ctrl-y-in-vi (n)
 (interactive "p")
 (scroll-up n))
(global-set-key "\M-n" 'ctrl-y-in-vi)
(global-set-key "\M-p" 'ctrl-e-in-vi)
; autocomplete (only on version 23.x)
;(if (string= (substring emacs-version 0 3) "23.")
;    (progn (add-to-list 'load-path "~/.emacs.d/")
;           (require 'auto-complete-config)
;           (add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;           (ac-config-default))
;)
 
; undo is already bound to C-/
(menu-bar-enable-clipboard)
(put 'dired-find-alternate-file 'disabled nil)
(add-to-list 'auto-mode-alist '("\\.clj" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.kmap" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.jsp" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tag" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.cpp" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h" . c++--mode))


(define-key minibuffer-local-map [f3]
  (lambda() (interactive) (insert (buffer-file-name (nth 1 (buffer-list))))))
(put 'upcase-region 'disabled nil)
 (setq c-default-style "linux"
          c-basic-offset 4)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(auto-compression-mode t nil (jka-compr))
 '(auto-hscroll-mode t)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (whiteboard)))
 '(default-input-method "rfc1345")
 '(focus-follows-mouse t)
 '(font-use-system-font nil)
 '(global-font-lock-mode t nil (font-lock))
 '(horizontal-scroll-bar-mode t)
 '(indent-tabs-mode nil)
 '(ispell-highlight-face (quote flyspell-incorrect))
 '(ispell-local-dictionary "american")
 '(ispell-program-name "/opt/local/bin/aspell")
 '(large-file-warning-threshold 1000000000)
 '(org-indent-indentation-per-level 2)
 '(org-list-indent-offset 8)
 '(org-log-done t)
 '(org-startup-indented t)
 '(package-archives
   (quote
    (("elpa" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (org-tree-slide org-translate projectile helm-projectile markdown-mode helm-ag-r helm-org helm-ag helm ag xref-js2 ggtags evil evil-visual-mark-mode ctags-update auto-virtualenv virtualenv elpy web-mode ess rainbow-mode tabbar rainbow-delimiters paredit magit json-mode js2-mode flymake-jslint company ac-cider 0blayout)))
 '(recentf-menu-filter (quote recentf-sort-ascending))
 '(recentf-mode t nil (recentf))
 '(ring-bell-function (quote ignore))
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(scroll-conservatively 10)
 '(scroll-down-aggressively nil)
 '(scroll-step 1)
 '(scroll-up-aggressively nil)
 '(show-paren-mode t nil (paren))
 '(speedbar-show-unknown-files t)
 '(speedbar-tag-hierarchy-method (quote (speedbar-simple-group-tag-hierarchy)))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-mwheel-mode t nil (tabbar))
 '(tool-bar-mode nil nil (tool-bar))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(setq truncate-partial-width-windows 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "whitesmoke" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "DAMA" :family "Ubuntu Mono"))))
 '(font-lock-comment-face ((((class color) (background light)) (:foreground "Dark Green"))))
 '(font-lock-string-face ((((class color) (background light)) (:foreground "Red"))))
 '(mode-line ((t (:background "MediumPurple1" :foreground "White" :box (:line-width -1 :style released-button)))))
 '(tabbar-button ((t (:inherit default :box (:line-width 1 :color "white" :style released-button)))))
 '(tabbar-default ((t (:inherit variable-pitch :background "gray75" :foreground "gray50" :height 1.0)))))

(defun comment-end-of-function (arg)
  ;; jvd: copies the function name (at the cursor) and puts it as a comment at the end
  (interactive "p")
  (kill-sexp)
  (yank)
  (forward-list)
  (forward-list)
  (insert "// end ")
  (yank)
)
;; Frame title bar formatting to show full path of file
(setq-default
 frame-title-format
 (list '((buffer-file-name " %f" (dired-directory
                  dired-directory
                  (revert-buffer-function " %b"
                  ("%b - Dir:  " default-directory)))))))
;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1))
 
(put 'narrow-to-region 'disabled nil)
(defun copy-line ()
  (interactive)
  (beginning-of-line )
  (let ((beg (point))) (forward-line 1) (copy-region-as-kill beg (point))) (forward-line -1)
  (message "copied line")
)
 
   
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
 
;; Flymake - lint for python
(when (load "flymake" t)
      (defun flymake-pylint-init ()
        (let* ((temp-file (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
          (list "/usr/local/bin/epylint" (list local-file))))
 (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; ====================
;; insert date and time
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert (format-time-string current-date-time-format (current-time)))
       )

(global-set-key "\C-\M-d" 'insert-current-date-time)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed 0.05) ;; scroll acceleration

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

; See https://github.com/js-emacs/xref-js2
; Note that xref-js2 requires 'ag' installed, both in emacs and on your host.
(require 'js)
(add-hook 'js2-mode-hook (lambda ()  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
(add-hook 'js2-mode-hook (lambda () (define-key js2-mode-map (kbd "M-.") nil)))

;; Org mode
(require 'org)
(define-key org-mode-map (kbd "M-a") 'org-show-all)

;; Source-block
(defun mark-region-as-src () (interactive)
       (save-excursion
         (goto-char (region-end))
         (insert "#+END_SRC\n")
         (goto-char (region-beginning))
         (insert "#+BEGIN_SRC\n")
         )
       )
(define-key org-mode-map (kbd "M-s") 'mark-region-as-src)


;; Evil mode
(defun evil ()  
  (interactive)
  (evil-mode 1)
  )

;; Holy mode
(defun holy ()  
  (interactive)
  (evil-mode 0)
  )

(require 'evil)
(require 'evil-states)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-normal-state-map (kbd "C-s") 'save-buffer)
(define-key evil-normal-state-map (kbd "C-S-S") 'isearch-forward)
(define-key evil-insert-state-map (kbd "C-s") '(lambda () (interactive) (evil-force-normal-state) (save-buffer)))


;; Use evil mode by default
(evil)

