/* Invoke interrupt handler.
   eax = interrupt vector */
invoke_handler:
  pushl %esp  /* arg 2 = pointer to pusha struct */
  pushl %eax  /* arg 1 = interrupt vector */
  movl interrupt_handlers(,%eax,4),%eax
  call *%eax
  addl $8,%esp  /* pop args */
  popa
  addl $4,%esp  /* pop error code */
  iret

#define EXC_HANDLER(n)                           \
isr##n:                                         ;\
  pusha                                         ;\
  movl $n,%eax                                  ;\
  movl $invoke_handler,%edx                     ;\
  jmp *%edx

#define INT_HANDLER(n)                           \
isr##n:                                         ;\
  pushl %eax  /* dummy error code */            ;\
  pusha                                         ;\
  movl $n,%eax                                  ;\
  movl $invoke_handler,%edx                     ;\
  jmp *%edx

EXC_HANDLER(0)
EXC_HANDLER(1)
EXC_HANDLER(2)
EXC_HANDLER(3)
EXC_HANDLER(4)
EXC_HANDLER(5)
EXC_HANDLER(6)
EXC_HANDLER(7)
EXC_HANDLER(8)
EXC_HANDLER(9)
EXC_HANDLER(10)
EXC_HANDLER(11)
EXC_HANDLER(12)
EXC_HANDLER(13)
EXC_HANDLER(14)
EXC_HANDLER(15)
EXC_HANDLER(16)
EXC_HANDLER(17)
EXC_HANDLER(18)
EXC_HANDLER(19)
INT_HANDLER(20)
INT_HANDLER(21)
INT_HANDLER(22)
INT_HANDLER(23)
INT_HANDLER(24)
INT_HANDLER(25)
INT_HANDLER(26)
INT_HANDLER(27)
INT_HANDLER(28)
INT_HANDLER(29)
INT_HANDLER(30)
INT_HANDLER(31)
INT_HANDLER(32)
INT_HANDLER(33)
INT_HANDLER(34)
INT_HANDLER(35)
INT_HANDLER(36)
INT_HANDLER(37)
INT_HANDLER(38)
INT_HANDLER(39)
INT_HANDLER(40)
INT_HANDLER(41)
INT_HANDLER(42)
INT_HANDLER(43)
INT_HANDLER(44)
INT_HANDLER(45)
INT_HANDLER(46)
INT_HANDLER(47)
INT_HANDLER(48)
INT_HANDLER(49)
INT_HANDLER(50)
INT_HANDLER(51)
INT_HANDLER(52)
INT_HANDLER(53)
INT_HANDLER(54)
INT_HANDLER(55)
INT_HANDLER(56)
INT_HANDLER(57)
INT_HANDLER(58)
INT_HANDLER(59)
INT_HANDLER(60)
INT_HANDLER(61)
INT_HANDLER(62)
INT_HANDLER(63)
INT_HANDLER(64)
INT_HANDLER(65)
INT_HANDLER(66)
INT_HANDLER(67)
INT_HANDLER(68)
INT_HANDLER(69)
INT_HANDLER(70)
INT_HANDLER(71)
INT_HANDLER(72)
INT_HANDLER(73)
INT_HANDLER(74)
INT_HANDLER(75)
INT_HANDLER(76)
INT_HANDLER(77)
INT_HANDLER(78)
INT_HANDLER(79)
INT_HANDLER(80)
INT_HANDLER(81)
INT_HANDLER(82)
INT_HANDLER(83)
INT_HANDLER(84)
INT_HANDLER(85)
INT_HANDLER(86)
INT_HANDLER(87)
INT_HANDLER(88)
INT_HANDLER(89)
INT_HANDLER(90)
INT_HANDLER(91)
INT_HANDLER(92)
INT_HANDLER(93)
INT_HANDLER(94)
INT_HANDLER(95)
INT_HANDLER(96)
INT_HANDLER(97)
INT_HANDLER(98)
INT_HANDLER(99)
INT_HANDLER(100)
INT_HANDLER(101)
INT_HANDLER(102)
INT_HANDLER(103)
INT_HANDLER(104)
INT_HANDLER(105)
INT_HANDLER(106)
INT_HANDLER(107)
INT_HANDLER(108)
INT_HANDLER(109)
INT_HANDLER(110)
INT_HANDLER(111)
INT_HANDLER(112)
INT_HANDLER(113)
INT_HANDLER(114)
INT_HANDLER(115)
INT_HANDLER(116)
INT_HANDLER(117)
INT_HANDLER(118)
INT_HANDLER(119)
INT_HANDLER(120)
INT_HANDLER(121)
INT_HANDLER(122)
INT_HANDLER(123)
INT_HANDLER(124)
INT_HANDLER(125)
INT_HANDLER(126)
INT_HANDLER(127)
INT_HANDLER(128)
INT_HANDLER(129)
INT_HANDLER(130)
INT_HANDLER(131)
INT_HANDLER(132)
INT_HANDLER(133)
INT_HANDLER(134)
INT_HANDLER(135)
INT_HANDLER(136)
INT_HANDLER(137)
INT_HANDLER(138)
INT_HANDLER(139)
INT_HANDLER(140)
INT_HANDLER(141)
INT_HANDLER(142)
INT_HANDLER(143)
INT_HANDLER(144)
INT_HANDLER(145)
INT_HANDLER(146)
INT_HANDLER(147)
INT_HANDLER(148)
INT_HANDLER(149)
INT_HANDLER(150)
INT_HANDLER(151)
INT_HANDLER(152)
INT_HANDLER(153)
INT_HANDLER(154)
INT_HANDLER(155)
INT_HANDLER(156)
INT_HANDLER(157)
INT_HANDLER(158)
INT_HANDLER(159)
INT_HANDLER(160)
INT_HANDLER(161)
INT_HANDLER(162)
INT_HANDLER(163)
INT_HANDLER(164)
INT_HANDLER(165)
INT_HANDLER(166)
INT_HANDLER(167)
INT_HANDLER(168)
INT_HANDLER(169)
INT_HANDLER(170)
INT_HANDLER(171)
INT_HANDLER(172)
INT_HANDLER(173)
INT_HANDLER(174)
INT_HANDLER(175)
INT_HANDLER(176)
INT_HANDLER(177)
INT_HANDLER(178)
INT_HANDLER(179)
INT_HANDLER(180)
INT_HANDLER(181)
INT_HANDLER(182)
INT_HANDLER(183)
INT_HANDLER(184)
INT_HANDLER(185)
INT_HANDLER(186)
INT_HANDLER(187)
INT_HANDLER(188)
INT_HANDLER(189)
INT_HANDLER(190)
INT_HANDLER(191)
INT_HANDLER(192)
INT_HANDLER(193)
INT_HANDLER(194)
INT_HANDLER(195)
INT_HANDLER(196)
INT_HANDLER(197)
INT_HANDLER(198)
INT_HANDLER(199)
INT_HANDLER(200)
INT_HANDLER(201)
INT_HANDLER(202)
INT_HANDLER(203)
INT_HANDLER(204)
INT_HANDLER(205)
INT_HANDLER(206)
INT_HANDLER(207)
INT_HANDLER(208)
INT_HANDLER(209)
INT_HANDLER(210)
INT_HANDLER(211)
INT_HANDLER(212)
INT_HANDLER(213)
INT_HANDLER(214)
INT_HANDLER(215)
INT_HANDLER(216)
INT_HANDLER(217)
INT_HANDLER(218)
INT_HANDLER(219)
INT_HANDLER(220)
INT_HANDLER(221)
INT_HANDLER(222)
INT_HANDLER(223)
INT_HANDLER(224)
INT_HANDLER(225)
INT_HANDLER(226)
INT_HANDLER(227)
INT_HANDLER(228)
INT_HANDLER(229)
INT_HANDLER(230)
INT_HANDLER(231)
INT_HANDLER(232)
INT_HANDLER(233)
INT_HANDLER(234)
INT_HANDLER(235)
INT_HANDLER(236)
INT_HANDLER(237)
INT_HANDLER(238)
INT_HANDLER(239)
INT_HANDLER(240)
INT_HANDLER(241)
INT_HANDLER(242)
INT_HANDLER(243)
INT_HANDLER(244)
INT_HANDLER(245)
INT_HANDLER(246)
INT_HANDLER(247)
INT_HANDLER(248)
INT_HANDLER(249)
INT_HANDLER(250)
INT_HANDLER(251)
INT_HANDLER(252)
INT_HANDLER(253)
INT_HANDLER(254)
INT_HANDLER(255)

/*****************************************************************/

/* Interrupt handler table.
   At start-up, this contains the addresses of all the isr
   functions. These are then replaced by interrupt handler
   functions. */

.data
.global interrupt_handlers
interrupt_handlers:
  .int isr0
  .int isr1
  .int isr2
  .int isr3
  .int isr4
  .int isr5
  .int isr6
  .int isr7
  .int isr8
  .int isr9
  .int isr10
  .int isr11
  .int isr12
  .int isr13
  .int isr14
  .int isr15
  .int isr16
  .int isr17
  .int isr18
  .int isr19
  .int isr20
  .int isr21
  .int isr22
  .int isr23
  .int isr24
  .int isr25
  .int isr26
  .int isr27
  .int isr28
  .int isr29
  .int isr30
  .int isr31
  .int isr32
  .int isr33
  .int isr34
  .int isr35
  .int isr36
  .int isr37
  .int isr38
  .int isr39
  .int isr40
  .int isr41
  .int isr42
  .int isr43
  .int isr44
  .int isr45
  .int isr46
  .int isr47
  .int isr48
  .int isr49
  .int isr50
  .int isr51
  .int isr52
  .int isr53
  .int isr54
  .int isr55
  .int isr56
  .int isr57
  .int isr58
  .int isr59
  .int isr60
  .int isr61
  .int isr62
  .int isr63
  .int isr64
  .int isr65
  .int isr66
  .int isr67
  .int isr68
  .int isr69
  .int isr70
  .int isr71
  .int isr72
  .int isr73
  .int isr74
  .int isr75
  .int isr76
  .int isr77
  .int isr78
  .int isr79
  .int isr80
  .int isr81
  .int isr82
  .int isr83
  .int isr84
  .int isr85
  .int isr86
  .int isr87
  .int isr88
  .int isr89
  .int isr90
  .int isr91
  .int isr92
  .int isr93
  .int isr94
  .int isr95
  .int isr96
  .int isr97
  .int isr98
  .int isr99
  .int isr100
  .int isr101
  .int isr102
  .int isr103
  .int isr104
  .int isr105
  .int isr106
  .int isr107
  .int isr108
  .int isr109
  .int isr110
  .int isr111
  .int isr112
  .int isr113
  .int isr114
  .int isr115
  .int isr116
  .int isr117
  .int isr118
  .int isr119
  .int isr120
  .int isr121
  .int isr122
  .int isr123
  .int isr124
  .int isr125
  .int isr126
  .int isr127
  .int isr128
  .int isr129
  .int isr130
  .int isr131
  .int isr132
  .int isr133
  .int isr134
  .int isr135
  .int isr136
  .int isr137
  .int isr138
  .int isr139
  .int isr140
  .int isr141
  .int isr142
  .int isr143
  .int isr144
  .int isr145
  .int isr146
  .int isr147
  .int isr148
  .int isr149
  .int isr150
  .int isr151
  .int isr152
  .int isr153
  .int isr154
  .int isr155
  .int isr156
  .int isr157
  .int isr158
  .int isr159
  .int isr160
  .int isr161
  .int isr162
  .int isr163
  .int isr164
  .int isr165
  .int isr166
  .int isr167
  .int isr168
  .int isr169
  .int isr170
  .int isr171
  .int isr172
  .int isr173
  .int isr174
  .int isr175
  .int isr176
  .int isr177
  .int isr178
  .int isr179
  .int isr180
  .int isr181
  .int isr182
  .int isr183
  .int isr184
  .int isr185
  .int isr186
  .int isr187
  .int isr188
  .int isr189
  .int isr190
  .int isr191
  .int isr192
  .int isr193
  .int isr194
  .int isr195
  .int isr196
  .int isr197
  .int isr198
  .int isr199
  .int isr200
  .int isr201
  .int isr202
  .int isr203
  .int isr204
  .int isr205
  .int isr206
  .int isr207
  .int isr208
  .int isr209
  .int isr210
  .int isr211
  .int isr212
  .int isr213
  .int isr214
  .int isr215
  .int isr216
  .int isr217
  .int isr218
  .int isr219
  .int isr220
  .int isr221
  .int isr222
  .int isr223
  .int isr224
  .int isr225
  .int isr226
  .int isr227
  .int isr228
  .int isr229
  .int isr230
  .int isr231
  .int isr232
  .int isr233
  .int isr234
  .int isr235
  .int isr236
  .int isr237
  .int isr238
  .int isr239
  .int isr240
  .int isr241
  .int isr242
  .int isr243
  .int isr244
  .int isr245
  .int isr246
  .int isr247
  .int isr248
  .int isr249
  .int isr250
  .int isr251
  .int isr252
  .int isr253
  .int isr254
  .int isr255
