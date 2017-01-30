Received: from eggs.gnu.org ([2001:4830:134:3::10]:37807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBf-0003TG-Oz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBe-0006O5-WB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCBe-0006Nu-RE
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:02 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0099D6540B
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:40:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:14 +0400
Message-Id: <20170130133954.31353-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/41] MAINTAINERS: add myself to qemu-char.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

I consider to have enough experience with qemu-char to propose myself as
maintainer. This will allow me to send pull request without waiting for
Paolo.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0be7bc0d4..5efd8cc671 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1194,6 +1194,7 @@ T: git git://github.com/jnsnow/qemu.git bitmaps
=20
 Character device backends
 M: Paolo Bonzini <pbonzini@redhat.com>
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 S: Maintained
 F: qemu-char.c
 F: backends/msmouse.c
--=20
2.11.0.295.gd7dffce1c.dirty
