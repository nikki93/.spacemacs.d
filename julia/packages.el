(setq julia-packages
      '(
        ess
        auto-complete
        ))

(defun julia/init-ess ()
  (use-package ess-site
    :mode (("\\.jl\\'"           . ess-julia-mode))
    :commands (julia)
    :init
    (progn
      (add-hook 'inferior-ess-mode-hook 'auto-complete-mode)
      (add-hook 'ess-julia-mode-hook 'auto-complete-mode)))
  (with-eval-after-load 'ess-site
    (auto-complete-mode)

    (spacemacs/set-leader-keys-for-major-mode 'ess-julia-mode
      "si" 'julia

      "cc" 'ess-eval-region-or-function-or-paragraph
      "cl" 'ess-load-file

      "dd" 'ess-display-help-on-object
      "da" 'ess-display-help-apropos
      "dm" 'ess-manual-lookup
      "dw" 'ess-help-web-search)

    (define-key inferior-ess-mode-map (kbd "C-j") 'comint-next-input)
    (define-key inferior-ess-mode-map (kbd "C-k") 'comint-previous-input)))

