(defmodule encore-beyond-storage-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))
    (from encore-beyond-storage
      (read 2)
      (read-one 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")

(deftest read
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 (list 'key-1))
  (try
    (let* ((expected (tuple 'ok (list 'key-1)))
          (actual (read 'my-table-name 'my-key)))
      (is-equal expected actual))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-with-error
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 (tuple 'aborted '"error"))
  (try
    (let* ((expected (tuple 'error (tuple 'aborted '"error")))
           (actual (read 'my-table-name 'my-error-key)))
      (is-equal expected actual))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-one
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 (list 'record-1))
  (try
    (let* ((metadata (read-one '"table-name" '"/domain/key"))
           (record (tuple 'ok 'record-1)))
      (is-equal metadata record))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-one-with-multiple-results
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 (list 'record-1 'record-2))
  (try
    (let* ((metadata (read-one '"table-name" '"/domain/key"))
           (record (tuple 'ok 'record-1)))
      (is-equal metadata record))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-one-with-no-results
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 ())
  (try
    (let* ((metadata (read-one '"table-name" '"/domain/key"))
           (record (tuple 'ok 'undefined)))
      (is-equal metadata record))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))

(deftest read-one-with-error
  (: meck new 'mnesia)
  (: meck expect 'mnesia 'dirty_read 1 (tuple 'aborted 'error))
  (try
    (let* ((metadata (read-one '"table-name" '"/domain/key"))
           (record (tuple 'error (tuple 'aborted 'error))))
      (is-equal metadata record))
    (after
      (: meck validate 'mnesia)
      (: meck unload 'mnesia))))
