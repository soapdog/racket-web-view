#lang info
(define collection "web-view")
(define deps '("gui-lib"
               "base"))
(define build-deps '("at-exp-lib"
                     "gui-doc"
                     "scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/web-view.scrbl" ())))
(define pkg-desc "A web-view control to be used with Racket GUI toolkit applications")
(define version "0.1")
(define pkg-authors '(agarzia))
