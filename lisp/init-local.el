;; 加载 emacser.com 目录设置
(defconst my-emacs-path "~/.emacs.d/")
(defconst my-emacs-my-lisps-path  (concat my-emacs-path "my-lisps/")  "我自己写的emacs lisp包的路径")
(defconst my-emacs-lisps-path     (concat my-emacs-path "lisps/") "我下载的emacs lisp包的路径")
;; 把`my-emacs-lisps-path'的所有子目录都加到`load-path'里面
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

;; 加载 emacser.com 的配置
;; 一些基本的小函数
(require 'ahei-misc)

;; 利用`eval-after-load'加快启动速度的库
;; 用eval-after-load避免不必要的elisp包的加载
;; http://emacser.com/eval-after-load.htm
(require 'eval-after-load)
(require 'util)


;; 高亮当前行
(require 'hl-line-settings)

;; 显示行号
(require 'linum-settings)

;; 一些Emacs的小设置
(require 'misc-settings)

;; Emacs的超强文件管理器
(require 'dired-settings)

;; 编码设置
(require 'coding-settings)

;; 字体配置
;;(require 'font-settings)

;; Emacs才是世界上最强大的IDE － 智能的改变光标形状
;; http://emacser.com/cursor-change.htm
(require 'cursor-change)
(cursor-change-mode 1)

;; 模拟vi的点(.)命令
(require 'dot-mode)

;; Emacs才是世界上最强大的IDE － 用Emaci阅读文件
;; http://emacser.com/emaci.htm
(require 'emaci-settings)

;; 用一个很大的kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 200)

(require 'shortcuts-settings)

(provide 'init-local)
