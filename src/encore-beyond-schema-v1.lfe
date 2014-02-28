(defmodule encore-beyond-schema-v1
  (export all)
  (import
    (from encore-beyond-demo
      (get-data 2))
    (from encore-beyond-schema
      (dispatch 3))
    (from encore-beyond-util
      (meta-out 2))))

(defun routes
  "Routes for Metadata Schema REST API"
  (('"/test" method arg-data)
    (get-data method arg-data))
  (('"/demo" method arg-data)
    (get-data method arg-data))
  ((path method arg-data)
    (dispatch method path arg-data)))

(defun out (arg-data)
  "This is called by YAWS when the requested URL matches the URL specified in
  the YAWS config (see ./etc/yaws.conf) with the 'appmods' directive for the
  virtual host in question.

  In particular, this function is intended to handle all v1 traffic for this
  REST API."
  (meta-out arg-data #'routes/3))
