CLASS zbp_jv_post_rview DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zjv_post_rview.
PUBLIC SECTION.
    CLASS-DATA:  GT_HDR TYPE TABLE OF zdt_jv_post,
                 GT_UPHDR TYPE TABLE OF zdt_jv_post,

                 GT_ITEM TYPE TABLE OF zdt_jv_post1,
                 GT_UPITEM TYPE TABLE OF zdt_jv_post1,

                 get_item TYPE table of zdt_jv_post1.

ENDCLASS.



CLASS ZBP_JV_POST_RVIEW IMPLEMENTATION.
ENDCLASS.
