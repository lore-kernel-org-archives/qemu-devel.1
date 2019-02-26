Received: from eggs.gnu.org ([209.51.188.92]:59714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqt-000413-TL
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqs-0004Tp-4c
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:07 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyfqr-0004Q2-Bz
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:05 -0500
Received: by mail-wm1-x344.google.com with SMTP id v26so2904964wmh.3
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:45:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 16:44:56 +0000
Message-Id: <20190226164500.8080-3-alex.bennee@linaro.org>
In-Reply-To: <20190226164500.8080-1-alex.bennee@linaro.org>
References: <20190226164500.8080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/6] contrib: gitdm: Update Wave Computing
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
