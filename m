Received: from eggs.gnu.org ([2001:4830:134:3::10]:47101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjgjR-0002c4-IY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjgjO-0003cC-GA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:30:25 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 17:30:09 +1100
Message-Id: <20170303063009.21580-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170303063009.21580-1-david@gibson.dropbear.id.au>
References: <20170303063009.21580-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/2] Update dtc submodule to v1.4.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, thuth@redhat.com, David Gibson <david@gibson.dropbear.id.au>

Since the last submodule update (which was v1.4.2) dtc and libfdt have
gained some features which would be useful in qemu.  There's now a v1.4.3
upstream release, so update our submodule to point to it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 dtc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dtc b/dtc
index ec02b34..fa8bc7f 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit ec02b34c05be04f249ffaaca4b666f5246877dea
+Subproject commit fa8bc7f928ac25f23532afc8beb2073efc8fb063
-- 
2.9.3
