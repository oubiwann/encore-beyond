(defmodule encore-beyond-meta-storage_tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))
    (from encore-beyond-meta-storage
      (read 1)
      (start 0)
      (stop 0)
      (write 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/data-records.lfe")

(deftest read-existing-record-returns-record
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 (metadata-record '"my-key" '"my-data"))
  (try
    (let* ((metadata (read '"my-key"))
           (record   (metadata-record '"my-key" '"my-data")))
      (is-equal metadata record))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(defun metadata-record (key-data value-data)
  (make-metadata key key-data value value-data))