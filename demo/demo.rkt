#lang racket/gui

(require web-view)


(define frame
  (new frame% 
       [label "Demo Browser"]   
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

(define (go-forward button event)
  (send web-view go-forward))

(define (go-back button event)
  (send web-view go-back))

(define (reload button event)
  (send web-view reload))

(define address-bar
  (new text-field%
       [parent toolbar]
       [label "URL"]))

(define go-button
  (new button%
       [parent toolbar]
       [label "Go"]
       [callback go-to-url]))


(define go-back-button
  (new button%
       [parent toolbar]
       [label "<"]
       [callback go-back]))

(define go-forward-button
  (new button%
       [parent toolbar]
       [label ">"]
       [callback go-forward]))

(define reload-button
  (new button%
       [parent toolbar]
       [label "reload"]
       [callback reload]))

(define panel
  (new panel%
       [parent frame]))


(send frame show #t)
(send frame create-status-line)

(define (status-change status)
  (send frame set-status-text status))

; needs to be after parent show so that we have parents dimensions
(define web-view
  (new web-view%
       [parent panel]
       [on-status-change status-change]))

(send web-view set-url "https://racket-lang.org")
(send web-view get-url)
