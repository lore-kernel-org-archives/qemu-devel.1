Received: from eggs.gnu.org ([209.51.188.92]:51283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0tz-0000Et-SZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0ty-0004C1-1S
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0tx-0004Bk-Rv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22C25C007324
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:52 +0100
Message-Id: <1550565421-10944-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/14] MAINTAINERS: Add missing test entries to
 the Cryptography section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7b4114..59e4c8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2065,6 +2065,8 @@ F: crypto/
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
