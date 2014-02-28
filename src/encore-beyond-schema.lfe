(defmodule encore-beyond-schema
  (export all)
  (import
    (from encore-beyond-util
      (make-json-content 1)
      (make-json-error 0)
      (make-json-fail 0)
      (make-json-not-found 0)
      (make-json-ok 0))))


(defun dispatch
  "If you'd like to see the the arg-data parameter printed out for any given
  dispatch below, simply comment it out. The lines that print to stdout
  are commented below in order to better assess perfmance when benchmarking.

  Note that some of the below are not actually supported by YAWS, but
  presented here for completeness. (In particular, TRACE and CONNECT are not
  supported.)"
  (('GET path arg-data)
    (make-json-content '"\"Here, hazsomeGETdatuhz!\"")))
