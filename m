Received: from eggs.gnu.org ([2001:4830:134:3::10]:34047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpBK-0000F8-HR
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpBI-000629-7Z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:14 -0500
Received: from mail.kernel.org ([198.145.29.136]:48752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpBH-00061t-TS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:12 -0500
Date: Tue, 10 Jan 2017 07:41:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-42-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 41/41] acpi-test: update expected files
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

clean up warnings after latest hotplug changes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/pc/DSDT         | Bin 6008 -> 5098 bytes
 tests/acpi-test-data/pc/DSDT.bridge  | Bin 7867 -> 6957 bytes
 tests/acpi-test-data/pc/DSDT.cphp    | Bin 6471 -> 5561 bytes
 tests/acpi-test-data/pc/DSDT.ipmikcs | Bin 6080 -> 5170 bytes
 tests/acpi-test-data/pc/DSDT.memhp   | Bin 6613 -> 6463 bytes
 tests/acpi-test-data/q35/DSDT        | Bin 8770 -> 7860 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 8787 -> 7877 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 9233 -> 8323 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 8845 -> 7935 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9375 -> 9225 bytes
 10 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/pc/DSDT b/tests/acpi-test-data/pc/DSDT
index 8053d711058c0f9541d6d97690819f9de697751c..15c3135d65f168a91edfdc3471ea1d3f012a824f 100644
GIT binary patch
delta 44
zcmeyN_e!11CD<k8l`sPXW5q@;er_gzmdU?(eK#la)iScX7R1B{JH>CV68Ogk06tL;
AL;wH)

delta 961
zcmZWoO>fgc5Z!I6;I8`>YC<VgjQ~*uN^3P$P8@J!gHybzWrwQBk!%SC0s>`~wh}oY
z6D~--T0L+JD1QL;U!nd0P7O2uXd|$t)tmQb#xtJT-|K%inC|M$Pd5pn=fBv395%`u
zzPsbwwYutk)ymwob;&pD`kdXcRZXoD$$tqJZ-4Ce`lU|yNPIYcTk5qByT`rP?L(q0
z`EFAq!<mTd4Tp@#h{+!1R_z5*v^;lfjR{SVz`KXqc>MFpX#f$SBLeOk)^I7}^@dA%
z^VzF_3W~;$;!ugW!}k-G<$wmO7tp|4$1EeNl)2+J=|o=fy+h)Ja>NbSr-ChH-hrYm
z^P1z%WHo?q7&}Ycscsi4Og(u_$ZU@M^IVLRC!<qy+$Sd($mXG1D}mPmnhAVh85#Qs
zV9FM`c98n601QpRogEXS5LlQAfMsF?0t>VBkVb&PXv8uY=1@6B4)q?|G$so%NslfW
zL>6k+P`?%-O`zw>Rv}ztcfP?kTs4i&Vx!n(++bykG05*jR{-ZBIE6*1$QSr&lm%u-
zQDC7cr9;B7OIY1j?sNNq({u)J#@WCG(Ein^9`Zf6IXy9{cu?XU-!t~bdk||$PUS8)
zcGao>94XLg1&j53bX(>t$}QheE2OnKoozgBJFe(iNB&I1-F^#&MJ}~AbCWJoyxNiv
zyHl8B>^UV2-sL{=zL++5s7x4J_6BQc<Zy~5oGBa@A`1|-R`Ld`=%A6OEZ$7`X|V6{
gdPAwyTOHg;62NsRVViKcwUUy@J27>3K6{b>3uZ?dasU7T

diff --git a/tests/acpi-test-data/pc/DSDT.bridge b/tests/acpi-test-data/pc/DSDT.bridge
index 850e71a973e52cc5e546fdd2757f0e089fed7192..d38586c95bf31f0212279a2505efd8e2fd321ccc 100644
GIT binary patch
delta 44
zcmdmOyVi`$CD<iISDJx=@xVqder_gzmdU?(eK#la)iSbsJc)@9c8cFzCE&;h03sF*
AJpcdz

delta 961
zcmZWoO>fgc5Z!I6;I8`>YC<TKMt}f;LZhbS1QKo>aKMvBcBqOR$(B$cAW&9md&mKq
za6#%d>VaE8xpF`~_AkL-Ak6rqL|{v+H}B1iXFRjt%cl>8;TX-+tBmpcKg5z6)C>1K
zXWMI3YDM>xUI4RUD4tm}78><NQ7@L6;yp(T+V8u)e!kN^knav(=X>q_?qTm`d!K15
zp3~IXXl@8b-DYDp7OKm^syt(wo(88<pVB1r-Rq=HCf^<$`xp_}(g&w%jaG(Gt2-Q;
zk6-v)ax%VVN7@i<*o|0`LK>}}&wck6Wf^m=0JhWQQ+ef=4hs{iL#R3)mtraL_BA~R
z72BChYCzv0bXLGFZ)HlNcyyPs`4s!-`8|oAgpSQgpB+)4Sj1|r2%bl1M)0OpP1rjK
zV>S!=UhKPyFfb+9+a^U3uqYD(%cKYb7G>!XO@M;Q2xT<Pk#<ZR={>S}NM=HkADl6S
zEYhrzac)R7!=6i<nP6R9`FwG@X=;`lr6$7$OPfMqeh<4sxQM|q%wk2Jq)(G9DLaXh
z3MDBX5`~??@|Jc38hgOw8N8Y#1CvO5e@As2cAVzy)TF{e$v3c5-IZ@qtVB7rYfyb!
zocYg@BOO<;TuToxtFWqF@~XuWYi-OX8&BI#D|*sVKkxv4wMbY7rL~coc2UCBRy^FD
z%z_Y4I1~8h`po@kHo)d86C&ph*2zfG6!SDwJS;*MB5W=14%Wy)XOBd<nfTLi-^2CB
eQn|Y}xDX}4>yW25@o*}6Elqb~=H%zRzW4{km>6pS

diff --git a/tests/acpi-test-data/pc/DSDT.cphp b/tests/acpi-test-data/pc/DSDT.cphp
index 9f405cfd83d39a8e06bc08428e160a0192fc9704..2dd70bf9520406c36c3684714bb714e536a28d20 100644
GIT binary patch
delta 44
zcmX?Zv{ReQCD<iorzish<HwC$_js86Stg(4_uXtDP|L{fS`ZT->=eJ*Q|KQX07V@R
AcK`qY

delta 961
zcmZWo&2G~`5Z-O7;BJ0ss0nFB)rcZMRH0T<g$oDV#MCLCG_pfg<Vd!J0tJDxO4~yY
z$b<`0uTc-&0?G@Zo)8bfTkrrpM8k~Zln88T_09LqjAuNv-#301Mb)V`ca|CB?Qh~&
zGN>0Gc+R%hsMIv~qh0{BQB^#%R!ueP4Ncd|O!1zf1?_j8ZZCh>IhJovUgf*(qs~e9
zMf-@UOP<rz*>GV1)w<0_Y$Osc2dnawsd^loN_|F?%y-vG8;`#}I`c6iu%!=<VGWlC
zP^&u}nopklTyiqLWQXbiY}lW$B8D_tU7!2zUCJ`zY5{Dg$!GG)&xb5bm>7WJcwCCB
zQ*U3@b5OCJg=r1w8-&gZ*yXKENoc1Vj3s02pXXvcd8Tw^j(hBs0!13DwI=WyLURJ|
zSjLpSk1%4hpdUoOD+mKqg1v206akAeA+St}AYf6JF3|)in2b<H!yKw-#F5@5n}=j3
zB>C|rL&ze{8dk3ih-TPxshA1Y#LZ7PW}BvFsZnY&Y_L=m0`q&=6~Z(IM=*;Od6GU&
zvZU-JN-C73Xh;-x3CmmRZD<?-k7n?4JRO)s+WR}Id$8v;=VvAr4obd;J!4<KL9sH)
zsonx(SDX9Kks}>duvm)^ekWl?UG@yE#9Ev4(~YNXrxiVan0n8H-Cm1?MNnFsu~`=-
zTy4d}-N~ec*x^jzo9i+6gV_L^Czud9x4%Y4jHZ~Unc`s)vJhcwdAGkx4mx`*!p+2=
khWj3_H<rrX)&BKK0=y1+Y7-Bql2_w&C+5z7q%Y!s0P^-3qyPW_

diff --git a/tests/acpi-test-data/pc/DSDT.ipmikcs b/tests/acpi-test-data/pc/DSDT.ipmikcs
index 8ac48afb6a672a6d70e13539a17614b465d648d6..2796d96b0eec17fb68a79234cbccb70708ac2587 100644
GIT binary patch
delta 44
zcmX@0ze$73CD<jzNQ8lb@y|xCaBe1lmdQ?hzMEI_)iScX7R1B{JH>B4B=C<703gE+
A!~g&Q

delta 986
zcmZWo-)qxQ6ux&IwYzb1b+OjrSW(fT)W)?G1Ru<jxOC=rA*pkcLIP5pqV(Er4+SOG
z7h$hq5586DAE53Z*k87KPLgg#QwZPr&X1h0=bS%lrxm8Vdh7H$A@t*K_EHL)<%hnz
z;oDk6@xH2MZrXazHyirA-Lw@|sgs=l0xaJ7(Czh0d)))^{_sty*V*qL_Fi}PiM-^y
zEtL%CBCa<bG9n`;d6Zk)b0Vu*?rO~`pCEyE8-3&P&nL$LWQ2|gxNBI$rHD70F6FIf
zuL3G48b1m{IpPlANm!Nv8mwMG1MePI8Bw{+9k)fN>Wc4sBrYgL+;Dv=*p*3iAge{L
zIquw~2Z#;h;2d}AwS1K+M-K?OoFV@_XXE6V(5X4@lOs%I3(&2Vz^eew1m3lb340%4
z$`-h~o5n5!3{AnE4HL5vSXc>wWnu;b3#;^yMu5p^#BMOmp?r)S`g>^8n9Ro{Jve6&
zS?IHd`lSeI0-CGq`EZrp{07@_AsWS^P!t&ptgbT#^?gtUZ~>B2Sb&avfuBaV!0PA}
z*eJTvAz|7%tk>i_+}`Chok2LB3`_v+UyN#vZ@aD8sY%6y5^wpou_NArQ%h>fx45yT
z%={NfflfPEY-IgS+ep@0)$E3%z+TIbeM5N^eUfU+@(qAh(yq)-P65vVclYF%^qGcR
z{Wdxld9Gc_Oo!y+ozMBORQY+vHYs87EB1-^#k9FYCBj(I8?2&{!SR-G*zmFtS%5%u
v$s4R-fJ&aScxB<=ghPn;9yCyIWpFJi0C!SC{qS<NlAOh3nK`M=pJo37`)VG<

diff --git a/tests/acpi-test-data/pc/DSDT.memhp b/tests/acpi-test-data/pc/DSDT.memhp
index a1010c7fb5c526278d743891f2543d873f9ef9b9..53f6d5824359ff0ca20179b19b3b5cb79f017f82 100644
GIT binary patch
delta 529
zcmca=yx)k+CD<jzUXp=<v3ety2seLplP_zGK68AqQ+$B4r@>@BZo|ne0t)U;PQEdE
zAW>hB0B4SP4^J1~0KWhOM*}kkj`&a@&&AW%S0N>}EHgQ^n1RFB#V?49Il56VMxO;{
z7Eq_lWHkW=0UdNfcL6yS6*NJQ0N)^H-(XiC1z&&HFdz}^tgtzrdma-@bdx{Z<T?SV
zaQ=AbpkRh2zCaS>1QGuD;1EY3KPWf^$`6R}1@eI;m@gFX9~{EG1ZWgkJ|i<rL?GVP
z%Ybo-FOUQ&$pD*eB`8%-BeQ)242&S*Wl&*Y1PnT0K=L?V;AsFl9@#TCl=x=yQXwOG
w5out2xd*t$yBZiXKw}gXcfP^Seggh1llXi$r}Nb^vbz?<fFfw~b)kQ302&FCX#fBK

delta 717
zcmdmQbk&&4CD<k8sw4vg<LixFBHRK3e!6<`!A|i3&YlL*O^&*gb-4{UoAb<LVixdZ
zn_M8^D<vWs?`mMo5TnlmQ|Idu;NlzX?6-NZKrN$!<NO$qgn%DMj6O565)NM%zaTE=
z$#L8YOpWrBk8&&2%X$R(201b~aQV6h$20nR`UNxk2Kk0D`nr0>Ge$Rxf~1*!gI#?T
zeEnU+fJCsfLUfZCw{L)f0Y`kOrwgw^g@FMBN4$rp3y<Rko(2)Qc;}#Ch9&5(0}6ta
z1EqsQ9O2USAYX!A9~2w{l@EyUh0DXGfr4OZ#d!bV5M~V1fr23EjLa+%`FK|^14axL
yKtZqysN)SGj-MRDFHldCi{UP!nuC>zaPj2b{89t$PBHB6oGdS3wAoSU9~%JQMaRbg

diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index 58fbb3d2e2dc8e8256984744bfb9411feb2e35fe..d11567c3dc220894911166681ee7303fadfe04e8 100644
GIT binary patch
delta 42
ycmX@)vc;CmCD<ioiyQ+3<Bg46;<Ah)lNl9+H|r@FGP3)z#KZ?X#ZUgN=nen@r3=^q

delta 974
zcmZWoQE$>v6ux&Xv%5GPQW+X?WHV|sY;{bYTw-Y}MSEG(;xbc`HZjC$T)1J|15XuS
zO!nIB!8bJg0i(abA10pDmPr(n<~!ea&fy%+*Pna8bf&v{r?Ei@-TThg%3-^@<+}~v
z)>?}9Nv(3z)+OI;=__{IR#c@<B>xpeym#Cm3@b<dQ}N;KZDr6q>7NbW^iGIe@ZF9|
z#>)}c+YXtK3CntvTiQz^t4rL~+H;y9fwzg;bo%Y-MF16{BLeOk*0>PyR@<e#^Za!{
z1;yZNaV$sN;RgxJGC)H#2x#El$1W2pSGnVM=v-g%<%q-$vk^C3p9*$umL14yiEEC#
zJevV>!#G*uPJK6DW6Jp>Lat`WKcC;z<TInwa5^OCSjciPt(Cy*0L=v6vy2)05Mas{
zxq6u9-U1k!f;$Zps}NY&34mo{1p*7Z43I{E#Tdjg1m;-2Ko0c*#xy4LF-cD^8AKLp
z)>yw1Ax&WC+D<-PXSYAE%`c71;-a`@ykKpIG3f8ZRseHQoWdeZ<O}?1lm&K2QQ)8`
zrANZDOIY8P?{fQ))AR=6bapTSwEy>15BR>@S)996d?@jb?;8i=J&0P;Q{Ldl3uWQI
zL<)2|!RnUZw2j2os%Ezo1#B(f^bMs(3f=9+ng7xIXxJZ5%8zNN<+>=Wa;dwWnNN{o
zqf0(GDZj#4lM)8s(vWx`O`AJ3OBgG8qjd~2c+(1A7#<cP3lJ<?@kV7#P{}hE`xO2{
iaDQxe7@T_L(T$`5yc`u=8Xm4zk(cldS%{ABH2(l%iy4~$

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index c392802a95cb5690c6719b7909c9f8fa2213e503..412a6e910404dca9b5d6e6c2d027b9e10ccc2a84 100644
GIT binary patch
delta 42
ycmccYa@3Z~CD<k8s2l?WW5q@;aal%@$&3oZoAne78QJ|=W8#CI;wS%Bi~s=s-wVC~

delta 974
zcmZWo%Wl(95WTmlihDyJAtnuo(5N6lptPnbS%HLWn>yf|T6U;{9LbhYL_t)!O4~(N
zCTx(pwYp#zP<{aM4SWG>euXgOM~NVjtTX4#OlC62Kc4*5neOUscY_f6>l<6Egss}9
z@9z4x)>OQYYK@z=F8O9tU$R@aqACp{`7a^jy`%nMSUv2Yi1(*&s)OEf|8(%WcTD7>
z@3vJkUW~Zja>#^CSl*-D(q0f*UEr?Pn$ZLayj!SEr(YkR2T&0@BH*rJjf)X)wp_~F
z&t3&oPz=75#&X0Revq&%2Q);3fCk=O>@uNpjXQ3e&h!<Z4@ulGA92I=sbDKvb|9-|
zt~u^vHUs2_ak9jn#!jKml(PqfT+WeyKEJ2QC!^DFIwWUU$d+MRD}h%4nhCsP85w&Y
zV9J)b+DUV-0}M^Uom~^F5Lnm=fMsF@0t>qgkVb&T7{oFJ=2$*Q4)p=XG$so%Nlz{q
zL>6k+Sick@O<?Exb|GA6H$JV+E{)6LqPS$dV11i0=<mZ;0GFXSg(aBC7x>dC3+#@f
zz(G+;kA!6xu(2cG=5~kE^akNHJD334|9h%?eBW))&s-`#lz7YcjRWxxL@ntlZ*b$e
zGWTC11v;Hzb<^Lojl|WeW;YcDY%O2&4W&+s-L3h||LA=*?Dt2Nhcwhzx+tu2sk@b%
zO_5@wOFlTMu*BFNB@DjhA@M$#Hg{;AFjn?P>lozlrd7N!JS;>OAXv2OjVhR+lBX>8
lDg1@t{@Cm=IQ1%{t4RZRIjXocJY20RFW?(87aiT~`~iJg8i4=+

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index a0ce6b3264c69999c6e82a8ae7bab49338e4819b..79902d0d30f02d74594cb87b14460ea02764d460 100644
GIT binary patch
delta 57
zcmbQ}(d@|O66_MvtiZs)7`Tz^nVg77ynBEvN4$rp3$LSdfTw|hff>W*zlw&8?0zgU
N@xe~<lTRtT0|3Go59|N{

delta 944
zcmZ8g-)qxQ6ux&Yv%A&0+F0vwYtW&hbgS#w(-5;XF4LT@BxOueNI;5HlwPv!p-;8?
zAna{~J@{6o|9}YoNxu6JSkFn5T9%N@cfRu@=gT?yteu;p?$lfPRmS+QAL92)p;1}$
zoE@*J?^WGTS_RBzJv=Wfedv7X20ittdm`VTzEOkDarZQM-8p7T!E;&~8!m)UZ`f?a
zMk4ESu=JNq(dNO?8#6x1eD@yt#^dkX7d~Z39~{FP7DCu-I2>BfU-?{eGQJguN(eR_
zAlpY;q>x85@VW0kpeiG-RKRvxe5S7adc>lN*$@oJ<5FBtqJ2dxfo?ksNe@YE2JEfP
zd`(o(9y4||#V%cc$K(E(u7r;aJbLVmGDQyCwI=WeLURJ|TSme@LKw3}&<^9+C4{B~
zd&i_C0u~iQV40Laz@j1n^pPh-$pJ-^pVEiQ1#y%Ykj*19ACdfI$`G>1XASFDLZTUp
zu5IMY;?9>_v!YRKq?0s8`f3|O(EB}9g*b=FF)U&eo}^dfgMj)#r=&*76%UEhrf_Rh
zS%u~y@XIrh$a?=L^$_-*R(cxrG@hz_3;V`_e1~3rQd7AL#*6CQG%^X~NXH#4u7!VA
z3QNju&#2Z|dp(_OIBhp==+AWd3GeH<HaQj{(_T-_hGe46&Um;w`D;S#awhOD^_ct7
zY=X_ROo);@D3g(*DXKJ6JS;*MB9x}OgJlZP*fS9=CVn&A_h`MbQ|>MgZcYl|@1T-O
QJRDtB=INi93%AwXe}v%_7XSbN

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index 0ea38e1e72977e82053b087a6bd2e4ea21373420..b658329c5b8e7eba009ad96f7cd26674b5a2c861 100644
GIT binary patch
delta 57
zcmeBm{cp?V66_N4Uygx+@$W{iBv}!Wc=rHTj(87G7hXr_08ax012cxrl?sN8?0zgU
M@xe~<liifu0q=Pa^Z)<=

delta 974
zcmZWo&ubG=5Pq*IHGQ$QF>8!sY-mMANxL>BCk3~gH5=WRF1xW*Ht?28u!@pL+8%P+
z#*0wsDfHkiO8x=y;$P=Fvp;Ik1eR~UZ)P%+`8IrZZm@>i=$x++LJxkhgL2TWZU}cr
z*m_I#K5JEO+KsF*Ta6{VZL6AECt2|tBHsJd9}Fvp{bTv@<XvUZJL;bd-u8}&QV?!O
zBa_83Z?qjUB~zC3D7W-iM9~(wtG8z~Nqlb|wJ`kt^umXVz>z+84Qo;u^H$rXyz}CX
zPbJ0RTXCX{xx@EjmSup3Xy8-ddw^Z0RH<^u?a-ON^6Mdq8s^5_a0Qj@TAJ-ET8Zn9
zyO_=Zxj~ei<xYJ&Ut{XoV?wTG$UmRoVf;zyBn*e-3=7#ZOl!sPIzTgq_bnr39|26*
zBG>kl+}i*HQ*vj=#3}?9b^>6TSb@O8E(4?yU@-=f41qaOE|5cgfH958d_>aYO9qjJ
znl))$86!<#=h{|2SY>y<+?-t+m&HYK$!Nja7Guy~z*Yd4p*Vp>m`F(cX_O^)M^WOS
zC?!Y2vP)RsR_<|opVQ<9L6{y)0xkZY>LK5CJM%M_iVh{;^Ic<4egILAdn#+(c&X0)
zmq>w5CRo`JP1}fFt?714Rl(NEEn%oNQs{2Zr~XIpqhWuZmY>i-U+$u?!n57Y%xp?F
zGI~~klk!W9H7Q~6Ee(lxYTDePIl@@U8?9oH!JAg_!tk&VS%6^CiZ?1_f<~UR$fxiZ
ig8L)0!{F2_k8Z>b;N_^`((rKgin4%j$lUnX-R2*u`WpiP

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
index ecd0d8564b21016028d8ecd740f8647e0cbf8878..e46c1fb5a21b8b45a4db5955989941875169a46d 100644
GIT binary patch
delta 536
zcmbR5+3CUM66_Mfslvd(czYw4jI3~UlP_zGK68AqQ+$B4r-83WfXn2A3L=yJWF;rJ
zDk|_cIr+xufn<R)&L9~z7f)Ybg_P8?%;eN!1`b~rzaTE==tjL5eHIi$mMba<=%5Rp
zP?S?qK@;={@C{=24R-ZW@bz~M0}{c`3Y*hq=P|KFH~F(o{;wz%&L8g_6wI*17f8m3
zdb)`4#|MWv0{KC~Ay9rmgfEZ}B*A>4c>mxK<|RO*!15WHSt0`Qu3iR=OMHPONJ$3R
z?A=OI^)xcuH^9J%17s7gL4|=414q1vrwfnc1)c_=<B>gMLy2!DtEm_nibw+^$UVR{
x-qpaE0UDK{$np(#_7e~R$$%~Ab#xB!G%zqQW7uq>V93bs#}WgIugMWA?f}=0mk|H}

delta 716
zcmeD5nD5Eu66_K(Uxk5zQFkMkjI4lwpRQhfuv2`1v!_9HlcVlrQ(42!_Hy%>^ab?d
z-2+@X;ypZFcpaSsJPiyC%os!@<6RAm8DjKVV48eA0$hB9o&7d<DH$><cp1llBn138
zV)U7jm2mjF_yut>Pfn9nU}}_~d{$P0QFiiQSvg5jj{x5wX5U~}9|d23*DxRv?5q&o
z<i$Ptp@LMsT)cBoFvAjb`+$P+p`I=xa`C|-j+oLx!68uTfCyhqX`mojS~1=~ID{F)
zaG)SaIwLbnq+UMW)ysepLkUn2tOVpv-v9$c4iJympu)hA0UTgFju&_ufUcv|@%0qB
jo;b%F!5wde;rM#Yz@t~tgB>r35%iPQm5e4IQg#ObnF_{n

-- 
MST
