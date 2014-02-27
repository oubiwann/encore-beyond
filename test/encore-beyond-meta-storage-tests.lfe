(defmodule encore-beyond-meta-storage-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))
    (from encore-beyond-meta-storage
      (read 1)
      (start 0)
      (table-name 0)
      (write 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/data-records.lfe")

(deftest read-returns-record
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1
    (list (metadata-record '"/domain/key" '"my-data")))
  (try
    (let* ((metadata (read '"/domain/key"))
           (record   (list (metadata-record '"/domain/key" '"my-data"))))
      (is-equal metadata record))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-returns-multiple-records
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1
     (list (metadata-record '"/domain/key" '"my-data")
           (metadata-record '"/domain/key2" '"my-data")))
  (try
    (let* ((metadata (read '"/domain/key"))
           (record   (list
                      (metadata-record '"/domain/key" '"my-data")
                      (metadata-record '"/domain/key2" '"my-data"))))
      (is-equal metadata record))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-returns-empty-record-list
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 ())
  (try
    (let* ((metadata (read '"/domain/nokey")))
      (is-match () metadata))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-with-storage-error-returns-error
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 #(aborted #(no_exists ())))
  (try
    (let* ((metadata (read '"/domain/nokey")))
      (is-match #(aborted #(no_exists ())) metadata))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest start-starts-mnesia-and-creates-table
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'start 0 ())
  (: meck expect 'mnesia 'create_table 2 #(atomic ok))
  (try
    (is-match ok (start))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest table-name-returns-metadata
  (is-equal 'metadata (table-name)))

(defun metadata-record (key-data value-data)
  (make-metadata key key-data value value-data))