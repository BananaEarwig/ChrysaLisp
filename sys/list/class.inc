(include "lib/asm/class.inc")

(def-class sys_list :nil
	(dec-method :init sys/list/init :static (:r0)))

;;;;;;;;;;;;;;;;;
; list structures
;;;;;;;;;;;;;;;;;

(def-struct lh_list 0
	(ptr head tail tailpred))

(def-struct ln_node 0
	(ptr succ pred))

(def-struct ln_fnode 0
	(ptr next))

;;;;;;;;;;;;;;;;;;
; list node macros
;;;;;;;;;;;;;;;;;;

(defun ln-set-succ (_1 _2 _3)
	;inputs
	;_1 = list node
	;_2 = offset
	;_3 = succ
	;outputs
	;_1 = list node
	;_3 = succ

	(vp-cpy-ri _3 _1 (+ ln_node_succ _2)))

(defun ln-set-pred (_1 _2 _3)
	;inputs
	;_1 = list node
	;_2 = offset
	;_3 = pred
	;outputs
	;_1 = list node
	;_3 = pred

	(vp-cpy-ri _3 _1 (+ ln_node_pred _2)))

(defun ln-get-succ (_1 _2 _3)
	;inputs
	;_1 = list node
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list node
	;_3 = succ

	(vp-cpy-ir _1 (+ ln_node_succ _2) _3))

(defun ln-get-pred (_1 _2 _3)
	;inputs
	;_1 = list node
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list node
	;_3 = pred

	(vp-cpy-ir _1 (+ ln_node_pred _2) _3))

(defun ln-add-node-after (_1 _2 _3)
	;inputs
	;_1 = list node1
	;_2 = list node2
	;_3 = temp
	;outputs
	;_1 = list node1
	;_2 = list node2
	;_3 = list node1 succ

	(ln-get-succ _1 0 _3)
	(ln-set-succ _1 0 _2)
	(ln-set-pred _3 0 _2)
	(ln-set-succ _2 0 _3)
	(ln-set-pred _2 0 _1))

(defun ln-add-node-before (_1 _2 _3)
	;inputs
	;_1 = list node1
	;_2 = list node2
	;_3 = temp
	;outputs
	;_1 = list node1
	;_2 = list node2
	;_3 = list node1 pred

	(ln-get-pred _1 0 _3)
	(ln-set-succ _2 0 _1)
	(ln-set-pred _2 0 _3)
	(ln-set-succ _3 0 _2)
	(ln-set-pred _1 0 _2))

(defun ln-remove-node (_1 _2)
	;inputs
	;_1 = list node
	;_2 = temp
	;outputs
	;_1 = list node pred
	;_2 = list node succ

	(ln-get-succ _1 0 _2)
	(ln-get-pred _1 0 _1)
	(ln-set-pred _2 0 _1)
	(ln-set-succ _1 0 _2))

(defun ln-replace-node (_1 _2 _3)
	;inputs
	;_1 = list node
	;_2 = new list node
	;_3 = temp
	;outputs
	;_1 = list node
	;_2 = new list node

	(ln-get-succ _1 0 _3)
	(ln-set-succ _2 0 _3)
	(ln-set-pred _3 0 _2)
	(ln-get-pred _1 0 _3)
	(ln-set-pred _2 0 _3)
	(ln-set-succ _3 0 _2))

(defun ln-is-first (_1 _2 _3)
	;inputs
	;_1 = list node
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list node
	;_3 = 0 if first, else not

	(ln-get-pred _1 _2 _3)
	(ln-get-pred _3 0 _3))

(defun ln-is-last (_1 _2 _3)
	;inputs
	;_1 = list node
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list node
	;_3 = 0 if last, else not

	(ln-get-succ _1 _2 _3)
	(ln-get-succ _3 0 _3))

;;;;;;;;;;;;;;;;;;;;
; list header macros
;;;;;;;;;;;;;;;;;;;;

(defun lh-list-object (l)
	(vp-align +ptr_size)
(vp-label l)
	(times lh_list_size (vp-byte 0)))

(defun lh-set-head (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list head
	;_3 = list node

	(vp-cpy-ri _3 _1 (+ lh_list_head _2)))

(defun lh-set-tail (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list head
	;_3 = list node

	(vp-cpy-ri _3 _1 (+ lh_list_tailpred _2)))

(defun lh-get-head (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list head
	;_3 = list node

	(vp-cpy-ir _1 (+ lh_list_head _2) _3))

(defun lh-get-tail (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list head
	;_3 = list node

	(vp-cpy-ir _1 (+ lh_list_tailpred _2) _3))

(defun lh-init (_1 _2)
	;inputs
	;_1 = list head
	;_2 = temp
	;outputs
	;_1 = list head
	;_2 = list tail

	(vp-xor-rr _2 _2)
	(vp-cpy-ri _2 _1 lh_list_tail)
	(lh-set-tail _1 0 _1)
	(vp-lea-i _1 lh_list_tail _2)
	(lh-set-head _1 0 _2))

(defun lh-add-at-head (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = list node
	;_3 = temp
	;outputs
	;_1 = list head
	;_2 = list node
	;_3 = list node succ

	(ln-add-node-after _1 _2 _3))

(defun lh-add-at-tail (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = list node
	;_3 = temp
	;outputs
	;_1 = list head
	;_2 = list node
	;_3 = list node pred

	(vp-lea-i _1 lh_list_tail _1)
	(ln-add-node-before _1 _2 _3)
	(vp-lea-i _1 (neg lh_list_tail) _1))

(defun lh-remove-head (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = temp
	;_3 = temp
	;outputs
	;_1 = list tail
	;_2 = 0
	;_3 = temp
	;else
	;_1 = list node pred
	;_2 = list node
	;_3 = list node succ

	(lh-get-head _1 0 _1)
	(ln-get-succ _1 0 _2)
	(vpif (list _2 '/= 0))
		(vp-cpy-rr _1 _2)
		(ln-remove-node _1 _3)
	(endif))

(defun lh-remove-tail (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = temp
	;_3 = temp
	;outputs
	;_1 = list tailpred
	;_2 = 0
	;_3 = temp
	;else
	;_1 = list node pred
	;_2 = list node
	;_3 = list node succ

	(lh-get-tail _1 0 _1)
	(ln-get-pred _1 0 _2)
	(vpif (list _2 '/= 0))
		(vp-cpy-rr _1 _2)
		(ln-remove-node _1 _3)
	(endif))

(defun lh-is-empty (_1 _2 _3)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = temp
	;outputs
	;_1 = list head
	;_3 = 0 if empty, else not

	(lh-get-head _1 _2 _3)
	(ln-get-succ _3 0 _3))

;;;;;;;;;;;;;;;;;;;;;
; forward list macros
;;;;;;;;;;;;;;;;;;;;;

(defun ln-next-fnode (_1 _2)
	;inputs
	;_1 = node
	;_2 = last
	;trashes
	;_1, _2

	(vp-cpy-rr _1 _2)
	(vp-cpy-ir _1 ln_fnode_next _1)
	(breakif (list _1 '= 0)))

(defun ln-remove-fnode (_1 _2)
	;inputs
	;_1 = node
	;_2 = last
	;outputs
	;_2 = last
	;trashes
	;_1

	(vp-cpy-ir _1 ln_fnode_next _1)
	(vp-cpy-ri _1 _2 ln_fnode_next)
	(vp-cpy-rr _2 _1))

(defun ln-add-fnode (_1 _2 _3 _4)
	;inputs
	;_1 = list
	;_2 = offset
	;_3 = node
	;_4 = temp
	;trashes
	;_4

	(vp-cpy-ir _1 (+ _2 ln_fnode_next) _4)
	(vp-cpy-ri _4 _3 ln_fnode_next)
	(vp-cpy-ri _3 _1 (+ _2 ln_fnode_next)))

;;;;;;;;;;;;;;;;;;
; list loop macros
;;;;;;;;;;;;;;;;;;

(defun loop-list-forward (_1 _2 _3 _4 &optional _5)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = list node
	;_4 = list node look ahead
	;_5 = loop label
	;outputs
	;_1 = list head
	;_3 = list node
	;_4 = list node look ahead

	(lh-get-head _1 _2 _4)
	(loop-start _5)
		(vp-cpy-rr _4 _3)
		(ln-get-succ _4 0 _4)
		(breakif (list _4 '= 0)))

(defun loop-list-backward (_1 _2 _3 _4 &optional _5)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = list node
	;_4 = list node look ahead
	;_5 = loop label
	;outputs
	;_1 = list head
	;_3 = list node
	;_4 = list node look ahead

	(lh-get-tail _1 _2 _4)
	(loop-start _5)
		(vp-cpy-rr _4 _3)
		(ln-get-pred _4 0 _4)
		(breakif (list _4 '= 0)))

(defun loop-flist (_1 _2 _3 _4 &optional _5)
	;inputs
	;_1 = list head
	;_2 = offset
	;_3 = list node
	;_4 = list last
	;_5 = loop label
	;outputs
	;_1 = list head
	;_3 = list node
	;_4 = list last

	(vp-lea-i _1 (+ _2 ln_fnode_next) _3)
	(loop-start _5)
		(ln-next-fnode _3 _4))

(defun sys/list/init ()
	;inputs
	;:r0 = list header (ptr)
	(lh-init :r0 :r1))
