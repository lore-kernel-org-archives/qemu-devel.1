Received: from eggs.gnu.org ([209.51.188.92]:51308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnM-0001N8-RE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnM-0007TX-1w
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnL-0007T0-O7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:11 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:46 +0100
Message-Id: <1551356875-30676-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/13] MAINTAINERS: Add missing test entries to
 the Cryptography section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e38864..d81f9c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2069,6 +2069,8 @@ F: crypto/
 F: include/crypto/
 F: tests/test-crypto-*
 F: tests/benchmark-crypto-*
+F: tests/crypto-tls-*
+F: tests/pkix_asn1_tab.c
 F: qemu.sasl
=20
 Coroutines
--=20
1.8.3.1
