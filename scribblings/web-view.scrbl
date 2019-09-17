#lang scribble/manual
@require[@for-label[web-view
                    racket/class
                    racket/base
                    racket/gui]]

@title{A Racket GUI widget to display web pages}
@author{Andre Alves Garzia}

@defmodule[web-view]

This module contains a Web View to be used with Racket GUI Toolkit. At the moment it works only with macOS because it wraps @hyperlink["https://developer.apple.com/documentation/webkit/wkwebview?language=objc"]{WKWebView} from WebKit.

There is a @hyperlink["https://github.com/soapdog/racket-web-view/blob/master/demo/demo.rkt"]{Demo Browser available on the Github Repository}.

@defclass[web-view% object% ()]{

A widget to display web pages.

@defconstructor[([parent (or/c (is-a?/c frame%)
                               (is-a?/c dialog%)
                               (is-a?/c panel%)
                               (is-a?/c pane%))]
                 [on-status-change ((is-a?/c button%) (is-a?/c control-event%) . -> . any) (lambda (b e) (void))])]{

  Construct a new widget. 

  The @racket[on-status-change] procedure is used to receive navigation events from the web view.

}

@defmethod*[([(set-url [url string?]) any/c])]{

Set the URL for the web view.

}

@defmethod*[([(get-url) string?])]{

Get the current URL loaded in the web view.

}


@defmethod*[([(go-forward) any/c])]{

Navigates forward.

}


@defmethod*[([(go-back) any/c])]{

Navigates backward.

}


@defmethod*[([(reload) any/c])]{

Reloads the current page.

}

@defmethod*[([(set-html-text [text string?] [base-url string?]) any/c])]{

Sets the HTML text being used by the web view. Any relative url will be relative to the specified base url.

}

}
