(import-macros {: if-let } :aniseed.macros)
;; (module status.from_feline)
;; args = {
;; prop: string
;; pass_self: bool
;; opts: table
;; handle_tbl: fun
;; tandle_fn: fun
;; }

;; macro set default value if nil
(macro default! [obj def]
  `(local ,obj (or ,obj ,def)))
  ;; `(if (not ,obj) (var ,obj ,def)))
  ;; `(set ,var (or ,var def)))
;; (macro index! [obj [idx]] `(. ,obj ,idx))
(macro call! [f] `(,f))
;; (macro if-let [])
(macrodebug (index! v [0]))

(macro index! [obj [idx]] `(. ,obj ,idx))

;; return a property and
(fn wrap-feline-prop [heir {: prop : pass_self : handle_tbl : opts : handle_fn }]
  (local err_head "feline to heirline: ")
  (default! pass_self false)
  (default! handle_tbl #(error (.. err_head "table case not handled")))
  (default! opts {})
  (match (type (index! heir.feline [prop]))
    :nil nil
    :bolean (fn [self] (index! self.feline [prop]))
    :string (fn [self] (index! self.feline [prop]))
    :table (handle_tbl)
    :function
    (if handle_fn
      (handle_fn)
      pass_self ;; else if
      (fn [self] (-> self.feline (index! self.feline [prop])))
      ;; else
      (fn [self] (call! (index! self.feline [prop]))))))

(fn conv-hl-tbl [{: fg : bg :style cterm}]
  {: fg : bg : cterm})

;; return a provider component
(fn make-icon [icon fun]
  (match (type icon)
    :string {:provider icon}
    :table {:provider icon.str :hl (conv-hl-tbl icon.hl) } ;; TODO: handle icon.always_visible
    :function (fun)))

;; return a component: list of providers | one provider
(fn make-feline-sep [prop self]
  (if-let [opts (. self.feline prop)]
    (if (?. opts 1) ;; seq?
      (icollect [_ opt (ipairs opts)] (make-icon opt)) ;; seq
      (make-icon opts)))) ;; not seq
  ; t (error (.. err_head "invalind hl type " t " returned from function"))))))

(fn feline_to_heirline [_fe]
  ;; hold a reference to original feline component
  ;; so it can be passed to feline component methods
  (local err_head "feline to heirline: ")
  (var heir {:feline _fe})
  (local wrap-feline-prop (partial wrap-feline-prop heir))
  (set heir.hl
       (wrap-feline-prop
         {:prop :hl
          :handle_tbl #(fn [self] (conv-hl-tbl self.feline.hl))
          :handle_fn #(fn [self]
                        (let [ret (self.feline.hl)]
                          (match (type ret)
                            :string ret
                            :table (conv-hl-tbl ret))))}))
  (var info {})
  (set info.short_provider
       (wrap-feline-prop {:prop :short_provider :pass_self true}))
  (set info.provider
       (wrap-feline-prop
         {:prop :provider
          :pass_self true
          :handle_tbl #(do ; when feline.provider is a table
                         (set info.update (wrap-feline-prop {:prop :provider.update}))
                         (fn [self] {:name self.feline.provider.name :opts self.feline.provider.opts}))}))

  (local left-sep (partial make-feline-sep :left_sep))
  (local right-sep (partial make-feline-sep :right_sep))
  (local icon
       (if heir.feline.icon
         (make-icon heir.feline.icon
                    #(make-icon heir.feline.icon)))) ; TODO: PLM ???? vezi definitia recursiva
  (table.insert heir [left-sep icon info right-sep])
  heir)

;; feline_to_heirline = (fe) ->
;;   ;; NOTE: maybe make feline a static?
;;   ;; heir.static.feline = fe
;;
;;   comp_condition = update: transform prop: "enabled"
;;
;;   comp_icon = =>
;;     if icon = @feline.icon
;;       transform_icon icon, -> transform_icon icon
;;
;;   ;; TODO: feline.priority
;;   table.insert(heir, { comp_left_sep, comp_icon, comp_provider, comp_right_sep})
;;
;;   return heir
