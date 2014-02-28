(defmodule encore-beyond-meta
  (export all)
  (import
    (rename encore-beyond-meta-storage
      ((read 1) storage-read)
      ((write 2) storage-write))
    (from encore-beyond-util
      (make-json-content 1)
      (make-json-error 0)
      (make-json-fail 0)
      (make-json-not-found 0)
      (make-json-ok 0))))

(include-lib "include/data-records.lfe")

(defun dispatch
  "This is called by Yaws to determine and render a response."
  (('GET path arg-data)
   (let ((result (car (storage-read path))))
     (if (is-metadata result)
       (make-json-content (metadata-value result))
       (make-json-error))))

  (('PUT path arg-data)
   (let ((value (binary_to_list (: erlang element 7 arg-data))))
     (let ((result (storage write path value)))
       (case result
         ((tuple atomic ok) (make-json-ok))
         (_ (make-json-fail)))))))
