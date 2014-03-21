;; mode:-*-emacs-lisp-*-
;; wanderlust 

(setq wl-insert-message-id nil)
(setq wl-folder-window-width 60)
(setq wl-interactive-save-folders nil)
(setq wl-summary-weekday-name-lang "en")

(setq wl-insert-message-id nil) ; let the SMTP servers handle the message-id and stop warning from wanderlust
  
(setq elmo-imap4-use-modified-utf7 t)
(setq wl-template-alist
	  '(
		("Gmail"                            ; Gmail
		 (wl-from . "Andu Fratu <andu@fratu.ro>")
		 ("From" . wl-from)
		 (wl-smtp-connection-type . 'starttls)
		 (wl-smtp-posting-port . 587)
		 (wl-smtp-authenticate-type . "plain")
		 (wl-smtp-posting-user . "andrei.fratu@gmail.com")
		 (wl-smtp-posting-server . "smtp.gmail.com")
		 (wl-local-domain . "localhost")
		 )
		("Tuenti"
		 (wl-from . "Andu Fratu <andu@tuenti.com>")
		 ("From" . wl-from)
		 (wl-smtp-connection-type . 'starttls)
		 (wl-smtp-posting-port . 587)
		 (wl-smtp-authenticate-type . "plain")
		 (wl-smtp-posting-user . "afratu@tuenti.com")
		 (wl-smtp-posting-server . "smtp.gmail.com")
		 (wl-local-domain . "localhost")
		 ("Organization" . "Tuenti Technologies")
		 )
		))
(setq wl-draft-config-matchone t) ;; If non-nil, applied only one element of `wl-draft-config-alist'.
(setq wl-draft-config-alist
	  '(
		(
		 (string-match "tuenti.com" wl-draft-parent-folder)
		 (template . "Tuenti"))
		(
		 (string-match "gmail.com" wl-draft-parent-folder)
		 (template . "Gmail"))))
(add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq wl-user-mail-address-list (quote ("andu@fratu.ro" "andrei@fratu.ro" "andrei.fratu@gmail.com" "andu@tuenti.com" "afratu@tuenti.com")))

(setq wl-draft-use-frame nil)

(setq wl-message-window-size '(3 . 7))

;; Fields in the e-mail header that I do not want to see (regexps)
(setq wl-message-ignored-field-list (quote (".*Received:" ".*Path:" ".*Id:" "^References:" "^Replied:" "^Errors-To:" "^Lines:" "^Sender:" ".*Host:" "^Xref:" "^Content-Type:" "^Precedence:" "^Status:" "^X-VM-.*:" "^List-*" "^Authentication-Results*" "^X-*" "^Received-SPF*" "^DKIM-Signature:" "^DomainKey-Signature:" "^X-Mailman-Version:")))
;; Fields in the e-mail header that I want to see even if they match the regex in wl-message-ignored-field-list
(setq wl-message-visible-field-list (quote ("^Dnas.*:" "^Message-Id:" "^X-Mailer:" "^X-Mailman-Version:")))

;; Enables auto-fill-mode in the draft buffer
(add-hook 'wl-mail-setup-hook 'auto-fill-mode)

(setq wl-biff-notify-hook
	  (lambda ()
		(shell-command
		 (concat "notify-send 'New mail'"))))

(setq wl-folder-window-width 60)
(setq wl-interactive-save-folders nil)
(setq wl-biff-check-interval 300)
(setq wl-biff-check-folder-list 
	  (quote 
	   ("%inbox:\"andrei.fratu@gmail.com\"/clear@imap.gmail.com:993!"
		"%\"dAKuL_maniaK@yahoo.com\":\"andrei.fratu@gmail.com\"/clear@imap.gmail.com:993!"
		"%Dilbert:\"andrei.fratu@gmail.com\"/clear@imap.gmail.com:993!"
		"%inbox:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Calendar:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Crucible:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Hudson:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Ideas:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Jira:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Offtopic:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%\"Pull requests\":\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Social:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Tech:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"
		"%Todos:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!")))
(setq wl-draft-always-delete-myself t)
(setq wl-folder-desktop-name "Global")
(setq wl-refile-rule-alist (quote
							(("Subject"
							  ("^\\[Jira\\]:?.+" . "%Jira:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("Subject"
							  ("^\\[Offtopic\\]:?.+" . "%Offtopic:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("Subject"
							  ("^\\[Crucible\\]:?.+" . "%Crucible:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("Subject"
							  ("^\\[Ideas\\]:?.+" . "%Ideas:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("Subject"
							  ("^\\\(Pull request\\\|Your pull\\\).+" . "%\"Pull requests\":\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("Subject"
							  ("^\\\(Updated \\\)?Invitation: " . ("To" ("afratu@tuenti.com" . "%\"Calendar\":\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))))
							 ("From"
							  ("support@tuentimovil.zendesk.com" . "%Zendesk:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("From"
							  ("notification@hockeyapp.net" . "%HockeyApp:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("From"
							  ("devops\\\+jenkins@tuenti.com" . "%Hudson:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("From"
							  ("Cron Daemon" . "%Crons:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("From"
							  ("calendar-notification@google\\.com" . ("To" ("afratu@tuenti.com" . "%Calendar:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))))
							 ("From"
							  ("calendar-notification@google\\.com" . ("To" ("andrei.fratu@gmail.com" . "%Calendar:\"andrei.fratu@gmail.com\"/clear@imap.gmail.com:993!"))))
							 (("To" "Cc" "Bcc")
							  ("tech\\\(\\+[a-z]+\\\)?@tuenti.com" . "%Tech:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("To"
							  ("bi_global_stats@tuenti\\.com" . "%Stats:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 (("To" "Cc")
							  ("qa_social@tuenti\\.com" . "%inbox:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 (("To" "Cc")
							  ("social@tuenti\\.com" . "%Social:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("To"
							  ("social\\+cron@tuenti\\.com" . "%Stats:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("To"
							  ("comms+kpireport@tuenti\\.com" . "%Stats:\"afratu@tuenti.com\"/clear@imap.gmail.com:993!"))
							 ("Subject"
							  ("\\[Emailupdates\\] .+" . "%\"Comms test messages\":\"afratu@tuenti.com\"/clear@imap.gmail.com:993!")))))
(setq wl-stay-folder-window nil)
(setq wl-summary-auto-refile-skip-marks nil)
(setq wl-summary-weekday-name-lang "en")
(setq wl-ldap-base "ou=people,dc=tuenti,dc=com")
(setq wl-ldap-port 389)
(setq wl-ldap-server "ldap.tuenti.local")
(setq wl-use-ldap t)
(setq wl-summary-default-view (quote sequence))
(setq wl-summary-fix-timezone nil)
(setq wl-summary-line-format "%n%T%P %D.%M.%Y %h:%m %t%[%40(%c %f%) %] %s")
(setq wl-summary-width nil)
(setq wl-use-folder-petname (quote (modeline ask-folder read-folder)))
(setq elmo-msgdb-extra-fields '("bcc"))
