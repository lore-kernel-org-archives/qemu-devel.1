Received: from eggs.gnu.org ([2001:4830:134:3::10]:56701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoCSW-0003S5-PA
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoCSS-00016K-Ns
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:16:08 -0500
Message-Id: <714a1f4de36cfb5a1ffca59dcf29822bcdccb92e.1519150239.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1519150239.git.balaton@eik.bme.hu>
References: <cover.1519150239.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 20 Feb 2018 18:55:32 +0100
Subject: [Qemu-devel] [PATCH 1/2] roms: Added git submodule for
 u-boot-sam460 (firmware for sam460ex)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 .gitmodules | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitmodules b/.gitmodules
index 7a8282d..b76fb45 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,6 @@
 [submodule "roms/seabios-hppa"]
 	path = roms/seabios-hppa
 	url = git://github.com/hdeller/seabios-hppa.git
+[submodule "roms/u-boot-sam460ex"]
+	path = roms/u-boot-sam460ex
+	url = git://github.com/zbalaton/u-boot-sam460ex
-- 
2.7.6
