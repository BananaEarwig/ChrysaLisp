(include "lib/asm/class.inc")

(def-class region :nil
	(dec-method :translate gui/region/translate :static (:r1 :r7 :r8))
	(dec-method :bounds gui/region/bounds :static (:r1) (:r7 :r8 :r9 :r10))
	(dec-method :clip_rect gui/region/clip_rect :static (:r0 :r1 :r7 :r8 :r9 :r10) (:r0))
	(dec-method :remove_rect gui/region/remove_rect :static (:r0 :r1 :r7 :r8 :r9 :r10) (:r0))
	(dec-method :cut_rect gui/region/cut_rect :static (:r0 :r1 :r2 :r7 :r8 :r9 :r10) (:r0))
	(dec-method :copy_rect gui/region/copy_rect :static (:r0 :r1 :r2 :r7 :r8 :r9 :r10) (:r0))
	(dec-method :paste_rect gui/region/paste_rect :static (:r0 :r1 :r7 :r8 :r9 :r10) (:r0))
	(dec-method :free gui/region/free :static (:r0 :r1) (:r0 :r1))
	(dec-method :copy_region gui/region/copy_region :static (:r0 :r1 :r2 :r3 :r7 :r8) (:r0))
	(dec-method :paste_region gui/region/paste_region :static (:r0 :r1 :r2 :r7 :r8) (:r0))
	(dec-method :remove_region gui/region/remove_region :static (:r0 :r1 :r2 :r7 :r8) (:r0)))

(def-struct rect ln_fnode_size
	(int x y x1 y1))
