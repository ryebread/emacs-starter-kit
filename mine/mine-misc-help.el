;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-09-28 20:34:56 Tuesday by ryebread>

;; This  file is free  software; you  can redistribute  it and/or
;; modify it under the terms of the GNU General Public License as
;; published by  the Free Software Foundation;  either version 3,
;; or (at your option) any later version.

;; This file is  distributed in the hope that  it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR  A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You  should have  received a  copy of  the GNU  General Public
;; License along with  GNU Emacs; see the file  COPYING.  If not,
;; write  to  the Free  Software  Foundation,  Inc., 51  Franklin
;; Street, Fifth Floor, Boston, MA 02110-1301, USA.


;; help-mode setting
(require 'mine-help-mode)

;; Emacs中的info
(require 'mine-help-info)

;; Emacs中的man配置
(require 'mine-help-man)

;; 非常方便的查看emacs帮助的插件
(require 'describe-symbol)
(require 'find-symbol)
(require 'mine-help-symbol)

(provide 'mine-misc-help)
