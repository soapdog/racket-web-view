#lang racket/gui
(require framework)
(require ffi/unsafe)
(require ffi/unsafe/objc)
(require racket/class)

(ffi-lib "/System/Library/Frameworks/WebKit.framework/WebKit")
(import-class WebView)
(import-class NSURLRequest)
(import-class NSURL)
(import-class NSString)
(import-class NSObject)


(define webkit-view%
  (class object%
    (super-new)

    (init parent)

    (define current-url #f)
      
    (define-objc-class  MyWebFrameLoadDelegate NSObject
      []
      (- _void (webView: [_id wv] didFinishLoadForFrame: [_id wf])
         (print "page loaded")))

    (define-cstruct _NSPoint ([x _double*]
                              [y _double*]))

    (define-cstruct _NSSize ([width _double*]
                             [height _double*]))
        
    (define-cstruct _NSRect ([origin _NSPoint]
                             [size _NSSize]))

    
    (define webview-x (send parent get-x))
    (define webview-y (send parent get-y))
    (define webview-width (send parent get-width))
    (define webview-height (send parent get-height))

    ;(print (format "creating webkit-view x:~a, y:~a, height:~a, width:~a ~%" webview-x webview-y  webview-height webview-width))
    
    (define webview 
      (tell (tell WebView alloc) 
            initWithFrame: #:type _NSRect (make-NSRect (make-NSPoint webview-x webview-y) (make-NSSize webview-width webview-height))
            frameName: #f
            groupName: #f))

    (define client-view (send parent get-client-handle))
    (tell client-view addSubview: webview)

    (define (release id-ptr) (tell id-ptr release))

    (define main-frame
      (tell webview mainFrame))
    
    (define delegate
      (tell (tell MyWebFrameLoadDelegate alloc) init))

    (tell webview setFrameLoadDelegate: delegate) 

    (define/public (get-url)
      current-url)

    (define/public (set-url given-url)
      (set! current-url given-url)
      (let* ([url-string (tell (tell NSString alloc)
                               initWithUTF8String: #:type _string given-url)]
             [url (tell NSURL URLWithString: url-string)]
             [req (tell NSURLRequest requestWithURL: url)])
        (tell main-frame loadRequest: req)
        (release url-string)))

    (define/public (on-status-change status)
      (displayln (format "webkit-view status change: ~a" status)))
    
    ))

(provide webkit-view%)