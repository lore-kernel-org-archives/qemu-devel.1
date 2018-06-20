Received: from eggs.gnu.org ([2001:4830:134:3::10]:44339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWE-0003U0-H7
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWB-00069q-EE
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVcWB-00069b-9N
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:23 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Jun 2018 14:47:13 +0200
Message-Id: <20180620124719.16450-2-kraxel@redhat.com>
In-Reply-To: <20180620124719.16450-1-kraxel@redhat.com>
References: <20180620124719.16450-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] seabios: update submodule to 1.11.2-testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

https://git.kraxel.org/cgit/seabios/log/?h=1.11-stable-testing

For testing, will be replaced with final 1.11.2 of course ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/seabios | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios b/roms/seabios
index 0551a4be2c..84c60f980e 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 0551a4be2ce599fb60e478b4c15e06ab6587822c
+Subproject commit 84c60f980e9deb3372a55e572a8f28c6733e8c01
-- 
2.9.3
