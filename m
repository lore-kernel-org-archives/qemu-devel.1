Received: from eggs.gnu.org ([2001:4830:134:3::10]:35034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGKX-0006xh-SI
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGKW-0008Gv-8w
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:26:41 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:56:15 +0100
Message-Id: <20181218115615.1499-13-philmd@redhat.com>
In-Reply-To: <20181218115615.1499-1-philmd@redhat.com>
References: <20181218115615.1499-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/12] MAINTAINERS: Add maintainer to the
 TCG/i386 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Richard obviously maintains this subdirectory, make this official :)

Remove the qemu-devel@nongnu.org entry because the list is always
selected by the 'All patches CC here' section.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49f8f2fa37..a879ddfc53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2175,7 +2175,7 @@ F: tcg/arm/
 F: disas/arm.c
=20
 i386 target
-L: qemu-devel@nongnu.org
+M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/i386/
 F: disas/i386.c
--=20
2.17.2
