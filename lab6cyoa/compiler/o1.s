__c0_term():
  .term_0
  %t2#0:w = _readchar()
  %t3#0:w = 0:w
  if ((48:w != %t2#0:w)) goto .term_2
  .term_1
  %t5#1:w = _readchar()
  if ((120:w == %t5#1:w)) goto .term_4
  .term_3
  %t7#2:w = (1:w / 0:w)
  goto .term_5
  .term_4
  .term_5
  %t8#1:w = _readhex()
  %t3#4:w = %t8#1:w
  .term_39
  %t3#2:w = %t3#4:w
  goto .term_9
  .term_2
  if ((40:w != %t2#0:w)) goto .term_7
  .term_6
  %t9#2:w = __c0_term()
  %t3#3:w = %t9#2:w
  .term_37
  %t3#1:w = %t3#3:w
  goto .term_8
  .term_7
  %t11#0:w = (1:w / 0:w)
  .term_36
  %t3#1:w = %t3#0:w
  .term_8
  .term_38
  %t3#2:w = %t3#1:w
  .term_9
  %t13#0:w = _readchar()
  %t14#0:w = 0:w
  %t15#0:w = _readchar()
  if ((48:w != %t15#0:w)) goto .term_11
  .term_10
  %t17#1:w = _readchar()
  if ((120:w == %t17#1:w)) goto .term_13
  .term_12
  goto .term_14
  .term_13
  .term_14
  %t20#1:w = _readhex()
  %t14#4:w = %t20#1:w
  .term_43
  %t14#2:w = %t14#4:w
  goto .term_18
  .term_11
  if ((40:w != %t15#0:w)) goto .term_16
  .term_15
  %t21#2:w = __c0_term()
  %t14#3:w = %t21#2:w
  .term_41
  %t14#1:w = %t14#3:w
  goto .term_17
  .term_16
  .term_40
  %t14#1:w = %t14#0:w
  .term_17
  .term_42
  %t14#2:w = %t14#1:w
  .term_18
  if ((43:w != %t13#0:w)) goto .term_20
  .term_19
  %t24#7:w = (%t3#2:w + %t14#2:w)
  .term_49
  %t24#4:w = %t24#7:w
  goto .term_31
  .term_20
  if ((45:w != %t13#0:w)) goto .term_22
  .term_21
  %t24#6:w = (%t3#2:w - %t14#2:w)
  .term_47
  %t24#3:w = %t24#6:w
  goto .term_30
  .term_22
  if ((42:w != %t13#0:w)) goto .term_24
  .term_23
  %t24#5:w = (%t3#2:w * %t14#2:w)
  .term_45
  %t24#2:w = %t24#5:w
  goto .term_29
  .term_24
  if ((47:w != %t13#0:w)) goto .term_26
  .term_25
  %t25#0:w = (%t3#2:w / %t14#2:w)
  %t24#1:w = %t25#0:w
  goto .term_28
  .term_26
  return 0:w
  .term_28
  .term_44
  %t24#2:w = %t24#1:w
  .term_29
  .term_46
  %t24#3:w = %t24#2:w
  .term_30
  .term_48
  %t24#4:w = %t24#3:w
  .term_31
  %t29#0:w = _readchar()
  if ((41:w == %t29#0:w)) goto .term_33
  .term_32
  goto .term_34
  .term_33
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
  %t34#0:w = 0:w
  .main_9
  %t34#1:w = %t34#0:w
  .main_1
  if ((%t34#1:w >= %t33#0:w)) goto .main_3
  .main_2
  %t36#1:w = _readchar()
  if ((40:w == %t36#1:w)) goto .main_5
  .main_4
  %t38#2:w = (1:w / 0:w)
  .main_11
  goto .main_6
  .main_5
  .main_10
  .main_6
  %t40#1:w = __c0_term()
  %t41#1:w = _printint(%t40#1:w)
  %t43#1:w = _printchar(10:w)
  %t45#1:w = _readchar()
  %t34#2:w = (1:w + %t34#1:w)
  .main_8
  %t34#1:w = %t34#2:w
  goto .main_1
  .main_3
  return 0:w
  goto .main_6


