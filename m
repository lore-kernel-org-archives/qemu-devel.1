Received: from eggs.gnu.org ([209.51.188.92]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0i-0001gu-RI
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0d-0001On-2d
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzf0c-0001OD-OY
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id a62so11982823wmh.4
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 02:03:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Mar 2019 10:03:07 +0000
Message-Id: <20190301100310.22345-3-alex.bennee@linaro.org>
In-Reply-To: <20190301100310.22345-1-alex.bennee@linaro.org>
References: <20190301100310.22345-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/5] contrib: gitdm: Update Wave Computing
 group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add all missing MIPS/Imgtec/Wave contributors (from the inception of
QEMU).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-wavecomp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/gitdm/group-map-wavecomp b/contrib/gitdm/group-map-wavecomp
index 2801a966b6..c5c57f0eaf 100644
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
2.20.1
