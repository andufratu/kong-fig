;; CEDET
(load-file "~/.emacs.d/site-lisp/cedet/cedet-devel-load.el")
;; 1. enable it
(semantic-mode 1) 
(global-semanticdb-minor-mode 1)

;; 2. use ede to manage project
(global-ede-mode t)

;; 3. enable db-javap
(require 'semantic/db-javap)

;; 4. enable auto-complete
(require 'semantic/ia)
(defun my-cedet-hook ()
  ;; functions which are disabled
  ;; (local-set-key "\C-cp" 'semantic-ia-show-summary)
  ;; (local-set-key "\C-cl" 'semantic-ia-show-doc)
  ;; (local-set-key "." 'semantic-complete-self-insert)
  ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\M-n" 'semantic-ia-complete-symbol-menu)  ;; auto completet by menu
  (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cR" 'semantic-symref) 
  (local-set-key "\C-cr" 'semantic-symref-symbol)  
  )
(add-hook 'c-mode-common-hook 'my-cedet-hook)

;; Setup marmalade
(require 'package)
(add-to-list 'package-archives
			 '("melpa" .
			   "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; (setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq column-number-mode t)
(global-font-lock-mode t)
(setq bookmark-set-flag 1)
(menu-bar-mode -1)
(auto-fill-mode -1)
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

;; NXHTML mode
(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
(setq c-default-style "bsd")
(setq auto-mode-alist (cons '("\\.tpl$" . smarty-nxhtml-mumamo-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ctp$" . smarty-nxhtml-mumamo-mode) auto-mode-alist))
(setq mumamo-background-colors nil)

;; Enable dired-find-alternate-file
(put 'dired-find-alternate-file 'disabled nil)

;; From Emacs wiki
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Key binding for revert buffer
(global-set-key (kbd "C-c C-r") 'revert-buffer)

(iswitchb-mode t)

;; ???
(add-hook 'php-mode-hook (lambda ()
    (defun ywb-php-lineup-arglist-intro (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) c-basic-offset))))
    (defun ywb-php-lineup-arglist-close (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (current-column))))
    (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
    (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))
(setq my-php-function-doc-hash (make-hash-table :test 'equal)) 

;; SLIME
(setq inferior-lisp-program "~/bin/sbcl") ;; your Lisp system
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/slime/")  ;; your SLIME directory
(require 'slime)
(slime-setup '(slime-fancy slime-banner))

;; MATLAB
(add-to-list 'load-path "~/.emacs.d/site-lisp/matlab-emacs/")
(require 'matlab-load)

;; ActionScript mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/actionscript-mode-master/")
(autoload 'actionscript-mode "actionscript-mode" "Major mode for actionscript." t)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

;; Backups
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/emacs-backups"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;; Paths
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

(require 'auto-complete-etags)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(defun ac-common-setup ()
  (setq ac-sources (append ac-sources '(ac-source-etags))))
(setq ac-auto-start nil)
(define-key ac-mode-map (kbd "C-c SPC") 'auto-complete)
(ac-config-default)

(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))

;; Handle camelCasedWords
(global-subword-mode 1)

;;Lua Mode
(load "~/.emacs.d/site-lisp/lua-mode/lua-mode.el")
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(require 'etags-select)

;;Color theme
;; (require 'color-theme)
;; (color-theme-initialize)
;; (if window-system-version
;; 	(color-theme-standard)
;;   (color-theme-arjen))

;; Icicles mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/icicles/")
(require 'icicles)
(add-hook 'javascript-mode-hook
		  '(lambda ()
			 (define-key javascript-mode-map "\M-."
			   'find-tag)))
(add-hook 'js-mode-hook
		  '(lambda ()
			 (define-key js-mode-map "\M-."
			   'find-tag)))

;; XClip
(xclip-mode 1)

;; w3m
(require 'w3m)
(require 'mime-w3m)

;; Wanderlust autoload
(require 'mime-setup)
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(add-to-list 'auto-mode-alist '("\.wl$" . emacs-lisp-mode))

;; Calendar
(require 'calfw)
(require 'calfw-ical)
(require 'calfw-gcal)
(defun andu-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
	(cfw:ical-create-source "Gmail" "https://www.google.com/calendar/ical/andrei.fratu%40gmail.com/private-d3d487c4fd880e9adef350e46e6fd8e5/basic.ics" "Blue")
	(cfw:ical-create-source "Tuenti - mine" "http://www.google.com/calendar/ical/afratu%40tuenti.com/private-f6c7992dac6d1905faaed5ddecc9b926/basic.ics" "Green")
	(cfw:ical-create-source "Tuenti - Tech talks" "http://www.google.com/calendar/ical/tuenti.com_m2olvofevoa4e0973vr23vbat4%40group.calendar.google.com/public/basic.ics" "Yellow")
	(cfw:ical-create-source "Tuenti - social vacations" "http://www.google.com/calendar/ical/tuenti.com_0g2fcibojqimikuvu1oubm2ino%40group.calendar.google.com/public/basic.ics" "Brown"))))

;;JDEE
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
(load "jde")

;; Custom set variables

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'wl-init-hook 'mime-w3m-insinuate)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(android-mode-sdk-dir "~/Work/android-sdk-linux")
 '(ange-ftp-try-passive-mode t)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "google-chrome")
 '(cedet-android-sdk-root "~/Work/android-sdk-linux/")
 '(custom-enabled-themes (quote (Andu)))
 '(custom-safe-themes (quote ("e061044c0d27a2cb12859d2cf207121ceddf264fa00a946786bade09a0470239" default)))
 '(ecb-layout-name "left1")
 '(ecb-options-version "2.40")
 '(ede-project-directories (quote ("/home/andu/Work/tuenti/android-messenger/app" "/home/andu/Work/tuenti/messenger/app" "~/Work/Coursera/Android/Week 5/NotificationsLabTest" "~/Work/Coursera/Android/Week 5/NotificationsLab" "~/Work/tuenti/android-swipelistview-tuenti" "~/Work/tuenti/messenger" "~/Work/tuenti/android-messenger/chat" "~/Work/tuenti/android-messenger/app" "~/Work/tuenti/android-messenger")))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(glasses-face nil)
 '(glasses-original-separator "")
 '(glasses-separate-parentheses-exceptions (quote ("^#[	 ]*define[	 ]*[A-Za-z0-9_-]* ?($")))
 '(glasses-separate-parentheses-p nil)
 '(glasses-separator "~~")
 '(global-semanticdb-minor-mode t)
 '(gtags-pop-delete t)
 '(jde-global-classpath (quote ("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar")))
 '(jira-url "http://jira.tuenti.int/jira/rpc/xmlrpc")
 '(ldap-default-base "ou=people,dc=tuenti,dc=com")
 '(ldap-default-host "ldap.tuenti.local")
 '(ldap-default-port 389)
 '(menu-bar-mode nil)
 '(mime-play-delete-file-immediately nil)
 '(php-manual-path "~/Dropbox/")
 '(python-guess-indent nil)
 '(python-indent 4)
 '(python-indent-string-contents nil)
 '(semantic-default-submodes (quote (global-semantic-highlight-func-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode global-semantic-idle-local-symbol-highlight-mode global-semantic-show-unmatched-syntax-mode)))
 '(semantic-idle-scheduler-idle-time 10)
 '(semantic-new-buffer-setup-functions (quote ((jde-mode . jde-parse-semantic-default-setup) (emacs-lisp-mode . semantic-default-elisp-setup) (c-mode . semantic-default-c-setup) (c++-mode . semantic-default-c-setup) (arduino-mode . semantic-default-c-setup) (html-mode . semantic-default-html-setup) (java-mode . wisent-java-default-setup) (js-mode . wisent-javascript-setup-parser) (python-mode . wisent-python-default-setup) (scheme-mode . semantic-default-scheme-setup) (f90-mode . semantic-default-f90-setup) (srecode-template-mode . srecode-template-setup-parser) (texinfo-mode . semantic-default-texi-setup) (makefile-automake-mode . semantic-default-make-setup) (makefile-gmake-mode . semantic-default-make-setup) (makefile-makepp-mode . semantic-default-make-setup) (makefile-bsdmake-mode . semantic-default-make-setup) (makefile-imake-mode . semantic-default-make-setup) (makefile-mode . semantic-default-make-setup) (android-mode . android-root))))
 '(semanticdb-find-default-throttle (quote (local project unloaded system)))
 '(semanticdb-javap-classpath (quote ("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar" "~/Work/android-sdk-linux/platforms/android-18/android.jar" "~/Work/android-sdk-linux/platforms/android-8/android.jar" "~/.m2/repository/com/tuenti/picasso/picasso/2.1.2-SNAPSHOT/picasso-2.1.2-SNAPSHOT.jar")))
 '(semanticdb-project-roots nil)
 '(show-paren-mode t)
 '(slime--net-coding-system (quote utf-8-unix))
 '(which-func-modes (quote (emacs-lisp-mode c-mode c++-mode perl-mode cperl-mode python-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode diff-mode nxhtml-mode))))
 ;; If there is more than one, they won't work right.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; custom-set-variables was added by Custom.

;; UTF-8 for coding system
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; EDE Projects
;; Messenger
;; (ede-maven2-project "messenger"
;; 					:directory "~/Work/tuenti/messenger"
;; 					:file "~/Work/tuenti/messenger/pom.xml"
;; 					:subproj '("messenger/api" "messenger/app" "messenger/chat" "messenger/commons" "messenger/test-annotations" "messenger/tests" "messenger/xmpp")
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"))

;; (ede-maven2-project "messenger/api" :file "~/Work/tuenti/android-messenger/api/pom.xml"
;; 					:directory "~/Work/tuenti/android-messenger/api/src"
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-18/android.jar"))

;; (ede-maven2-project "messenger/app" :file "~/Work/tuenti/android-messenger/app/pom.xml"
;; 					:directory "~/Work/tuenti/android-messenger/app/src"
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-18/android.jar"))

;; (ede-maven2-project "messenger/chat" :file "~/Work/tuenti/android-messenger/chat/pom.xml"
;; 					:directory "~/Work/tuenti/android-messenger/chat/src"
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-18/android.jar"))

;; (ede-maven2-project "messenger/commons" :file "~/Work/tuenti/android-messenger/commons/pom.xml"
;; 					:directory "~/Work/tuenti/android-messenger/commons/src"
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-18/android.jar"))

;; (ede-maven2-project "messenger/test-annotations" :file "~/Work/tuenti/android-messenger/test-annotations/pom.xml"
;; 					:directory "~/Work/tuenti/android-messenger/test-annotations/src"
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-18/android.jar"))

;; (ede-maven2-project "messenger/tests" :file "~/Work/tuenti/android-messenger/tests/pom.xml"
;; 					:directory "~/Work/tuenti/android-messenger/tests/src"
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-18/android.jar"))

;; (ede-maven2-project "messenger/xmmp" :file "~/Work/tuenti/android-messenger/xmmp/pom.xml"
;; 					:directory "~/Work/tuenti/android-messenger/xmpp/src"
;; 					:classpath '("/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/rt.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-8/android.jar"
;; 								 "~/Work/android-sdk-linux/platforms/android-18/android.jar"))

(server-start)

(require 'tuenti-android-mode)

;; GTAGS and Semantic
(semanticdb-enable-gnu-global-databases 'java-mode)
(semanticdb-enable-gnu-global-databases 'jde-mode)
(semanticdb-enable-gnu-global-databases 'php-mode)
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'gtags-select-mode-hook
		  '(lambda ()
			 (setq hl-line-face 'underline)
			 (hl-line-mode 1)
			 ))
(add-hook 'jde-mode-hook
		  '(lambda ()
			 (gtags-mode 1)))
(add-hook 'c-mode-hook
		  '(lambda ()
			 (gtags-mode 1)))
(add-hook 'php-mode-hook
		  '(lambda ()
			 (gtags-mode 1)))
(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)
(setq gtags-mode-hook
	  '(lambda ()
		 (setenv "GTAGSLIBPATH" "$HOME/Work/android-sdk-linux" t)
		 (setenv "ANDROID_HOME" "$HOME/Work/android-sdk-linux" t)))
