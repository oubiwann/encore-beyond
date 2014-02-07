(defmodule encore-beyond-v1
  (export all))


(defun routes
  "REST API Routes"
  (('"/demo" method arg-data)
    (: encore-beyond-demo get-data method arg-data))
  ((a b c)
    (: io format '"path-info: ~p method: ~p arg-data: ~p~n" (list a b c))
    #(content
      "application/json"
      "{\"error\": \"Unmatched route.\"}")))


(defun out (arg-data)
  "This is called by YAWS when the requested URL matches the URL specified in
  the YAWS config (see ./etc/yaws.conf) with the 'appmods' directive for the
  virtual host in question.

  In particular, this function is intended to handle all v1 traffic for this
  REST API."
  (: encore-beyond-util meta-out arg-data #'routes/3))
