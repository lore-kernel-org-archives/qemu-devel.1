Received: from eggs.gnu.org ([2001:4830:134:3::10]:44496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6n-0001uc-1R
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6k-0004Fu-K3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:21:00 -0500
Received: from mail.kernel.org ([198.145.29.136]:51428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6k-0004FK-5I
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:58 -0500
Date: Thu, 2 Mar 2017 08:20:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-15-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] tests/acpi: update DSDT after last patch
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/q35/DSDT        | Bin 7860 -> 7824 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7877 -> 7841 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8323 -> 8287 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7935 -> 7899 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9225 -> 9189 bytes
 5 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index d11567c3dc220894911166681ee7303fadfe04e8..0dccad439b8e8e00b403c8d290a89630c4329d45 100644
GIT binary patch
delta 106
zcmdmDJHeLACD<iof*b<_W9>w)elBmW_+Y2_=q6{biHlW)M10ue{ezuZy0RIZUBV3)
y__0oWs-<U~P@TXfo3KD&(&S9WT95=62UuEo(qtfQoB$CM0ErbOYz}3NmjwWRx*t3M

delta 142
zcmbPWyTz8vCD<ioiyQ+3<Bf@2{apS$@xe~<(M|3=6Bnz<aRi431Tb(ohXnaBh`4aZ
z`v*I-bY(L*yM!AqaATi%Q_IZ=q@n;QU<^`J4I;Q?LF58~Ns}`fYe7o6IKUdjCQXK^
Sg9r<NgbP55Hybj>%K`v}Ln$x-

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index 412a6e910404dca9b5d6e6c2d027b9e10ccc2a84..8cd66c3b3143297a5262480e46be9ee811a6291f 100644
GIT binary patch
delta 106
zcmX?VyU>=)CD<iop&SDPqwGYkelBmW_+Y2_=q6{biHlW)M10ue{ezuZy0RIZUBV3)
y__0oWs-<U~P@TXfo3KD&(&S9WT95=62UuEo(qtfQoB$CM0ErbOYz}2CkOcs6zaJm~

delta 142
zcmZ2zd(@W8CD<k8s2l?WW5q<SelCBW_+Y2_=q7ibiHlX_ID$h10vI@)LxOx5L|i!I
z{ezuZy0RIZUBV3)xUo;XspVz_Qc(aDFa{~A1`%AcAaa4gq{*3#wIHQj9AFJ%lP1H|
RL4*ZB!UZ73n++KYWC3vWDHH$z

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index 79902d0d30f02d74594cb87b14460ea02764d460..3c28a17a69db15dc92c825c1502a7f86ab975c0d 100644
GIT binary patch
delta 106
zcmZp6yzju}66_KZufV{-_-!IrKbJRGe6Uk|bdxjJ#KkH?B0lW#{=v>HUD*uIF5!j?
y{8%SG)zULgs7~OLO;{i>X>ulGEl7fk11v2(X)=&DPJoCBfW!(CHit6m$pZkUtRH*;

delta 142
zcmccb(Co<N66_MvtiZs)7&wuupUa;oKG-Qfy2+hq;$js!j^NOM00s`{kRTrh5f{#Q
z|6pg9u51QpmvF-cZtN3pYPlJKR1^ROj6sU3K?Ij9h+H5rX>ulGEl4RB2UvsHq{%RK
R5Mcq3Z~;j1W<y3jc>q1nC~yD(

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index b658329c5b8e7eba009ad96f7cd26674b5a2c861..3ceb876127725f199e3df903bc71e4023e2fa225 100644
GIT binary patch
delta 106
zcmexwd)t=FCD<k8wj2Wk<D!XN{aoH$@xe~<(M`@=6BnxpiTJR``v*I-bY(L*yM!Aq
y@ME3$R7=k|p*n#}HerFlq{*3#wIB&D4zRTFq{%?qH~}Ii01_)m*c{5ZN)`a-jUbHx

delta 142
zcmca@``?z!CD<k8zZ?St<KKx~{apS$@xe~<(M|3=6Bnz<aRi431Tb(ohXnaBh`4aZ
z`v*I-bY(L*yM!AqaATi%Q_IZ=q@n;QU<^`J4I;Q?LF58~Ns}`fYe7o6IKUdjCQXK^
Sg9r<NgbP55Hybjpk_7+}{VIU~

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
index e46c1fb5a21b8b45a4db5955989941875169a46d..bdbefd47a5398ed96498b77bfb6a74f7ea638db1 100644
GIT binary patch
delta 106
zcmeD5c<RpO66_N4RGEQ+v2h|-KbJRGe6Uk|bdxjJ#KkH?B0lW#{=v>HUD*uIF5!j?
y{8%SG)zULgs7~OLO;{i>X>ulGEl7fk11v2(X)=&DPJoCBfW!(CHit59Q33$GF(5Ml

delta 142
zcmaFr-s!>R66_Mfslvd(czYsOKbJpGe6Uk|bdx*J#KkId9KoRh0Sp|@AwfP2A}*Zq
z{=v>HUD*uIF5!j?+}J1H)N(TdsVD#n7=sj5g9t8J5V=5L(&S9WT98sM4zLEXNt0pf
RAi@G5;R2B2&4!FylmJxFDJK8`

-- 
MST
