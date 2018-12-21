Received: from eggs.gnu.org ([2001:4830:134:3::10]:60929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDee-0001N3-V2
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDed-0000c3-C6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:24 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:46:06 +1100
Message-Id: <20181221054606.22007-41-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/40] MAINTAINERS: PPC: add a XIVE section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d676c73f88..0ab4676b06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1011,6 +1011,14 @@ F: tests/libqos/*spapr*
 F: tests/rtas*
 F: tests/libqos/rtas*
=20
+XIVE
+M: David Gibson <david@gibson.dropbear.id.au>
+M: C=C3=A9dric Le Goater <clg@kaod.org>
+L: qemu-ppc@nongnu.org
+S: Supported
+F: hw/*/*xive*
+F: include/hw/*/*xive*
+
 virtex_ml507
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: qemu-ppc@nongnu.org
--=20
2.19.2
