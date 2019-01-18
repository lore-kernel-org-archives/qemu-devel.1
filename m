Received: from eggs.gnu.org ([209.51.188.92]:50156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkRLk-0005rq-89
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkRLj-0000mV-CE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:08 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51913 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkRLj-0000hK-4Y
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:07 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 11:25:55 +0100
Message-Id: <1547807155-4526-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547807155-4526-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547807155-4526-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/2] contrib: gitdm: Update Wave Computing group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add all missing MIPS/Imgtec/Wave contributors (from the inception of
QEMU).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 contrib/gitdm/group-map-wavecomp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/gitdm/group-map-wavecomp b/contrib/gitdm/group-map-wavecomp
index 2801a96..c5c57f0 100644
--- a/contrib/gitdm/group-map-wavecomp
+++ b/contrib/gitdm/group-map-wavecomp
@@ -5,13 +5,25 @@
 
 aleksandar.markovic@imgtec.com
 aleksandar.markovic@mips.com
+alex.smith@imgtec.com
+andrew.bennett@imgtec.com
 amarkovic@wavecomp.com
 arikalo@wavecomp.com
+chris@mips.com
 dnikolic@wavecomp.com
+ericj@mips.com
+goran.ferenc@imgtec.com
+james.cowgill@mips.com
+james.hogan@imgtec.com
 james.hogan@mips.com
 leon.alrae@imgtec.com
+matt.redfearn@imgtec.com
 matthew.fortune@mips.com
+miodrag.dinic@imgtec.com
+paul@archlinuxmips.org
 paul.burton@imgtec.com
+petar.jovanovic@imgtec.com
+petarj@mips.com
 pburton@wavecomp.com
 smarkovic@wavecomp.com
 yongbok.kim@imgtec.com
-- 
2.7.4
