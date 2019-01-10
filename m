Received: from eggs.gnu.org ([209.51.188.92]:57991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghb52-0005zK-FE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghasS-00033Q-Ke
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:00:10 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:12098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghasS-00031h-B2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:00:08 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 10 Jan 2019 13:49:11 +0000
Message-ID: <20190110134917.16425-20-anthony.perard@citrix.com>
In-Reply-To: <20190110134917.16425-1-anthony.perard@citrix.com>
References: <20190110134917.16425-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 19/25] MAINTAINERS: add myself as a Xen
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Paul Durrant <paul.durrant@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

I have made many significant contributions to the Xen code in QEMU,
particularly the recent patches introducing a new PV device framework.
I intend to make further significant contributions, porting other PV back-
ends to the new framework with the intent of eventually removing the
legacy code. It therefore seems reasonable that I become a maintainer of
the Xen code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony Perard <anthony.perard@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43b2691b5d..2a1520dee7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -407,6 +407,7 @@ Guest CPU Cores (Xen):
 X86
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
+M: Paul Durrant <paul.durrant@citrix.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*
-- 
Anthony PERARD
