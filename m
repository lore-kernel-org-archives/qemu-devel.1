Received: from eggs.gnu.org ([2001:4830:134:3::10]:43015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPG-0008Eh-2w
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPC-0007Xi-Jj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:51 +0100
Message-Id: <20181211180352.19644-30-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/30] maint: Grammar fix to mailmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

Make the sentence read better.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20181207170733.129532-1-eblake@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index ed8faa5719..b8e08297c9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -34,6 +34,6 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu
 
 
 # Also list preferred name forms where people have changed their
-# git author config, or having utf8/latin1 encoding issues.
+# git author config, or had utf8/latin1 encoding issues.
 Daniel P. Berrangé <berrange@redhat.com>
 Reimar Döffinger <Reimar.Doeffinger@gmx.de>
-- 
2.19.2
