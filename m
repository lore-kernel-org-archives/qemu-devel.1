Received: from eggs.gnu.org ([2001:4830:134:3::10]:35543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYtQ0-0003G7-24
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYtPx-0007YZ-Dg
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:58:47 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 17 Dec 2018 13:30:10 +0000
Message-ID: <20181217133011.31433-18-paul.durrant@citrix.com>
In-Reply-To: <20181217133011.31433-1-paul.durrant@citrix.com>
References: <20181217133011.31433-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 17/18] MAINTAINERS: add myself as a Xen
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>

I have made many significant contributions to the Xen code in QEMU,
particularly the recent patches introducing a new PV device framework.
I intend to make further significant contributions, porting other PV back-
ends to the new framework with the intent of eventually removing the
legacy code. It therefore seems reasonable that I become a maintainer of
the Xen code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony Perard <anthony.perard@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>

v2:
 - Fix typo
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9875581df2..e6bd44189a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -396,6 +396,7 @@ Guest CPU Cores (Xen):
 X86
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
+M: Paul Durrant <paul.durrant@citrix.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*
-- 
2.20.1.2.gb21ebb6
