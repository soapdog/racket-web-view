#lang racket/gui

(require web-view)


(define frame
  (new frame% 
       [label "test"]   
       [width 800] 
       [height 600] 
       [x 100] 
       [y 100]))

(define toolbar
  (new horizontal-panel%
       [parent frame]
       [min-height 40]
       [stretchable-height #f]))

(define (go-to-url button event)
  (send web-view set-url (send address-bar get-value)))

(define address-bar
  (new text-field%
       [parent toolbar]
       [label "URL"]))

(define go-button
  (new button%
       [parent toolbar]
       [label "Go"]
       [callback go-to-url]))

(define panel
  (new panel%
       [parent frame]))


(send frame show #t)


; needs to be after parent show so that we have parents dimensions
(define web-view
  (new web-view%
       [parent panel]))

(send web-view set-url "https://racket-lang.com")
(send web-view get-url)

