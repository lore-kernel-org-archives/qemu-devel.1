Received: from eggs.gnu.org ([2001:4830:134:3::10]:46808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfd-0002ZR-M3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfa-0004Ge-IB
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZfa-0004EX-DD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:38 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:37 +0400
Message-Id: <20181127092801.21777-5-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 04/28] MAINTAINERS: add missing
 xtensa patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c56..f4a7e453c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -311,6 +311,8 @@ F: target/xtensa/
 F: hw/xtensa/
 F: tests/tcg/xtensa/
 F: disas/xtensa.c
+F: include/hw/xtensa/xtensa-isa.h
+F: default-configs/xtensa*.mak
=20
 TriCore
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
--=20
2.20.0.rc1
