Received: from eggs.gnu.org ([209.51.188.92]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oR-0001RX-4a
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oO-0002ak-6U
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4oM-0002Wz-3c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id y139so92956wmc.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:10:00 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 16:09:54 +0000
Message-Id: <20190114160956.7513-4-alex.bennee@linaro.org>
In-Reply-To: <20190114160956.7513-1-alex.bennee@linaro.org>
References: <20190114160956.7513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] contrib/gitdm: add two more IBM'ers to
 group-map-ibm
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index 6c0570107d..22727319b3 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -6,6 +6,8 @@ aik@ozlabs.ru
 andrew@aj.id.au
 benh@kernel.crashing.org
 clg@kaod.org
+danielhb413@gmail.com
 groug@kaod.org
+jcfaracco@gmail.com
 joel@jms.id.au
 sjitindarsingh@gmail.com
-- 
2.17.1
