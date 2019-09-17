#lang racket/gui
(require framework)
(require ffi/unsafe)
(require ffi/unsafe/objc)
 (require ffi/unsafe/nsstring)
(require racket/class)

(ffi-lib "/System/Library/Frameworks/WebKit.framework/WebKit")
(import-class WKWebView)
(import-class WKWebViewConfiguration)
(import-class NSURLRequest)
(import-class NSURL)
(import-class NSView)
(import-class NSString)
(import-class NSObject)
(import-class WKNavigation)
(import-protocol WKNavigationDelegate)


(define wk-web-view%
  (class object%
    (super-new)

    (init parent)

    (define current-url #f)

    (define-cstruct _NSPoint ([x _double*]
                              [y _double*]))

    (define-cstruct _NSSize ([width _double*]
                             [height _double*]))
        
    (define-cstruct _CGRect ([origin _NSPoint]
                             [size _NSSize]))

    (define webview-x (send parent get-x))

    (define webview-y (send parent get-y))

    (define webview-width (send parent get-width))

    (define webview-height (send parent get-height))

    (define configuration 
      (tell (tell WKWebViewConfiguration alloc) init))

    (define (release id-ptr) (tell id-ptr release))

    (define (make-rect)
      (make-CGRect (make-NSPoint webview-x webview-y) (make-NSSize webview-width webview-height)))

    (define webview 
      (tell (tell WKWebView alloc) 
            initWithFrame: #:type _CGRect (make-rect)
            configuration: configuration))

    (define-objc-class WebViewDelegate NSObject
      #:protocols (WKNavigationDelegate)
      []
      (- _void (webView: [_id view] didCommitNavigation: [_id navigation])
         (displayln "commit!"))
      (- _void (webView: [_id view] didFinishNavigation: [_id navigation])
         (displayln "finish!")))

    (define delegate
      (tell (tell WebViewDelegate alloc) init))

    (tell (send parent get-client-handle) addSubview: webview)

    (object_setInstanceVariable webview "navigationDelegate" delegate)

    (define/public (get-title)
      (tell #:type _NSString webview title))

     (define/public (get-url)
      (define url
        (tell webview URL))
      (tell #:type _NSString url absoluteString))

    (define/public (set-url given-url)
      (set! current-url given-url)
      (let* ([url-string (tell (tell NSString alloc)
                               initWithUTF8String: #:type _string given-url)]
             [url (tell NSURL URLWithString: url-string)]
             [req (tell NSURLRequest requestWithURL: url)])
        (tell webview loadRequest: req)
        (release url-string)))

    (define/public (on-status-change status)
      (displayln (format "webkit-view status change: ~a" status)))

    (define/public (can-handle-url? given-url)
       (let* ([url-string (tell (tell NSString alloc)
                               initWithUTF8String: #:type _string given-url)])
        (define ret (tell webview handlesURLScheme: url-string ))
        (release url-string)
        ret))

    (define/public (go-forward)
      (tell webview goForward))

    (define/public (go-back)
      (tell webview goBack))

    (define/public (reload)
      (tell webview reload))
    
    ))

(provide wk-web-view%)