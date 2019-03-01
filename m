Received: from eggs.gnu.org ([209.51.188.92]:43698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0i-0001gv-RW
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0d-0001Pe-ON
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzf0d-0001Oj-Hj
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id z84so11637430wmg.4
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 02:03:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Mar 2019 10:03:08 +0000
Message-Id: <20190301100310.22345-4-alex.bennee@linaro.org>
In-Reply-To: <20190301100310.22345-1-alex.bennee@linaro.org>
References: <20190301100310.22345-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/5] contrib: gitdm: add more individual
 contributors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Fredrik Noring <noring@nocrew.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>

I know Richard's is right because I asked him in the pub. I'm guessing
Fredrik's based on the fact I vaguely remember an Atari demo. The
others I attributed to academic institutions last time I posted so
have moved them to individuals as requested.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Fredrik Noring <noring@nocrew.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-individuals | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index afdbe7d460..05e355d30e 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -8,3 +8,8 @@
 f4bug@amsat.org
 mjt@tls.msk.ru
 mark.cave-ayland@ilande.co.uk
+rth@twiddle.net
+noring@nocrew.org
+samuel.thibault@ens-lyon.org
+aurelien@aurel32.net
+balaton@eik.bme.hu
-- 
2.20.1
