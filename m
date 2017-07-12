Received: from eggs.gnu.org ([2001:4830:134:3::10]:42595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH6c-0000U7-EW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH6Z-00054t-EA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVH6Z-00054U-8D
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:59 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Jul 2017 14:49:50 +0200
Message-Id: <1499863793-18627-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1499863793-18627-1-git-send-email-thuth@redhat.com>
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/11] roms/SLOF: Update submodule to latest
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

We need the latest fixes for building the libc and libnet
of SLOF for the s390-ccw network bootloader firmware.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 roms/SLOF | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/SLOF b/roms/SLOF
index 66d250e..834113a 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 66d250ef0fd06bb88b7399b9563b5008201f2d63
+Subproject commit 834113a1c67d6fb53dea153c3313d182238f2d36
-- 
1.8.3.1
