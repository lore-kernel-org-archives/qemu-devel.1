Received: from eggs.gnu.org ([2001:4830:134:3::10]:48852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds114-0003yT-On
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 02:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds111-0002nC-L0
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 02:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds111-0002m8-Eq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 02:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C6ABC04B31B
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 06:19:14 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 13 Sep 2017 14:19:04 +0800
Message-Id: <1505283544-25892-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: add DUMP entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add Marc-Andr=C3=A9 Lureau and Peter Xu as dump maintainers.

CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eeb42..31ede5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1248,6 +1248,12 @@ F: docs/bitmaps.md
 T: git git://github.com/famz/qemu.git bitmaps
 T: git git://github.com/jnsnow/qemu.git bitmaps
=20
+DUMP
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+M: Peter Xu <peterx@redhat.com
+S: Maintained
+F: dump.c
+
 Character device backends
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
--=20
2.7.4
