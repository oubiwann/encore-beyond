(defmodule encore-beyond-util-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))
    (from encore-beyond-util
      (make-json-content 1)
      (make-json-result 1)
      (make-json-error 0)
      (make-json-fail 0)
      (make-json-not-found 0)
      (make-json-ok 0))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")

(deftest make-json-content
  (is-equal
    #(content "application/json" "forty-two")
    (make-json-content '"forty-two")))

(deftest make-json-result
  (is-equal
    #(content "application/json" "{\"result\": forty-two}")
    (make-json-result '"forty-two")))

(deftest make-json-error
  (is-equal
    #(content "application/json" "{\"result\": \"error\"}")
    (make-json-error)))

(deftest make-json-fail
  (is-equal
    #(content "application/json" "{\"result\": \"fail\"}")
    (make-json-fail)))

(deftest make-json-not-found
  (is-equal
    #(content "application/json" "{\"result\": \"not found\"}")
    (make-json-not-found)))

(deftest make-json-ok
  (is-equal
    #(content "application/json" "{\"result\": \"ok\"}")
    (make-json-ok)))
