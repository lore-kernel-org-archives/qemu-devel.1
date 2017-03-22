Received: from eggs.gnu.org ([2001:4830:134:3::10]:41095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cqep2-0006ng-5h
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cqeoy-00013a-9b
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:53:00 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Mar 2017 15:52:41 +0400
Message-Id: <20170322115241.2810-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] doc: fix function spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/io/channel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 5d48906998..db9bb022a1 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -315,7 +315,7 @@ ssize_t qio_channel_read(QIOChannel *ioc,
                          Error **errp);
=20
 /**
- * qio_channel_writev:
+ * qio_channel_write:
  * @ioc: the channel object
  * @buf: the memory regions to send data from
  * @buflen: the length of @buf
--=20
2.12.0.191.gc5d8de91d
