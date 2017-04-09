;;; EMACS CONFIGURATION FILE

;; Display Time Function
(display-time)

;;Check terminal type for keypad loading
(setq terminal-name (getenv "TERM"))
(if (string-equal (substring terminal-name 0 3) "vt2")
    (load "~/.vt200" nil t))

;;; C CODE FORMATTING (c-mode defines)
;; tab will indent even if in middle of a line
(setq c-tab-always-indent t)
;; newline after semi-colons and braces
(setq c-auto-newline nil) ;; t for newline after semi's or braces
;; indentation of new code levels [if {, while{, etc]
(setq c-indent-level 2)
;; indentation of lines continued from prior line
(setq c-continued-statement-offset 2)
;; extra indentation given to braces
(setq c-brace-offset 0)
;; indentation given to argument declarations lists
(setq c-argdecl-indent 5)
;; indentation for labels and case statements
(setq c-label-offset -2)
;; indentation given to continued lines beginning with braces
(setq c-continued-brace-offset 0)

;; AUTOMATIC MODE SELECTION (hooks)

;; set text-mode as default
(setq default-major-mode 'text-mode)

;; enable auto-fill-mode in text-mode and all related modes
(setq text-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 75)        ;; ONLY FOR NOW -- add to text-mode-hook

;;; Turn on nroff-mode for the following files
(setq auto-mode-alist (append auto-mode-alist
			      '(("\\.me$" . nroff-mode)
				("\\.ms$" . nroff-mode)
				("\\.man$" . nroff-mode)
				("\\.[1-8lnp].$" . nroff-mode))))

;; turn on nroff command grouping
(setq nroff-mode-hook '(lambda () (electric-nroff-mode 1)))

;; Turn on coloring of coding for color xterms
(if (eq window-system 'x)
    (if (x-display-color-p)
        (progn
          (require 'font-lock)
          (add-hook 'emacs-lisp-mode-hook 'font-lock-mode)
          (add-hook 'c++-mode-hook 'font-lock-mode)
          (add-hook 'c-mode-hook 'font-lock-mode)
          (add-hook 'perl-mode-hook 'font-lock-mode)
	  (add-hook 'java-mode-hook 'font-lock-mode)
          )))

(custom-set-variables
 '(font-lock-maximum-decoration t)
 '(font-lock-support-mode nil)
 '(global-font-lock-mode nil nil (font-lock))
 '(font-lock-global-modes t))
(custom-set-faces)

;; MISCELLANEOUS STUFF

;; auto-save set
(setq auto-save-interval 500)

;; set compile line
;;(setq compile-command "gcc -o ") 

;; make searches case sensitive by default
(setq-default case-fold-search nil)

;; set shell to run in emacs
(setq explicit-shell-file-name "/usr/local/bin/tcsh")

;; for wordprocessing -- access to webster
(defun webster-word (word)
  "Call Webster on a word"
  (interactive "sWord for webster: ")
  (shell-command (concat "webster " "'" word "'")))

;; Set lpr flags (M-x lpr)
;;(setq lpr-switches (list "-h"))

;; scratch buffer safety net
(save-excursion
  (set-buffer "*scratch*")
  (setq buffer-file-name (expand-file-name "~/scratch")))

;; Finally
(message "Loading init file....done")
(put 'upcase-region 'disabled nil)

;; Import JAVA editor
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
(load "jde")

;; Add package manager
(require 'package)

(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives source))

(package-initialize)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete/dict")

(set-default 'ac-sources
             '(ac-source-abbrev
               ac-source-dictionary
               ac-source-yasnippet
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-semantic))

(ac-config-default)

(dolist (m '(c-mode c++-mode java-mode))
  (add-to-list 'ac-modes m))

(global-auto-complete-mode t)

;; set color
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (wombat))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
