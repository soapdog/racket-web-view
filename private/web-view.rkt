#lang racket

(require 
  racket/class 
  racket/gui
  "webkit.rkt"
  "wkwebview.rkt")

(define web-view%
  (class object%
    (super-new)

    (init parent [on-status-change #f])

    (define current-operating-system (system-type 'os))

    (define panel
      (new panel%
           [parent parent]))

    (if (not (member current-operating-system (list 'macosx)))
        (error 'not-implemented "web-view% not implemented for ~a" current-operating-system)
        #t)
    
    (define webview
      (new wk-web-view%
           [parent panel]
           [on-status-change on-status-change]))
        
    
    (define/public (get-debug-info)
      current-operating-system)

    (define/public (set-url url)
      (send webview set-url url))

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