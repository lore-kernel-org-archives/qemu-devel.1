Received: from eggs.gnu.org ([2001:4830:134:3::10]:47319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEeeK-0002Bj-IC
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEeeF-0005Tz-Gx
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:00:52 -0500
From: Frediano Ziglio <fziglio@redhat.com>
Date: Wed,  7 Dec 2016 16:00:37 +0000
Message-Id: <20161207160037.4583-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH v2] usb: Fix typo in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

simliar -> similar

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 docs/usb-storage.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v1:
- extend commit message

diff --git a/docs/usb-storage.txt b/docs/usb-storage.txt
index fbc1f2e..551af6f 100644
--- a/docs/usb-storage.txt
+++ b/docs/usb-storage.txt
@@ -34,7 +34,7 @@ with tree logical units:
 Number three emulates the classic bulk-only transport protocol too.
 It's called "usb-bot".  It shares most code with "usb-storage", and
 the guest will not be able to see the difference.  The qemu command
-line interface is simliar to usb-uas though, i.e. no automatic scsi
+line interface is similar to usb-uas though, i.e. no automatic scsi
 disk creation.  It also features support for up to 16 LUNs.  The LUN
 numbers must be continuous, i.e. for three devices you must use 0+1+2.
 The 0+1+5 numbering from the "usb-uas" example isn't going to work
-- 
2.9.3
