#lang racket

; This was my initial version. It is based on deprecated WebView from code found on:
; https://gist.github.com/nickmain/5136923
;
; I've switched to WKWebView.

(require 
  racket/class 
  racket/gui
  "webkit.rkt"
  "wkwebview.rkt")

(define web-view%
  (class object%
    (super-new)

    (init parent)

    (define (on-status-change status) (print status))

    (define current-operating-system (system-type 'os))

    (define panel
      (new panel%
           [parent parent]))

    (if (not (member current-operating-system (list 'macosx)))
        (error 'not-implemented "web-view% not implemented for ~a" current-operating-system)
        #t)
    
    (define webview
      (new wk-web-view%
           [parent panel]))
        
    
    (define/public (get-debug-info)
      current-operating-system)

    (define/public (set-url url)
      (send webview set-url url))

    (define/public (get-url)
      (send webview get-url))

        
    ))

(provide web-view%)