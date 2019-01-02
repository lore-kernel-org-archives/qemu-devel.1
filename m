Received: from eggs.gnu.org ([208.118.235.92]:51070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1geeMJ-0008U7-6L
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1geeMG-0005eg-2r
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:06:47 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>) id 1geeMF-0005eA-TI
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:06:44 -0500
Received: by mail-pf1-x442.google.com with SMTP id h3so15068814pfg.1
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 03:06:43 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed,  2 Jan 2019 21:36:12 +1030
Message-Id: <20190102110612.20387-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] gitdm: Add other IBMers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

Here are some IBMers who use their personal addresses when submitting
patches.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 contrib/gitdm/group-map-ibm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index b66db5f4a825..6c0570107d65 100644
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
2.19.1
