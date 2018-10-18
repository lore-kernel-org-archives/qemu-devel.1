Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMO-0000dX-QD
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMH-0005fB-PX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56669 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDDM9-00043e-8X
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:17 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 18 Oct 2018 20:47:26 +0200
Message-Id: <1539888473-16340-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 01/28] mailmap: Add an item for Yongbok Kim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Yongbok Kim used two email adresses for QEMU contributions -
his company changed its ownership/name.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 6f2ff22..ed8faa5 100644
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
