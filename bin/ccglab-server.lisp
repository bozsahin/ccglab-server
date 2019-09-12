;; CCGlab web server using SBCL, quicklisp and Portabe AllegroServe
;; -- cem bozsahin, 2019

(load #p"/Users/bozsahin/myrepos/ccglab-api/ccglab-sbcl.lisp") ; loads CCGlab as API, creates :ccglab package and returns to :cl

(load #p"/Users/bozsahin/quicklisp/setup.lisp") ; easiest way to fetch aserve
(ql:quickload :aserve) ; loads portable AllegroServe, which creates the package :net.aserve

(defpackage :ccglab-server (:use :cl :net.aserve :sb-ext :ccglab)) ; own package with everything imported

(in-package :ccglab-server)

(defparameter *ccglab-port* 8000)
;; static files - list of local and public file names
(defparameter *main* (list "/Users/bozsahin/myrepos/ccglab-server/main.html"
			   "/main.html"))
(defparameter *exampleg* (list "/Users/bozsahin/myrepos/ccglab-server/wish.ccg"
			       "/wish.ccg"))
(defparameter *examplelog* (list "/Users/bozsahin/myrepos/ccglab-server/wish.log"
			       "/wish.log"))
(defparameter *icon* (list "/Users/bozsahin/myrepos/ccglab-server/ccglab2.ico"
			   "/ccglab2.ico"))  
(defparameter *manual* (list "/Users/bozsahin/myrepos/ccglab-server/CCGlab-manual.pdf"
			     "/CCGlab-manual.pdf"))
(defparameter *display* (list "/Users/bozsahin/myrepos/ccglab-server/wish-framed.jpg"
			      "/wish-framed.jpg"))
(defparameter *static-pages* (list *main* *exampleg* *examplelog* *icon* *manual* *display*))

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
  (dolist (fpair *static-pages*)
    (publish-file :path  (get-public fpair) :file (get-local fpair))))
(publish-statics)

