Received: from eggs.gnu.org ([209.51.188.92]:46440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grToU-0006zQ-Ue
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grToT-00048d-Q6
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:28:54 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  6 Feb 2019 14:28:48 -0600
Message-Id: <20190206202848.16999-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qapi: Fix qcow2 encryption doc typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, berrange@redhat.com, armbru@redhat.com, mreitz@redhat.com

Present since commit b25b387f (2.10).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0f349d46033..ee1ab7a8a25 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2998,7 +2998,7 @@

 ##
 # @BlockdevQcow2EncryptionFormat:
-# @aes: AES-CBC with plain64 initialization venctors
+# @aes: AES-CBC with plain64 initialization vectors
 #
 # Since: 2.10
 ##
--=20
2.20.1
