Received: from eggs.gnu.org ([209.51.188.92]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkRLl-0005sX-EH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkRLj-0000mX-CW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:09 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51906 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkRLj-0000hG-4Z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:07 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 11:25:54 +0100
Message-Id: <1547807155-4526-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547807155-4526-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547807155-4526-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/2] contrib: gitdm: Update domain-map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add Citrix, Huawei, Intel, and Microsoft to domain-map.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 contrib/gitdm/domain-map | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 0ab41ee..9c09285 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -5,10 +5,14 @@
 #
 
 amd.com         AMD
+citrix.com      Citrix
 greensocs.com   GreenSocs
+huawei.com      Huawei
 ibm.com         IBM
+intel.com       Intel
 igalia.com      Igalia
 linaro.org      Linaro
+microsoft.com   Microsoft
 nokia.com       Nokia
 oracle.com      Oracle
 proxmox.com     Proxmox
-- 
2.7.4
