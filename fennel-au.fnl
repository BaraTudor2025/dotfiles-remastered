(module test-fennel
  { require-macros [:hibiscus.vim] })

(augroup! :general-au
  [[TextYankPost] * #(vim.highlight.on_yank {:higroup :Search :timeout 200})]
  [[FileType] qf #(set! nobuflisted)]
  [[FileType] [qf help man lspinfo] #(map! [n :buffer] :q #(vim.cmd.close))])

(augroup! :PackerHooks
  [[User] PackerCompileDone #(vim.notify "Compile Done!" vim.log.levels.INFO { :title :Packer })])

(augroup! :relative-num
  [[InsertEnter] * #(set! norelativenumber)]
  [[InsertLeave] * #(set! relativenumber)])

(augroup! :vimrc-help
  [[BufRead] [*.txt]
   #(if (= vim.o.buftype :help)
     (map! [n :buffer] :J :<C-d>)
     (map! [n :buffer] :K :<C-u>))])


;; (augroup! :lua-include
;;   [[FileType] *.lua #(set! :include :require)])
