#lang racket

(require 
  racket/class 
  racket/gui
  "webkit.rkt"
  "wkwebview.rkt")

(define web-view%
  (class panel%
    (init parent [on-status-change #f])

    (super-new [parent parent])

    (define current-operating-system (system-type 'os))

    (if (not (member current-operating-system (list 'macosx)))
        (error 'not-implemented "web-view% not implemented for ~a" current-operating-system)
        #t)
    
    (define webview
      (new wk-web-view%
           [parent this]
           [on-status-change on-status-change]))
        
    (define/public (get-debug-info)
      current-operating-system)

    (define/public (set-url url)
      (send webview set-url url))

    (define/override (on-size w h)
      (send webview on-size w h))

    (define/public (get-url)
      (send webview get-url))

    (define/public (can-handle-url? url)
      (send webview can-handle-url? url))

    (define/public (go-forward)
      (send webview go-forward))

    (define/public (go-back)
      (send webview go-back))

    (define/public (reload)
      (send webview reload))

    (define/public (set-html-text text base-url)
      (send webview set-html-text text base-url))
   
    ))

(provide web-view%)