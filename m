Received: from eggs.gnu.org ([2001:4830:134:3::10]:34881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dW5Cu-0004Kj-NS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dW5Ct-0006PW-TQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:20:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dW5Ct-0006P1-NG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAC0F141C5
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 18:20:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 14 Jul 2017 20:20:11 +0200
Message-Id: <20170714182012.4595-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170714182012.4595-1-marcandre.lureau@redhat.com>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 8/8] MAINTAINERS: add Dump maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Proposing myself, since I have some familiarity with the code now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9aa878b84..391a28315c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1274,6 +1274,15 @@ S: Maintained
 F: device_tree.c
 F: include/sysemu/device_tree.h
=20
+Dump
+S: Supported
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+F: dump.c
+F: stubs/dump.c
+F: include/sysemu/dump.h
+F: include/sysemu/dump-arch.h
+F: scripts/dump-guest-memory.py
+
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
--=20
2.13.1.395.gf7b71de06
