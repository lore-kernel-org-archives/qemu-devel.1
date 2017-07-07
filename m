Received: from eggs.gnu.org ([2001:4830:134:3::10]:35492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTr-0002fB-Rk
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTp-0001rd-A6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTQTp-0001r5-4R
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:21 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  7 Jul 2017 12:27:01 +0200
Message-Id: <1499423224-23060-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1499423224-23060-1-git-send-email-thuth@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 5/8] roms/SLOF: Update submodule to
 latest status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

We need the latest fixes for building the libc and libnet
of SLOF for the s390-ccw network bootloader firmware.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 roms/SLOF | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/SLOF b/roms/SLOF
index 66d250e..64215f4 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 66d250ef0fd06bb88b7399b9563b5008201f2d63
+Subproject commit 64215f41aafd182e51947dc5d544e5ebaab744ca
-- 
1.8.3.1
