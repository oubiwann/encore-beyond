(defmodule encore-beyond-util
  (export all))

(include-lib "yaws/include/yaws_api.hrl")
(include-lib "include/data-records.lfe")

(defun parse-path (arg-data)
  "Get pathinfo.

  This is used as the key to refer to specific preferences."
  (arg-pathinfo arg-data))

(defun parse-querydata (arg-data)
  (binary_to_list (arg-querydata arg-data)))

(defun parse-uri (arg-data)
  "Get URI.

  This is used to set a location header."
  (arg-server_path arg-data))

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

(defun make-header-field (field value)
  "Makes a header tuple in the format required by YAWS."
  (tuple 'header (tuple field value)))

(defun make-json-content (content)
  `#(content "application/json" ,content))

(defun make-json-result (data)
  (make-json-content
    (++ '"{\"result\": " data '"}")))

(defun make-result-created ()
  (make-result 201 (make-json-result '"\"created\"")))

(defun make-result-created (location)
  (make-result 201 (make-json-result '"\"created\"") (list (make-header-field 'location location))))

(defun make-result-error ()
  (make-result 500 (make-json-result '"\"error\"")))

(defun make-result-not-found ()
  (make-result 404 (make-json-result '"\"not found\"")))

(defun make-result-ok ()
  (make-result 200 (make-json-result '"\"ok\"")))

(defun make-result-ok (content)
  (make-result 200 (make-json-content content)))

(defun make-result (status_code content)
  `(#(status ,status_code) ,content))

(defun make-result (status_code content headers)
  (++ (make-result status_code content) headers))