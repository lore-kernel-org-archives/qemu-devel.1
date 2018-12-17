Received: from eggs.gnu.org ([2001:4830:134:3::10]:58691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1U7-0007oW-Nz
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1U4-0007uQ-Jj
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:35 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:50960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZ1U4-0007oE-Cx
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:32 -0500
Received: from player718.ha.ovh.net (unknown [10.109.160.5])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D30C3177501
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:35:30 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 17 Dec 2018 23:34:45 +0100
Message-Id: <20181217223445.28594-8-clg@kaod.org>
In-Reply-To: <20181217223445.28594-1-clg@kaod.org>
References: <20181217223445.28594-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 7/7] MAINTAINERS: PPC: add a XIVE section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83c127f0d6e4..6a648d29a9bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1009,6 +1009,14 @@ F: tests/libqos/*spapr*
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
2.17.2
