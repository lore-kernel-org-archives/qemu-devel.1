Received: from eggs.gnu.org ([209.51.188.92]:46031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSog-0002Jk-9E
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSof-0001Qn-1t
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:11:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggSoe-0001Lf-Rx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:11:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id g67so509166wmd.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:11:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  7 Jan 2019 11:11:28 +0000
Message-Id: <20190107111129.2087-3-alex.bennee@linaro.org>
In-Reply-To: <20190107111129.2087-1-alex.bennee@linaro.org>
References: <20190107111129.2087-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 2/3] contrib/gitdm: Add other IBMers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Joel Stanley <joel@jms.id.au>

Here are some IBMers who use their personal addresses when submitting
patches.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-ibm | 5 +++++
 1 file changed, 5 insertions(+)

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
