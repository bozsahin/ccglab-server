;; CCGlab web server using SBCL, quicklisp and Portabe AllegroServe
;;    and FOO library of Seibel 
;; -- cem bozsahin, 2019

(load #p"/Users/bozsahin/myrepos/ccglab-api/ccglab-sbcl.lisp") ; loads CCGlab as API, creates :ccglab package and returns to :cl

(load #p"/Users/bozsahin/quicklisp/setup.lisp") ; easiest way to fetch aserve is quicklisp package manager
(ql:quickload :aserve) ; loads portable AllegroServe, which creates the package :net.aserve

(defpackage :ccglab-server (:use :cl :net.aserve :sb-ext :ccglab)) ; own package with everything imported

(in-package :ccglab-server)

(defparameter *ccglab-port* 8000)
;; static files - list of local and public file names

(defmacro get-local (p)
  `(first ,p))

(defmacro get-public (p)
  `(second ,p))

;;(format t "======================================")
(format t "~%Attempting to kill listeners to port: ~A~%" *ccglab-port*)
(run-program "kill-ccglab-port" (list (write-to-string *ccglab-port*)) 
	     :output *standard-output* :search t :wait t) ; from sb-ext
(format t "Starting CCGlab web server at port: ~A" *ccglab-port*)
(start :port *ccglab-port*)
(defun publish-statics ()
  (publish-directory :prefix "/" :destination "/statics/"))
(defun publish-dynamics ()
  (publish-directory :prefix "/" :destination "/dynamics"))
(publish-statics)
(publish-dynamics)

