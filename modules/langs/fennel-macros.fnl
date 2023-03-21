(import-macros {: if-let } :aniseed.macros)
;; macro set default value if nil

;; (lambda first [xs]
;;   (?. xs 1))
;;
;; (lambda second [xs]
;;   (?. xs 2))
;;
;; (lambda last [xs]
;;   (?. xs (length xs)))
;;
;; (lambda tail [xs]
;;   (let [[h & t] xs] t))

(macro default [obj def]
  `(local ,obj (or ,obj ,def)))
  ;; `(if (not ,obj) (var ,obj ,def)))
  ;; `(set ,var (or ,var def)))
;; (macro index! [obj [idx]] `(. ,obj ,idx))
(macro call [f] `(,f))
;; (macro if-let [])

(macro index [obj [idx]] `(. ,obj ,idx))

(macro printt [list ...]
  (do
    (fn type-str [v]
      (if (list? v) :list
        (sequence? v) :seq
        (table? v) :tbl
        (sym? v) :sym
        (varg? v) :varg
        (multi-sym? v) :m-sym
        (type v)))
    (print ...)
    (each [_ v (ipairs list)]
      (do
        (print v (type-str v))
        (if (or (table? v) (list? v))
          (do
            (print :t: v (type-str v))
            (each [_ v (ipairs v)]
              (print "*" v (type-str v))))
          ;; (list? v)
          ;; (each [_ e (ipairs v)] (print :n e))
          ))))
  )

(macro switch-let [assign ...]
  (assert-compile
    (sequence? assign)
    (.. "switch-let needs a binding of the form [...] \n\t\tbut instead got: " (view assign)))
  (fn head [xs] (?. xs 1))
  (fn unwrap-if-1 [xs]
    (if (= (length xs) 1)
      (head xs)
      xs))
  (local v (head assign))
  (local match-val
    (if (sym? v) v
      (sequence? v) (unwrap-if-1 v)
      (table? v) (unwrap-if-1 (vim.tbl_values v))))
  `(let ,assign (match ,match-val ,...)))

(macrodebug
  (switch-let
    [[x y] (f)]
    :a 1
    :b (.. x :al)))

(print
  (switch-let
    [{: x} {:x :b}]
    :a 1
    :b (.. x :al)))

;; (macrodebug (printt (f &arg1 (g 89) arg2 [69 aba :ceva nush]) (ff m) lala))
