Received: from eggs.gnu.org ([2001:4830:134:3::10]:53479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIK-0007Cr-2D
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIJ-0002hO-Bm
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIJ-0002h4-5b
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4179A4DB14
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:53:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:13 +0100
Message-Id: <20170105165329.17227-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/20] doc: fix spelling
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

I am pretty sure that's the word Fabrice Bellard intended to write.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 6ee8a8adc3..cfa25ceea0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3016,7 +3016,7 @@ udp::4555@@:4556} to QEMU. Another approach is to u=
se a patched
 version of netcat which can listen to a TCP port and send and receive
 characters via udp.  If you have a patched version of netcat which
 activates telnet remote echo and single char transfer, then you can
-use the following options to step up a netcat redirector to allow
+use the following options to set up a netcat redirector to allow
 telnet on port 5555 to access the QEMU port.
 @table @code
 @item QEMU Options:
--=20
2.11.0
