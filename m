Received: from eggs.gnu.org ([2001:4830:134:3::10]:58816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykY-0004q6-So
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykU-0006SY-3z
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:12 +0300
Message-Id: <98e14c100e7f1bc03ae610ff587f08f30a5087ab.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 08/31] usb: Fix typo in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Frediano Ziglio <fziglio@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Frediano Ziglio <fziglio@redhat.com>

simliar -> similar

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/usb-storage.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.1.4
