Received: from eggs.gnu.org ([2001:4830:134:3::10]:60626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQn-0007zu-Uj
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQm-0003Ho-JX
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQm-0003HD-9m
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:56 -0500
Date: Mon, 5 Nov 2018 13:16:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-25-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 24/33] bios-tables-test: prepare expected files
 for mmio64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

test will be added by follow-up patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/q35/DSDT.mmio64 | Bin 0 -> 8947 bytes
 tests/data/acpi/q35/SRAT.mmio64 | Bin 0 -> 224 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/q35/DSDT.mmio64
 create mode 100644 tests/data/acpi/q35/SRAT.mmio64

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
new file mode 100644
index 0000000000000000000000000000000000000000..a058ff2ee31a22a55b5b198bc1531c7f20b243f6
GIT binary patch
literal 8947
zcmb7KTW=f38J*=#t05&VrL`<y5)n$!v}rDs<vK;%1SWSWk`Y&;NIG#q16;dtD<v(m
zP@E!Z5I|OdT>MZVWfQbOALxMpqxlJWYk&d;`r6l^h@YaKZ)QiHSyDi(2XemIbG~oR
z?ChN7uKcdw`*w{n>)+KKuhA`4ueUuPeHLSk+Vt%-GdEcO(6819Rz8)n`gil9jgPAB
zKI2!f)vdqog<pi>osUE7X2foN>3n|cX7u4F;Vnj>cWy<TQ^VQfgKl-uKk|6nYnJUn
zqv;naUvt|Yc(RqY2Nl1=?7_9BZ@I0R!A{r9+<TLG{;TVw?d))`xWt`)@UM;URxe)t
z;?+BquU`D;Z|=RxGXPw|w~g<Oh(5yiL%tf0oIelutq+JUj;)WD{yY?iWuHSwqL6y-
z7i1TuS|7jZ1hyP&&2F@7JvCMfBgEJ+AB}b|U<Jm${yxt#{ksmuORv<n{ZhN*4@&Np
zLAO_75%q)-b=~}9$enOh_-q)mVVFNY9<$N>XTzK9FE<P9KmW^)*_bb2COX|>k<WiL
zi>XI)mSOBY=3Je5j)p_ihUv>SyOn{MDhyy1gK0NAyD1*>LjSOZGnnFsJk`H@j@r!I
z2`Xu3;j4<TR=ek?1ge(eM}#^9RE>F++P39Y@zHAI!?}9)`LwD?)%r)zc6uI)%5#>-
zIiiuS@H2HQVi9vvYs{)!2kd~Qa__PJ(F<Eu{{)^+yR%|GP9zFq$U<g;^*VbU-)ku-
z?H@fA>|8q`E-WR9HqWjxhk!3Z%Ly>U+!Z<FH2!du!z_>4{me;0htJimchm2tZF}ud
z6slz~C+kX4){0kMoQ5Xkv@{RW57NwDb3~d=N^>cZhNskUXiiVflX{Rs9vgY=cGKHr
zZef6LE83&T`O|9_odU=Euee;=onCu!>+QqEd<LtBwYIlvOtvkwH`!u=`gsaLT?J_b
z4YoL!DI6c;VwSi#A{K!2@|fTOszPESzrdyh6WBN+rh=xJU;-+b2#JZ&2y9v~)d*<)
ziL3&emP|lZNK91)>t13-o{V5BXht&C;1TLNvxd&BU@B-<GS%P_>N<0V&YWN>XwKA$
zP}ezQ=$tWh&X_t8>N;&hr)}u8O`QmJo!B9?nVvOt&YC(A>N>fhlN&m@sS}~DGjHh3
z8#?o*PK3Hn>{QzMEEqZqrcQ*q&N)NpoS}2h)QM2nIdABkH+0UMIuYtR7Yv;XhRy|3
zCqiAPW9W1YosOv!p{}!N=qwsKi>6M5y3R#I=c1u=(bS1h*STcqTrzYnnK}{bI$cAj
zYv^=Mod|WEXAGTZ44r38od|WE%ZAQnL+7%o6QQp2tfBL)q4TV%6QQni#n8E8=v*;%
zBGh%B6U<7y6P^>yYP{K<lT7bnNK8M*o;R514d!{1iBM-=Fqjt%<^_|9P-k8=m=_J^
zMU#n8XFg^yA2XPbnM{N_^KrpcF7voxsy+U3$y6IRLSiZ>Sv6{|8Z}qVnh0f08wOg@
z47A>Do){?FC>$Fo0+f|O8i6Vb1C=;oNfz#R1W-9<N<vjgOeGBlDzVByH7FUVgbF4Z
zC_;=z8K}g@5!F;)O9m>TCkBcTLl;;WsKmw*G1cUffl8=gl7S*rI$@v^E0{1)4N3+o
zp@K;Uicsl<fl91k!ay}B8K{H`CK)I~r4t4!v4RN$)u3dc5-ONvpa_*t7^uVwCJa=A
zl7UL7V3L6%R61dx5-XT6Pz_23Dxrc&28vMWgn>$|V8TE(C>f}P3MLsSLZuT1DzSnI
z1J$5ppb{#WWS|I@P8g`f3MLFxgOY(ts9=(TB2+qIpb{&XFi;Ij1}dR~Nd}5g>4bqw
ztYE@GH7FUVgbF4ZC_<$Z1}d?F2?N!jWS|l%m}H;`l};F_#0n-1RD+U%N~mCxfg)5o
zVW1K#m@rTcN(L&Sf=LF7Q0at$N~~bQKs6{CsDuh887M-f69y`=f(ZlFpk$yDDwt%T
z2$fD4sKg2;3{-=Xfl8=gl7S*rI$@v^E0{1)4N3+op@K;Uicsl<fl91k!ay}B8K{H`
zCK)I~r4t4!v4RN$)u3dc5-ONvpa_*t7^uVwCJa=Al7UL7V3L6%R61dxh%^I5q#Gzg
z-9Qm)2C6Y(pc<15RAZ8XYD^fY#)N@tOfpc7Nd~GhVW1il2C6a1Ks6>AsK$hWYD^fY
z#v}vPm}H<D69$S%on06xBAhWXnPi{{aT-)eOf|PKP(*5OVW5cA+>(JJRC7xPiqL27
z`2j4HjS55YV|7eFNbl$9tJ1&wi|5nyE0vxV(9;O3-Px_cad)fq;n9b0GdvsFtx<cE
zKI-(*u-&ERZntNRX5Z(Bdw2*kJLY-!a&y<~%mUCU7w38Y(;S<nhf(;Ye2@Bg7N5=N
z{XM?GsD(jv@MNSlgL{OE`Ym3-;}m*WV`JFe;xb?Qbe_$o;cg83H^WYhZ0>@5E<r=U
zXew@T;5WPM18Va_(X&8LI@p*7B;vD!Zl`PA+l$9Q<*7feUQJZTV}&1Fy{c8Oit1I2
zPp@8er&q7`j{?%}C93n(Bb4{F@}4N~CCYoJl=tHDezH6sm;GS%zE<8B<^4o?|CI86
zT)vhppLvAxHLZM2l&>Yq*G?&4i_32&%V!^<{H9iZQ<UFKl;1q1{AOIfo-Chxgz|N*
zd|i~UC(74PDPNDvH<ION9-(|gE8h_18;SCbQ_43`K0{ksvb-b9tIY$q74(=*Jhe3Y
z+?=@N@kQ5loGy78^P-s!_Zk!FWZ%?u6W8UUnGQD~6X|5%)N~Wq*^-$KcO?_)WZ%?u
z6W5Jvro*kuL^|0wHQmH@aK=oB`<IDyvTtg-iFLhfro&CmL^|0wHQmHIJ!_`Joz6r$
z*=MG6sxQbl1RlTf@L74gQ|qdg$Z-L}f9AaQwNm4)JJIjn`EBXo_S<j0bMWiiZ?nGT
zwOd>9ik#!TZhceureGEDXdAu*L(G3uzytlePf$={C6AuVd(G{x<#mErEU)%**<u;b
z3w*nOcacD8uUl)Cfb=W95*{Ttx0`mvsIz}md*+6CgMhKf@y%7dcC%bwFVhI*+n20c
z^m?1GrAB<X$3F7P<?_DU$a$zf+kfK5^BMI%fHczBkB_6hWH*XMEF7I5CJ)f)Bfb#!
zpPD$*+8T#$kR?TrR>(@GLWZgN-NwAv^|tNPWLV*smHaTon~X4G$)uR!Q9UyuNSp~w
zR}zlNx1x!W0UcT4{jJQXF_}u7&*`andNLQ_$TeMPFzfAfdxg`4PCZ`}gN5Q~e~PY%
zr;@z{eIwb4DVRFC{)aEos=@_^KP*tJEPG7r3u`c_^on_IGyI&V8$EX(@BVsu62tcP
z-@qk$Jz(wyEaG~*HmH>^;WUXCRJ5S!++yF(YS&@VXv<A<uD#tZSISpVg098j_V3?1
zc(1fKaXCt75Z57Y4>?<*>#)%dIu?G1^OgQl<3)J|A+y}g6Pf*H5R_iO{fB+Jxb48-
z?%-AFbK2C<kSJj~=u}%Jd^GUUqE-v7_Vq!jfA^Uw_zJtqgIafB1+?S>S}Z~B<pHuk
zIR%{#XcGu_YOmm<>y_Lkaf3UW9nz5SP7HU~eJf~rTg<KG0?ZtHcns^m{{$U7KK}Ao
zpNGVVLP|JV8p`TerMOJQQ0^~}+@Tx}_0meE=pdxENlC_*`)oivnU*&C+a41M^FyIY
zZV3V%x|NjxH@nya<Pa3r4mwvZ7dLqM-cK1T;FXg3_x-W_Q@wF`jGqcb<ntJLOEwqL
zY{=%1S~b=CG@5bma!|P*W6z`6i0CvCi5e|Rghs1D1ZuP>$pLj!gSZrk!^9rBpHm+l
zKcLtWokh`U-8t!@R*R0cM*hr@y0Lyb8<&c!{Nl&3o`;f2D#;{?Lf*zD&XIlqO=!-8
z8#k9Rpg}~H>2O5J>0m_Tq(ku;BHBsw%4PRSti!-co`8r}r#h*j`(rGuUS<NcPm3;k
zgI1kP>8@d&mQxczv3w<@f3%Ye+GYGN09~Brcd<Dr_beQ$J3v|#bR0456=PacaZJ0y
zn8qyPMcOmcV;UaC*f(5fKt4I9fru`*7+|r+7Dtu$wM}J1Z7Ot))1~3KwB3ji#eRv6
z#HlaHok0E*0|r;T%K6_vnPVwDqocD!A9$_(pzxqz+32_A8T<~19~4gFIdLw()z2`;
znWf*Q^p|4di1^iu@T=qFe|#?vu&-X4yb$n&S*!~2Zvzr0KCzwRZU+A|kbw~SFBge@
zi~6<O68zgkufp@%c38@lau(jWJ3qOBlhfT8Eaoy6hK2U!!J?hvDURxhenv;As`JZ-
z6VyL?Zu3=7-V)C3)`Dv=fJ=l<RB^ISmTrEWo$L+q*1MjS|Lu_Pmdkj}PyZLvKYF@b
o{<#b=mlnf)YIohorbdlRs<A<h{?S5rJthL1Vs5VOZTHy!0aq7uc>n+a

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/SRAT.mmio64 b/tests/data/acpi/q35/SRAT.mmio64
new file mode 100644
index 0000000000000000000000000000000000000000..ac35f3dac4f47b86e41c7f35ee40bac14174b37e
GIT binary patch
literal 224
zcmWFzatwLEz`($0?d0$55v<@85#SsQ6k`O6f!H7#gyBE{mCvXFmw__4-~!0{5bA&i
cfWZfLm_qF8V6xb0gn4lH?0~6chB1IN0P8^t0RR91

literal 0
HcmV?d00001

-- 
MST
