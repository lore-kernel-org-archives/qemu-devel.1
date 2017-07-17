Received: from eggs.gnu.org ([2001:4830:134:3::10]:50313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2UJ-0007SS-OZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2UH-0000lT-3J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2UG-0000kX-Tb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD70685547
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:38:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:38:39 +0200
Message-Id: <20170717093839.15341-4-kraxel@redhat.com>
In-Reply-To: <20170717093839.15341-1-kraxel@redhat.com>
References: <20170717093839.15341-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] keymaps: fr-ca: add missing keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170712072305.29233-1-kraxel@redhat.com
---
 pc-bios/keymaps/fr-ca | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
index b645208e42..030f56a78e 100644
--- a/pc-bios/keymaps/fr-ca
+++ b/pc-bios/keymaps/fr-ca
@@ -48,3 +48,5 @@ parenleft 0xa shift
 parenright 0xb shift
 underscore 0xc shift
 plus 0xd shift
+minus 0xc
+equal 0xd
-- 
2.9.3
