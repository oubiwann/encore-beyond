(defmodule encore-beyond-util
  (export all))

(include-lib "yaws/include/yaws_api.hrl")

(defun parse-path (arg-data)
  "Get pathinfo.

  This is used as the key to refer to specific preferences."
  (arg-pathinfo arg-data))

(defun method (arg-data)
  "Use the LFE record macros to parse data from the records defined in
  yaws_api.hrl."
  (let ((record (arg-req arg-data)))
    (http_request-method record)))

(defun meta-out (arg-data router)
  "This function can be called by all other out functions, as it handles the
  method name parsing. YAWS cannot use this function directly."
  (let ((method-name (method arg-data))
        (path-info (parse-path arg-data)))
    (funcall router path-info method-name arg-data)))

(defun make-json-content (content)
  `#(content "application/json" ,content))

(defun make-json-result (data)
  (make-json-content
    (++ '"{\"result\": " data '"}")))

(defun make-json-error ()
  (make-json-result '"\"error\""))

(defun make-json-fail ()
  (make-json-result '"\"fail\""))

(defun make-json-not-found ()
  (make-json-result '"\"not found\""))

(defun make-json-ok ()
  (make-json-result '"\"ok\""))
