(defmodule encore-beyond-meta-v1
  (export all))


(defun routes
  "Routes for Metadata REST API"
  (('"/test" method arg-data)
    (: encore-beyond-demo get-data method arg-data))
  (('"/demo" method arg-data)
    (: encore-beyond-demo get-data method arg-data))
  ((path method arg-data)
    (: encore-beyond-meta dispatch method path arg-data)))

(defun out (arg-data)
  "This is called by YAWS when the requested URL matches the URL specified in
  the YAWS config (see ./etc/yaws.conf) with the 'appmods' directive for the
  virtual host in question.

  In particular, this function is intended to handle all v1 traffic for this
  REST API."
  (: encore-beyond-util meta-out arg-data #'routes/3))
