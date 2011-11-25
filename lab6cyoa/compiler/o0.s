__c0_term():
  .term_0
  %t2#0:w = _readchar()
  %t1#0:w = %t2#0:w
  %t3#0:w = 0:w
  if ((%t1#0:w != 48:w)) goto .term_2
  .term_1
  %t5#1:w = _readchar()
  %t4#1:w = %t5#1:w
  if ((%t4#1:w == 120:w)) goto .term_4
  .term_3
  %t7#2:w = (1:w / 0:w)
  %t6#2:q = %t7#2:w
  .term_37
  %t7#1:w = %t7#2:w
  %t6#1:q = %t6#2:q
  goto .term_5
  .term_4
  .term_36
  .term_5
  %t8#1:w = _readhex()
  %t3#4:w = %t8#1:w
  .term_41
  %t8#0:w = %t8#1:w
  %t7#0:w = %t7#1:w
  %t6#0:q = %t6#1:q
  %t5#0:w = %t5#1:w
  %t4#0:w = %t4#1:w
  %t3#2:w = %t3#4:w
  goto .term_9
  .term_2
  if ((%t1#0:w != 40:w)) goto .term_7
  .term_6
  %t9#2:w = __c0_term()
  %t3#3:w = %t9#2:w
  .term_39
  %t9#0:w = %t9#2:w
  %t3#1:w = %t3#3:w
  goto .term_8
  .term_7
  %t11#0:w = (1:w / 0:w)
  %t10#0:q = %t11#0:w
  .term_38
  %t11#1:w = %t11#0:w
  %t10#1:q = %t10#0:q
  %t3#1:w = %t3#0:w
  .term_8
  .term_40
  %t11#2:w = %t11#1:w
  %t10#2:q = %t10#1:q
  %t9#1:w = %t9#0:w
  %t3#2:w = %t3#1:w
  .term_9
  %t13#0:w = _readchar()
  %t12#0:w = %t13#0:w
  %t14#0:w = 0:w
  %t15#0:w = _readchar()
  %t1#1:w = %t15#0:w
  if ((%t1#1:w != 48:w)) goto .term_11
  .term_10
  %t17#1:w = _readchar()
  %t16#1:w = %t17#1:w
  if ((%t16#1:w == 120:w)) goto .term_13
  .term_12
  %t19#2:w = (1:w / 0:w)
  %t18#2:q = %t19#2:w
  .term_43
  %t19#1:w = %t19#2:w
  %t18#1:q = %t18#2:q
  goto .term_14
  .term_13
  .term_42
  .term_14
  %t20#1:w = _readhex()
  %t14#4:w = %t20#1:w
  .term_47
  %t20#0:w = %t20#1:w
  %t19#0:w = %t19#1:w
  %t18#0:q = %t18#1:q
  %t17#0:w = %t17#1:w
  %t16#0:w = %t16#1:w
  %t14#2:w = %t14#4:w
  goto .term_18
  .term_11
  if ((%t1#1:w != 40:w)) goto .term_16
  .term_15
  %t21#2:w = __c0_term()
  %t14#3:w = %t21#2:w
  .term_45
  %t21#0:w = %t21#2:w
  %t14#1:w = %t14#3:w
  goto .term_17
  .term_16
  %t23#0:w = (1:w / 0:w)
  %t22#0:q = %t23#0:w
  .term_44
  %t23#1:w = %t23#0:w
  %t22#1:q = %t22#0:q
  %t14#1:w = %t14#0:w
  .term_17
  .term_46
  %t23#2:w = %t23#1:w
  %t22#2:q = %t22#1:q
  %t21#1:w = %t21#0:w
  %t14#2:w = %t14#1:w
  .term_18
  %t24#0:w = 0:w
  if ((%t12#0:w != 43:w)) goto .term_20
  .term_19
  %t24#7:w = (%t3#2:w + %t14#2:w)
  .term_53
  %t24#4:w = %t24#7:w
  goto .term_31
  .term_20
  if ((%t12#0:w != 45:w)) goto .term_22
  .term_21
  %t24#6:w = (%t3#2:w - %t14#2:w)
  .term_51
  %t24#3:w = %t24#6:w
  goto .term_30
  .term_22
  if ((%t12#0:w != 42:w)) goto .term_24
  .term_23
  %t24#5:w = (%t3#2:w * %t14#2:w)
  .term_49
  %t24#2:w = %t24#5:w
  goto .term_29
  .term_24
  if ((%t12#0:w != 47:w)) goto .term_26
  .term_25
  %t25#0:w = (%t3#2:w / %t14#2:w)
  %t24#1:w = %t25#0:w
  goto .term_28
  .term_26
  %t27#0:w = (1:w / 0:w)
  %t26#0:q = %t27#0:w
  return 0:w
  .term_28
  .term_48
  %t25#1:w = %t25#0:w
  %t24#2:w = %t24#1:w
  .term_29
  .term_50
  %t25#2:w = %t25#1:w
  %t24#3:w = %t24#2:w
  .term_30
  .term_52
  %t25#3:w = %t25#2:w
  %t24#4:w = %t24#3:w
  .term_31
  %t29#0:w = _readchar()
  %t28#0:w = %t29#0:w
  if ((%t28#0:w == 41:w)) goto .term_33
  .term_32
  %t31#1:w = (1:w / 0:w)
  %t30#1:q = %t31#1:w
  .term_55
  %t31#0:w = %t31#1:w
  %t30#0:q = %t30#1:q
  goto .term_34
  .term_33
  .term_54
  .term_34
  return %t24#4:w
  goto .term_34
  goto .term_29
  goto .term_30
  goto .term_31
  goto .term_17
  goto .term_18
  goto .term_14
  goto .term_8
  goto .term_9
  goto .term_5

__c0_main():
  .main_0
  %t33#0:w = _readint()
  %t32#0:w = %t33#0:w
  %t34#0:w = 0:w
  .main_9
  %t34#1:w = %t34#0:w
  .main_1
  if ((%t34#1:w >= %t32#0:w)) goto .main_3
  .main_2
  %t36#1:w = _readchar()
  %t35#1:w = %t36#1:w
  if ((%t35#1:w == 40:w)) goto .main_5
  .main_4
  %t38#2:w = (1:w / 0:w)
  %t37#2:q = %t38#2:w
  .main_11
  %t38#1:w = %t38#2:w
  %t37#1:q = %t37#2:q
  goto .main_6
  .main_5
  .main_10
  %t38#1:w = %t38#0:w
  %t37#1:q = %t37#0:q
  .main_6
  %t40#1:w = __c0_term()
  %t41#1:w = _printint(%t40#1:w)
  %t39#1:q = %t41#1:w
  %t43#1:w = _printchar(10:w)
  %t42#1:q = %t43#1:w
  %t45#1:w = _readchar()
  %t44#1:q = %t45#1:w
  %t34#2:w = (%t34#1:w + 1:w)
  .main_8
  %t45#0:w = %t45#1:w
  %t44#0:q = %t44#1:q
  %t43#0:w = %t43#1:w
  %t42#0:q = %t42#1:q
  %t41#0:w = %t41#1:w
  %t40#0:w = %t40#1:w
  %t39#0:q = %t39#1:q
  %t38#0:w = %t38#1:w
  %t37#0:q = %t37#1:q
  %t36#0:w = %t36#1:w
  %t35#0:w = %t35#1:w
  %t34#1:w = %t34#2:w
  goto .main_1
  .main_3
  return 0:w
  goto .main_6


