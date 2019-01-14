Received: from eggs.gnu.org ([209.51.188.92]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oP-0001R4-2e
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oM-0002Z9-57
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:04 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4oK-0002V9-8Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:00 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so124880wmj.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:09:59 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 16:09:53 +0000
Message-Id: <20190114160956.7513-3-alex.bennee@linaro.org>
In-Reply-To: <20190114160956.7513-1-alex.bennee@linaro.org>
References: <20190114160956.7513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/5] contrib/gitdm: Add other IBMers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Joel Stanley <joel@jms.id.au>

Here are some IBMers who use their personal addresses when submitting
patches.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index b66db5f4a8..6c0570107d 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -2,5 +2,10 @@
 # Some IBM contributors submit via another domain
 #
 
+aik@ozlabs.ru
+andrew@aj.id.au
+benh@kernel.crashing.org
 clg@kaod.org
 groug@kaod.org
+joel@jms.id.au
+sjitindarsingh@gmail.com
-- 
2.17.1
