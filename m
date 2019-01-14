Received: from eggs.gnu.org ([209.51.188.92]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oR-0001Rc-5t
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oO-0002b8-MT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:07 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4oO-0002Xq-Cb
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id f188so90815wmf.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:10:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 16:09:55 +0000
Message-Id: <20190114160956.7513-5-alex.bennee@linaro.org>
In-Reply-To: <20190114160956.7513-1-alex.bennee@linaro.org>
References: <20190114160956.7513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/5] contrib/gitdm: add another name to WaveComp
 map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Requested by Aleksandar.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-wavecomp b/contrib/gitdm/group-map-wavecomp
index c571a52c65..2801a966b6 100644
--- a/contrib/gitdm/group-map-wavecomp
+++ b/contrib/gitdm/group-map-wavecomp
@@ -9,6 +9,7 @@ amarkovic@wavecomp.com
 arikalo@wavecomp.com
 dnikolic@wavecomp.com
 james.hogan@mips.com
+leon.alrae@imgtec.com
 matthew.fortune@mips.com
 paul.burton@imgtec.com
 pburton@wavecomp.com
-- 
2.17.1
