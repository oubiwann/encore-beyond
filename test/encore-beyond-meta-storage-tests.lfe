(defmodule encore-beyond-meta-storage-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))
    (from encore-beyond-meta-storage
      (read 1)
      (read-one 1)
      (start 0)
      (table-name 0)
      (write 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/data-records.lfe")

(deftest read
  (: meck new 'encore-beyond-storage)
  (: meck expect 'encore-beyond-storage 'read 2
    (tuple 'ok (list (metadata-record '"/domain/key" '"my-data"))))
  (try
    (let* ((metadata (read '"/domain/key"))
           (record (tuple 'ok (list (metadata-record '"/domain/key" '"my-data")))))
      (is-equal metadata record))
    (after
      (: meck validate 'encore-beyond-storage)
      (: meck unload 'encore-beyond-storage))))

(deftest read-one
  (: meck new 'encore-beyond-storage)
  (: meck expect 'encore-beyond-storage 'read-one 2
    (tuple 'ok (metadata-record '"/domain/key" '"my-data")))
  (try
    (let* ((metadata (read-one '"/domain/key"))
           (record (tuple 'ok (metadata-record '"/domain/key" '"my-data"))))
      (is-equal metadata record))
    (after
      (: meck validate 'encore-beyond-storage)
      (: meck unload 'encore-beyond-storage))))

(deftest start-starts-encore-beyond-storage-and-creates-table
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'start 0 ())
  (: meck expect 'mnesia 'create_table 2 #(atomic ok))
  (try
    (is-match 'ok (start))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest table-name-returns-metadata
  (is-equal 'metadata (table-name)))

(defun metadata-record (key-data value-data)
  (make-metadata key key-data value value-data))