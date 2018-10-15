Received: from eggs.gnu.org ([2001:4830:134:3::10]:51397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gC0Ti-0007Mp-NG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gC0Te-00018E-Hb
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:52:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35403 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gC0Tc-0000V5-CM
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:51:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 15 Oct 2018 12:50:33 +0200
Message-Id: <1539600633-17726-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539600633-17726-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539600633-17726-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/3] mailmap: Add an item for Yongbok Kim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Yongbok Kim used two email adresses for QEMU contributions -
his company changed its ownership/name.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2c2b9b1..0d886a1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -12,6 +12,7 @@ Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-7
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
+Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
 Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-- 
2.7.4
