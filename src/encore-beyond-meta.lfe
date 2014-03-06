(defmodule encore-beyond-meta
  (export all)
  (import
    (rename encore-beyond-meta-storage
      ((read-one 1) storage-read-one)
      ((write 2) storage-write))
    (from encore-beyond-util
      (make-json-content 1)
      (make-result-created 0)
      (make-result-created 1)
      (make-result-error 0)
      (make-result-not-found 0)
      (make-result-ok 0)
      (make-result-ok 1)
      (parse-querydata 1)
      (parse-uri 1))))

(include-lib "include/data-records.lfe")

(defun dispatch
  "This is called by YAWS to determine and render a response."
  (('GET path arg-data)
   (let ((result (storage-read-one path)))
     (case result
       ((tuple 'ok record)
        (case record
          ('undefined (make-result-not-found))
          (_ (make-result-ok (metadata-value record)))))
       (_ (make-result-error)))))

  (('PUT path arg-data)
   (: io format '"~p~n" (list arg-data))
   (: io format '"~p~n" (list (: erlang element 7 arg-data)))
   (let ((value (parse-querydata arg-data)))
     (let ((result (storage-write path value)))
       (case result
         ((tuple atomic ok)
          (make-result-created (parse-uri arg-data)))
         (_ (make-result-error)))))))