(setq nikki93-packages
      '(helm
        neotree
        paredit
        ;; flycheck
        ;; cider
        magit
        ;; 4clojure
        ;; auctex
        glsl-mode
        darkroom
        lua-mode
        ))

(defun nikki93/post-init-neotree ()
  (use-package neotree
    :defer t
    :init
    (progn
      (setq neo-window-width 23
            neo-theme 'arrow))))

(defun nikki93/post-init-helm ()
  (use-package helm
    :defer t
    :config
    (setq helm-split-window-in-side-p t)))

(defun nikki93/init-paredit ()
  (use-package paredit
    :defer t
    :init
    (progn
      (add-hook 'slime-repl-mode-hook 'paredit-mode)
      (add-hook 'clojure-mode-hook 'paredit-mode)
      (add-hook 'cider-repl-mode-hook 'paredit-mode)
      (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
      (add-hook 'lisp-mode-hook 'paredit-mode)
      (add-hook 'racket-mode-hook 'paredit-mode)
      (add-hook 'racket-repl-mode-hook 'paredit-mode))
    :config
    (progn
      (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)
      (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
      (define-key paredit-mode-map (kbd "M-[") nil)

      (add-hook 'slime-repl-mode-hook   ; Respect paredit deletion in repl
                (lambda ()
                  (define-key slime-repl-mode-map
                    (read-kbd-macro paredit-backward-delete-key)
                    nil)))

      ;; Mode-line icon
      (spacemacs|diminish paredit-mode " (Ⓟ)" " (P)"))))

(defun nikki93/post-init-magit ()
  (use-package magit
    :defer t
    :config
    (progn
      (setq magit-save-some-buffers nil)
      (setq magit-save-repository-buffers nil)
      (setq magit-display-buffer-function
            (lambda (buffer)
              (display-buffer
               buffer (if (not (memq (with-current-buffer buffer major-mode)
                                     '(magit-process-mode
                                       magit-revision-mode
                                       magit-diff-mode
                                       magit-stash-mode)))
                          '(display-buffer-same-window)
                        nil))))

      ;; automatically refresh when saving a tracked file
      (add-hook 'after-save-hook 'magit-after-save-refresh-status)

      ;; I use M-n to switch to window n, so unbind these
      (define-key magit-mode-map "\M-1" nil)
      (define-key magit-mode-map "\M-2" nil)
      (define-key magit-mode-map "\M-3" nil)
      (define-key magit-mode-map "\M-4" nil))))

(defun nikki93/init-glsl-mode ())

(defun lua/post-init-lua-mode ()
  (use-package lua-mode
    :defer t
    :config
    (progn
      (setq lua-indent-level 4
            lua-indent-string-contents nil))))



;; (defun nikki93/post-init-cider ()
;;   (use-package cider
;;     :defer t
;;     :config
;;     (progn
;;       (setq cider-cljs-boot-repl "Weasel")
;;       (setq cider-boot-parameters "dev"))))


;; (defun nikki93/init-4clojure ()
;;   (use-package 4clojure
;;     :init
;;     (progn
;;       (defun nikki93/4clojure-check-and-proceed ()
;;         "Check the answer and show the next question if it worked."
;;         (interactive)
;;         (unless
;;             (save-excursion
;;               ;; Find last sexp (the answer).
;;               (goto-char (point-max))
;;               (forward-sexp -1)
;;               ;; Check the answer.
;;               (cl-letf ((answer
;;                          (buffer-substring (point) (point-max)))
;;                         ;; Preserve buffer contents, in case you failed.
;;                         ((buffer-string)))
;;                 (goto-char (point-min))
;;                 (while (search-forward "__" nil t)
;;                   (replace-match answer))
;;                 (string-match "failed." (4clojure-check-answers))))
;;           (4clojure-next-question)))

;;       (defadvice 4clojure/start-new-problem
;;           (after nikki93/4clojure/start-new-problem-advice () activate)
;;         ;; Prettify the 4clojure buffer.
;;         (goto-char (point-min))
;;         (forward-line 2)
;;         (forward-char 3)
;;         (fill-paragraph)
;;         ;; Position point for the answer
;;         (goto-char (point-max))
;;         (insert "\n\n\n")
;;         (forward-char -1)
;;         ;; Define our key.
;;         (local-set-key (kbd "M-j") #'nikki93/4clojure-check-and-proceed)))))


;; (defun nikki93/post-init-flycheck ()
;;   (use-package flycheck
;;     :defer t
;;     :config
;;     (progn
;;       (setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list))))


;; (defun auctex/init-auctex ()
;;   (use-package tex
;;     :defer t
;;     :config
;;     (progn
;;       (setq TeX-auto-save t)
;;       (setq TeX-parse-self t)
;;       (setq-default TeX-master t)

;;       (defun auctex/build ()
;;         (interactive)
;;         (if (buffer-modified-p)
;;             (progn
;;               (let ((TeX-save-query nil))
;;                 (TeX-save-document (TeX-master-file)))
;;               (setq build-proc (TeX-command "LaTeX" 'TeX-master-file -1))
;;               (set-process-sentinel  build-proc  'auctex/build-sentinel))))

;;       (evil-leader/set-key-for-mode 'latex-mode
;;         "mb" 'auctex/build
;;         "mv" 'auctex/build-view))))
