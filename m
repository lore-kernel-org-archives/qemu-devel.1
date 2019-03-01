Received: from eggs.gnu.org ([209.51.188.92]:43680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0f-0001cl-FQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0c-0001Ob-Hk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:17 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzf0b-0001NR-Q8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id z84so11637328wmg.4
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 02:03:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Mar 2019 10:03:06 +0000
Message-Id: <20190301100310.22345-2-alex.bennee@linaro.org>
In-Reply-To: <20190301100310.22345-1-alex.bennee@linaro.org>
References: <20190301100310.22345-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v2 1/5] contrib: gitdm: Update domain-map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add Citrix, Huawei, Intel, and Microsoft to domain-map.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
[AJB: sorted, added Fujitsu]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 0ab41ee27a..fa9d454473 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -5,10 +5,15 @@
 #
 
 amd.com         AMD
+citrix.com      Citrix
 greensocs.com   GreenSocs
+fujitsu.com     Fujitsu
+huawei.com      Huawei
 ibm.com         IBM
 igalia.com      Igalia
+intel.com       Intel
 linaro.org      Linaro
+microsoft.com   Microsoft
 nokia.com       Nokia
 oracle.com      Oracle
 proxmox.com     Proxmox
-- 
2.20.1
