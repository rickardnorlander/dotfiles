(require 'package)
(package-initialize)

; Better naming of buffers for files with same name
(require 'uniquify)

; Remember recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)
(setq recentf-max-saved-items 100)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

; Add repos for packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


; Save all backup/autosaves in one directory
(defconst emacs-tmp-dir "~/emacsbackups/")
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

(load "~/.emacs.d/protobuf-mode.el")
(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))

; Use undo-tree instead of default undo system
(global-undo-tree-mode)

; Disable 'make program stop working' commands
(when (display-graphic-p)
    (global-unset-key (kbd "C-z"))
    (global-unset-key (kbd "C-x C-z"))
  )
(global-set-key (kbd "C-x f") 'find-file)

; Active region replaced when paste or typing
(delete-selection-mode 1)
; Disable toolbar
(tool-bar-mode -1)
; Disable the menu bar
; Use ‘C-mouse-3’ to pop up the entire menu-bar as a popup menu.
(menu-bar-mode -99)
; Disable scrollbar
(scroll-bar-mode -1)
; Disable blinking cursor
(blink-cursor-mode -1)

(defun kill-filename ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (leuven)))
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (uniquify-files undo-tree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(trailing-whitespace ((t (:background "red")))))

(setq-default show-trailing-whitespace t)
