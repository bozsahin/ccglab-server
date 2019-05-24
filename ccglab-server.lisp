;; CCGlab web server using SBCL, quicklisp and Portabe AllegroServe
;; -- cem bozsahin, 2019

(load #p"/Users/bozsahin/quicklisp/setup.lisp") ; easiest way to fetch aserve
(ql:quickload :aserve) ; loads portable AllegroServe, which creates the package :net.aserve

(defpackage :ccglab-server (:use :cl :net.aserve :sb-ext)) ; own package with everything imported

(in-package :ccglab-server)

(defparameter *ccglab-port* 8000)
(defparameter *l-main* "/Users/bozsahin/myrepos/ccglab-server/main.html") ; local main
(defparameter *w-main* "/main.html")                                     ; web main
(defparameter *l-exampleg* "/Users/bozsahin/myrepos/ccglab-server/wish.ccg") 
(defparameter *w-exampleg* "/wish.ccg")  
(defparameter *l-icon* "/Users/bozsahin/myrepos/ccglab-server/ccglab2.ico") 
(defparameter *w-icon* "/ccglab2.ico")  
(defparameter *l-manual* "/Users/bozsahin/myrepos/ccglab-server/CCGlab-manual.pdf") 
(defparameter *w-manual* "/CCGlab-manual.pdf")  
(defparameter *l-display* "/Users/bozsahin/myrepos/ccglab-server/wish-framed.jpg") 
(defparameter *w-display* "/wish-framed.jpg")  
(defparameter *static-pages* (list (list *l-main* *w-main*) 
				   (list *l-exampleg* *w-exampleg*)
				   (list *l-icon* *w-icon*)
				   (list *l-manual* *w-manual*)
				   (list *l-display* *w-display*)))
(format t "~%Killing listeners if I have to for port: ~A" *ccglab-port*)
(run-program "kill-ccglab-port" (list (write-to-string *ccglab-port*)) 
	     :search t :wait t) ; from sb-ext
(format t "~%Starting CCGlab web server at port: ~A" *ccglab-port*)
(start :port *ccglab-port*)
(defun publish-statics ()
  (dolist (fpair *static-pages*)
    (publish-file :path  (second fpair) :file (first fpair))))
(publish-statics)

