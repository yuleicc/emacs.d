;;2013.12.19
(defun goto-my-emacs-lisps-dir ()
  "Goto `my-emacs-lisps-path'."
  (interactive)
  (dired my-emacs-lisps-path))
(defun goto-my-emacs-my-lisps-dir ()
  "Goto `my-emacs-my-lisps-path'."
  (interactive)
  (dired my-emacs-my-lisps-path))
(defun goto-my-emacs-dir ()
  "Goto `my-emacs-path'."
  (interactive)
  (dired my-emacs-path))
(defun goto-my-home-dir ()
  "Goto my home directory."
  (interactive)
  (dired "~/"))
(define-key-list
 global-map
 `(("C-x G l" goto-my-emacs-lisps-dir)
   ("C-x G m" goto-my-emacs-my-lisps-dir)
   ("C-x G e" goto-my-emacs-dir)
   ("C-x M-h" goto-my-home-dir)))

(define-key global-map (kbd "C-x M-c") 'describe-char)

;;buffer 多少行
(defun count-brf-lines (&optional is-fun)
  "显示当前buffer或region或函数的行数和字符数"
  (interactive "P")
  (let (min max)
    (if is-fun
        (save-excursion
          (beginning-of-defun) (setq min (point))
          (end-of-defun) (setq max (point))
          (message "当前函数%s内共有%d行, %d个字符" (which-function) (count-lines min max) (- max min)))
      (if mark-active
          (progn
            (setq min (min (point) (mark)))
            (setq max (max (point) (mark))))
        (setq min (point-min))
        (setq max (point-max)))
      (if (or (= 1 (point-min)) mark-active)
          (if mark-active
              (message "当前region内共有%d行, %d个字符" (count-lines min max) (- max min))
            (message "当前buffer内共有%d行, %d个字符" (count-lines min max) (- max min)))
        (let ((nmin min) (nmax max))
          (save-excursion
            (save-restriction
              (widen)
              (setq min (point-min))
              (setq max (point-max))))
          (message "narrow下buffer内共有%d行, %d个字符, 非narrow下buffer内共有%d行, %d个字符"
                   (count-lines nmin nmax) (- nmax nmin) (count-lines min max) (- max min)))))))
(eal-define-keys-commonly
 global-map
 `(("C-x l" count-brf-lines)
   ("C-x L" (lambda () (interactive) (count-brf-lines t)))))

(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))

(setq-default kill-read-only-ok t)
(global-set-key "\C-c\C-k" 'copy-line)

;; 2013.12.10 yulei
;; 启动全屏的快捷键
(global-set-key [f11] 'my-fullscreen) ;; 启动全屏的快捷键
;全屏
(defun my-fullscreen ()
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;;设置透明度
(global-set-key [(f9)] 'loop-alpha)  ;;注意这行中的F9 , 可以改成你想要的按键
(setq alpha-list '((90 75) (100 100)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
)

;;;###autoload
;(defun copy-cur-line ()
;  "拷贝当前行"
;  (interactive)
;  (let ((end (min (point-max) (1+ (line-end-position)))))
;    (copy-region-as-kill-nomark (line-beginning-position) end)))


;;;###autoload
(defun smart-kill (&optional arg)
  "If `mark-active', call `kill-region', otherwise call `kill-whole-line'."
  (interactive)
  (if (<= arg 0)
      (call-interactively 'kill-whole-line)
    (call-interactively 'kill-line)))

;;###autoload
(defun smart-copy ()
  "智能拷贝, 如果`mark-active'的话, 则`copy-region', 否则`copy-lines'"
  (interactive)
  (if mark-active (call-interactively 'kill-ring-save) (call-interactively 'copy-cur-line)))


(global-set-key "\M-w" 'smart-copy)
;;(global-set-key "\C-k" 'smart-kill)

(global-set-key (kbd "C-x G") 'magit-status)


;;(define-key-list global-map  `(("C-x d" dired-jump)))


(provide 'shortcuts-settings)
