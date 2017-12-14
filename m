Received: from eggs.gnu.org ([2001:4830:134:3::10]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1j-0007gv-6L
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1e-0006Bh-Tq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:31 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:21 +0100
Message-Id: <20171214171004.25058-4-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/46] pc-bios/s390-ccw.img: update image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Contains the following commit:
- pc-bios/s390-ccw: zero out bss section

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw.img | Bin 26416 -> 26416 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/s390-ccw.img b/pc-bios/s390-ccw.img
index 7415f1a3e797a17ce4ede0ee39034288b4ecae86..97155d2638eebc1220a63287fcada21df65b3a77 100644
GIT binary patch
delta 1426
zcmYLJT}%{L6h3EISr;e_umTG#4$C6lg0Qj{s)*giwU!p@@?*uHs7*v4G`d>q4@s-7
z)J99qb`Nb6YjwrwSo^YYX>@&Pr)n)}6KY6Qd}vCtnwr?3p&?qeWqa??)cY{=-S3|J
zoipD#ndk^cM=*5L5&~nb3w=2Lb>`6Yrse-PMe(e4_sPjmZjJ4GHTXeN^_h}64V`-}
ze%dN+!66!xmhq>O^q%VvO$Jbojaqe82JH?&#^IO=`USGuH3eXCk->WCT2h6S0W_7=
zjPt0;R5E)?9Hd_nL9-tj_$z@+Y6Qj}I%0aG@p_g+?MVz8r*X9sQ0;-74kcuyDl!!8
z4@3<3MNHaKL+x8bq1?bHjk~L;X~v3u2i3{MfWbBk7XCEwY9m51@D2m#3+xCRG2>>l
zrUQOv6<m!=a|0f4jio|$Oac$jYg6kIiF-?6CZuu3&p$qkvzD6)8D#LunV>F9JQjDs
zZ1uYpP$#D@-sDHzE$$q+=<bZtvN@w>jQ+>u4Gzk14|IUizJK&&167%)%zTkMc?o_=
zUCA-*ph|OD?lN_f>l!Pr>wCb-%Y#LwwAH*4U3A6lLM#1l{=xQ^>H=AOPJS~ts|!x&
z^=l!3H9Ki^CgIbx$+C9lx`$enQ_1wbr4uicJ7otRrv8+A+)m>hS5s?heWphX0yM}0
zc>@T6h60MDG8|y-X-SAxtm7#gVn5rNUWS-VM>D+XD}Rg2dStq=mA}y4j5Qb|zg&)|
zSWu254p4hm37()mS=(_l-OYL#TWEf^3)j-RY@2<#sCibOs2Q8I2%n}GxWUh8`#EZ)
zzU-?~{ZF*kYR3`QZGC|DeqnU`3DxF>@Hy^vIUktZ#NWb|_C7k2a~j`d^K+{ZKc|g(
zZJF<@Hh_45-!W-kfVRCfoOcSjeYO(JrjYIJVpGfl7qvTy!~+XY91fq0fcga&JwGkl
zdWov@ci299qT`F|5uw$3fLoqSuQ+npX#N_+D^yunf`imrScON~JB0;^X>{DKNP)*p
zv(G@>LsyGDxQRU~dKd9i+OMp@Ub>+yFL;p;?d9nnYXR;?ulgJmirLv-N8aKExRAPw
zyQOX8bf0g2Cbz?em*^#j$1-G|5@B<q?4V;-5|*-KrLSRCmoUS5D4;|uR2xDV+@RJ?
z+oY~S5VbqI)dg@{Sm}J7Rg_&vT+JlcfP_dx<y(-EQn44kbhM&3zv1DitdA+cn|uwN
zad#vYLL#Z7iM(@Lu!x1{HY09k<CP~c^FTODALNl2_&7uXeM>3izFc7A%osR*vVNbV
zae*d)Cr9rMwr$>e#9cH}-Ds}m?Z@Y*sK{gIqrJ#;tL}m?H~~Io!p#j41q|~76g|qt
zWx)DxME&VG@u;qGJ}8p%4#o_XP8OKogVLhE=*F`@;zc@BQ_Lq~xW>o3kWyRB2eG2I
z96i)gYey&BRr{TU+i3B^0{ob*UYM6F4cum3ExRS$z<zBTPGP3?yqiNz*>K*3XK8F>
eWs0A>D3;$#a%ZjO$$vG#cfskiwjc|2M(|(tW7}&0

delta 1349
zcmYLJZ%kEX7=ND2h06tn!@mm`xNz<tU<AT7NI?E{uQ(kA>moQwoLJ#%83G&4XwDI%
z`GxSt!?c;&4W+}h+LgDZl-Ws~7;Z{z8B{hB{SaC^7-=60df&sA?}u}K@AE$A_dM_K
z_v{3(WAHlqe=vJMUpqbT&VC)!yt1kN|4l(0j(_iDbXH5tQ{Q&aZ#?*?rSRpA-yHv)
zUNh{$W|}r^=1)1~VD`8w0mvOw@tPumdKV!2#Ze;+3KaL3Dg#uc>Cs4<49PV_P190H
z4VtOi=uE#U4x)~Ur1U8r9~RgdB{1%wKI7|EpTs(pp5+n!^h+fVQ0W0ngY4H!rRfZ|
z8zKibikww8o$a{J5TfHw{oA!v9lCY%PGxcVtRBq}QJB#2lLD{)TgO#8eju>pRXyjt
z$)sw4$K#d7rCZ{%kVS=I8BW)f34{E~B4QaCk>DO^02u@SYGFFcH!V?DSS8+~%VDF~
zMF&h-iB-xXfJt9-n)U{`R5w6b4P7v8!&-_D&&D#U2)}0iNXZ6CR8Owqck6(mq(RjW
z(0G&_W<no*Zr%~zWLJYclt;-CyYU`%MYQ7xJ%}jBBjk>3$L%y2Ssv4<wgGG?_DQ=y
z5NxO<Et263JGCkVaT^<6ZAF}5m!h%|^JqTW6V;F~CuxC|#u}ojSZc&yX+X-sYfP2q
z5NGIAtP{uSYHTYWqT;w`v6Fh@vayFgjkDVJiJlV%M9)~Q2Dtfq`7k`8c5&2BcjB%X
zDnjYwcpE-s6Y-DGrt4onu2?<Le_945hx?nj{Etwj{sR4C8NwmflbDbA9etKm7sC`Q
zz?@G8FsdGax(_MIdJ?&ORwtIyto1E>?x-2QQ131;KQi;e{r#r{pq$~P=T=C!%u{!A
zyY;KbJl>!d5L{c%aLL2ygu}udDUFEt=|HLzf26_Ge7wY_Qd1BM=?|N1sC6<aEfg_8
zmh=MbW6z|&jW|Y=@>cAlO#5>wZG6VYRy<aHT#a6(7*fTQw7x`sdkJ@V!v3bAHJmm%
zO1QRN4lB;nQAdIKXVa2M%baF69SI>=!|rFifceLS7_PHEIhd<h5&FRmO6iJB%JT@K
zch{g&0(Zp7y548|v%W{{W?Qn)8ZeuTxqI*@YRm1!S7<)BH@VV2C27+#aFZv&HRldQ
zf?pJMbdY~dEpB4B*VG^$V($D8Fy>5utTw_k&+~Bz0(x6$);*Tu<&kM{c_r;3N3#Mg
z056W7C3bOb6XFR<E2uIxar@DeNqY-ye6)KDW=dzhZ42O)7u;MB(ZE&SfUE^Mxdd4L
zo9I8vG8fcT9&Zyxxr3vE<>_}=ps)uG<uYZiyMedq;W|5?h@>JfcVT;xoe$#vq8x0b
z;UXJWvnxg820ToC>r?O|JH0+B(J)fTF4yieV33v7UyY!^P9HNiaYvh(yz8718)&*Y
eFQQTdeN}2C?JhDu{uTQ8j`t>3oy`2Z1Na|Pug>TI

-- 
2.13.6
