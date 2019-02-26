Received: from eggs.gnu.org ([209.51.188.92]:59705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqt-000411-Il
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqr-0004TR-Vw
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:07 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyfqr-0004RA-II
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:05 -0500
Received: by mail-wm1-x341.google.com with SMTP id n19so3080756wmi.1
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:45:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 16:44:58 +0000
Message-Id: <20190226164500.8080-5-alex.bennee@linaro.org>
In-Reply-To: <20190226164500.8080-1-alex.bennee@linaro.org>
References: <20190226164500.8080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 4/6] contrib: gitdm: add more individual
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Fredrik Noring <noring@nocrew.org>

I know Richard's is right because I asked him in the pub. I'm guessing
Fredrik's based on the fact I vaguely remember an Atari demo.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-individuals | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index afdbe7d460..194d42fcd8 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -8,3 +8,5 @@
 f4bug@amsat.org
 mjt@tls.msk.ru
 mark.cave-ayland@ilande.co.uk
+rth@twiddle.net
+noring@nocrew.org
-- 
2.20.1
