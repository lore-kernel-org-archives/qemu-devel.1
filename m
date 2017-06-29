Received: from eggs.gnu.org ([2001:4830:134:3::10]:47597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQN-000208-FJ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQM-0007ti-Kl
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dQZQM-0007tB-G9
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95341C058EA5
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 13:23:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Jun 2017 15:23:10 +0200
Message-Id: <20170629132310.18865-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170629132310.18865-1-marcandre.lureau@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/7] MAINTAINERS: add Dump maintainers
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
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 839f7ca063..45a0eb4cb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1272,6 +1272,13 @@ S: Maintained
 F: device_tree.c
 F: include/sysemu/device_tree.h
=20
+Dump
+S: Supported
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+F: dump.c
+F: include/sysemu/dump.h
+F: include/sysemu/dump-arch.h
+
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
--=20
2.13.1.395.gf7b71de06
