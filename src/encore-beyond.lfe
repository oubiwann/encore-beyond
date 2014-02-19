(defmodule encore-beyond
  (export all))

(defun start ()
  "start/0 is expected by yaws as an entry point for an
  application. This mechanism is temporary until an otp
  behavior is implemented.

  Returns 'ok."
  (let (('ok
         (: encore-beyond-meta-storage start))))
  'ok)