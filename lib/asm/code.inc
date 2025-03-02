;;;;;;;;;;;;;;;;;;;
; structured coding
;;;;;;;;;;;;;;;;;;;

;module
(env-push)

(defmacro beg-sym () '(sym (str "b_" *switch*)))
(defmacro end-sym () '(sym (str "e_" *switch*)))
(defmacro loc-sym (n) `(sym (str "o_" *switch* "_" ,n)))
(defmacro cnt-sym () '(sym (str "_c_" *switch*)))
(defmacro llb-sym (_) `(sym (cat "_b_" ,_)))
(defmacro lle-sym (_) `(sym (cat "_e_" ,_)))

(defun goto (l)
	(vp-jmp l))

(defun gotoif (e l)
	(bind '(d o s) (cond
		((str? e) (assign e '(:r0)) '(:r0 /= 0))
		(e)))
	(defq e (find-rev o '(= /= <= >= > <)))
	(case (assign-src-type s)
		(:c (if e ((eval (elem-get e '(vp-beq-cr vp-bne-cr vp-ble-cr vp-bge-cr vp-bgt-cr vp-blt-cr))) s d l)
			(throw "No such comparator" o)))
		(:r (if e ((eval (elem-get e '(vp-beq-rr vp-bne-rr vp-ble-rr vp-bge-rr vp-bgt-rr vp-blt-rr))) s d l)
			(throw "No such comparator" o)))
		(:t (throw "No such compare mode" (assign-src-type s)))))

(defun gotoifnot (e l)
	(bind '(d o s) (cond
		((str? e) (assign e '(:r0)) '(:r0 /= 0))
		(e)))
	(defq e (find-rev o '(/= = > < <= >=)))
	(case (assign-src-type s)
		(:c (if e ((eval (elem-get e '(vp-beq-cr vp-bne-cr vp-ble-cr vp-bge-cr vp-bgt-cr vp-blt-cr))) s d l)
			(throw "No such comparator" o)))
		(:r (if e ((eval (elem-get e '(vp-beq-rr vp-bne-rr vp-ble-rr vp-bge-rr vp-bgt-rr vp-blt-rr))) s d l)
			(throw "No such comparator" o)))
		(:t (throw "No such compare mode" (assign-src-type s)))))

(defun switch (&optional _)
	(push *switch_stk* *switch*)
	(setq *switch* *switch_nxt* *switch_nxt* (inc *switch_nxt*))
	(when _ (deffvar (llb-sym _) (beg-sym) (lle-sym _) (end-sym)))
	(deffvar (cnt-sym) 0))

(defun default ()
	(vp-label (loc-sym (defq s (cnt-sym) c (eval s))))
	(set (penv) s (inc c)))

(defun endswitch ()
	(vp-label (end-sym))
	(default)
	(setq *switch* (pop *switch_stk*)))

(defun nextcaseif (e)
	(gotoif e (loc-sym (eval (cnt-sym)))))

(defun nextcaseifnot (e)
	(gotoifnot e (loc-sym (eval (cnt-sym)))))

(defun exitif (e)
	(gotoif e (if l (eval (lle-sym l)) (end-sym))))

(defun exitifnot (e)
	(gotoifnot e (if l (eval (lle-sym l)) (end-sym))))

(defun repeatif (e)
	(gotoif e (if l (eval (llb-sym l)) (beg-sym))))

(defun repeatifnot (e)
	(gotoifnot e (if l (eval (llb-sym l)) (beg-sym))))

(defun break (&optional l)
	(goto (if l (eval (lle-sym l)) (end-sym))))

(defun continue (&optional l)
	(goto (if l (eval (llb-sym l)) (beg-sym))))

(defun breakif (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(each! 0 i exitif (list e)))

(defun breakifnot (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(each! 0 i exitifnot (list e)))

(defun continueif (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(each! 0 i repeatif (list e)))

(defun continueifnot (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(each! 0 i repeatifnot (list e)))

(defun vpcase (&rest e)
	(default)
	(each! 0 -1 nextcaseifnot (list e)))

(defun vpcasenot (&rest e)
	(default)
	(each! 0 -1 nextcaseif (list e)))

(defun loop-start (&optional l)
	(switch l)
	(vp-label (beg-sym)))

(defun loop-while (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(switch l)
	(vp-label (beg-sym))
	(each! 0 i exitifnot (list e)))

(defun loop-whilenot (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(switch l)
	(vp-label (beg-sym))
	(each! 0 i exitif (list e)))

(defun loop-end ()
	(continue)
	(endswitch))

(defun loop-until (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(each! 0 i repeatifnot (list e))
	(endswitch))

(defun loop-untilnot (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(each! 0 i repeatif (list e))
	(endswitch))

(defun vpif (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(switch l)
	(each! 0 i nextcaseifnot (list e)))

(defun vpifnot (&rest e)
	(unless (sym? (defq i -2 l (last e)))
		(setq i -1 l :nil))
	(switch l)
	(each! 0 i nextcaseif (list e)))

(defun else ()
	(break)
	(default))

(defun elseif (&rest e)
	(else)
	(each! 0 -1 nextcaseifnot (list e)))

(defun elseifnot (&rest e)
	(else)
	(each! 0 -1 nextcaseif (list e)))

(defun endif ()
	(endswitch))

;;;;;;;;;;;;
; errorcase
;;;;;;;;;;;;

(defmacro errorcase (&rest e) (if (> *debug_mode* 0) `(progn ~e)))
(defmacro noterrorcase (&rest e) (if (<= *debug_mode* 0) `(progn ~e)))
(defmacro errorif (e l) `(errorcase (gotoif ,e ,l)))
(defmacro errorifnot (e l) `(errorcase (gotoifnot ,e ,l)))

(defmacro errorif-lisp-args-len (args cnd len err)
	`(errorcase
		(assign '((,args array_length)) '(:r2))
		(gotoif '(:r2 ,cnd ,len) ,err)))

(defmacro errorif-lisp-args-sig (args len l)
	`(errorcase
		(call 'lisp :env_args_sig '(,args ($ sig) ,len) '(tmp))
		(gotoif `(,tmp = 0) ,l)))

(defmacro errorif-lisp-args-sig-range (args len1 len2 l)
	`(errorcase
		(bind '(e_args e_sig e_num) (method-input 'lisp :env_args_sig))
		(assign '((,args array_length)) `(,e_num))
		(if (> ,len1 0) (gotoif `(,e_num < ,,len1) ,l))
		(gotoif `(,e_num > ,,len2) ,l)
		(call 'lisp :env_args_sig `(,,args ($ sig) ,e_num) '(tmp))
		(gotoif `(,tmp = 0) ,l)))

(defmacro errorif-lisp-args-match (args class len l)
	`(errorcase
		(call 'lisp :env_args_match '(,args (@ ,(f-path class :vtable)) ,len) '(tmp))
		(gotoif `(,tmp = 0) ,l)))

(defmacro errorif-lisp-args-type (args class len l)
	`(errorcase
		(call 'lisp :env_args_type '(,args (@ ,(f-path class :vtable)) ,len) '(tmp))
		(gotoif `(,tmp = 0) ,l)))

;;;;;;;
; enums
;;;;;;;

(defun def-enum (size)
	(push syms (sym (cat name "_" field)))
	(push values (num-intern base))
	(setq base (+ base size)))

(defmacro def-enum (name base &rest lines)
	; (def-enum name base [(enum field ...)] ...)
	(if (def? (sym (cat name "_size")) *compile_env*) (throw "Enum redefined !" name))
	(defq syms (list) values (list) base (eval base))
	(each (lambda (line)
		(each! 1 -1 (lambda (field)
			(case (first line)
				(enum (def-enum +byte_size))))
			(list line))) lines)
	(push syms (sym (cat name "_size")))
	(push values (num-intern base))
	`(eval '(bind ',syms ',values) *compile_env*))

;;;;;;
; bits
;;;;;;

(defun def-bit ()
	(push syms (sym (cat name "_" field)))
	(push values (num-intern (<< 1 base)))
	(setq base (inc base)))

(defmacro def-bit (name base &rest lines)
	; (def-bit name base [(bit field ...)] ...)
	(if (def? (sym (cat name "_size")) *compile_env*) (throw "Bit redefined !" name))
	(defq syms (list) values (list) base (eval base))
	(each (lambda (line)
		(each! 1 -1 (lambda (field)
			(case (first line)
				(bit (def-bit))))
			(list line))) lines)
	(push syms (sym (cat name "_size")))
	(push values (num-intern base))
	`(eval '(bind ',syms ',values) *compile_env*))

;;;;;;;;;;;;
; structures
;;;;;;;;;;;;

(defmacro def-struct (name base &rest lines)
	; (def-struct name base [(byte field ...)] ...)
	(unless (eql (cat name "_size") "local_size")
		(if (def? (sym (cat name "_size")) *compile_env*) (throw "Structure redefined !" name)))
	(defq syms (list) values (list) base (eval base))
	(each (lambda (line)
		(setq base (_structure base line))) lines)
	(push syms (sym (cat name "_size")))
	(push values (num-intern base))
	`(eval '(bind ',syms ',values) *compile_env*))

;module
(export-symbols
	'(def-enum def-struct def-bit
	errorcase noterrorcase errorif errorifnot
	errorif-lisp-args-len errorif-lisp-args-sig errorif-lisp-args-sig-range
	errorif-lisp-args-match errorif-lisp-args-type
	switch endswitch vpcase vpcasenot default nextcaseif nextcaseifnot
	vpif vpifnot else elseif elseifnot endif
	break breakif breakifnot goto gotoif gotoifnot exitif exitifnot
	loop-start loop-end loop-while loop-whilenot loop-until loop-untilnot
	continue continueif continueifnot repeatif repeatifnot))
(env-pop)
