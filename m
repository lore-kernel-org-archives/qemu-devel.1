Received: from eggs.gnu.org ([209.51.188.92]:46026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSog-0002Jj-5w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSof-0001S2-85
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:11:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggSoe-0001Jc-QV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:11:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id a62so489658wmh.4
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:11:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  7 Jan 2019 11:11:27 +0000
Message-Id: <20190107111129.2087-2-alex.bennee@linaro.org>
In-Reply-To: <20190107111129.2087-1-alex.bennee@linaro.org>
References: <20190107111129.2087-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/3] contrib/gitdm: add Nokia and Proxmox to
 the domain-map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 8cbbcfe93d..0ab41ee27a 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -9,7 +9,9 @@ greensocs.com   GreenSocs
 ibm.com         IBM
 igalia.com      Igalia
 linaro.org      Linaro
+nokia.com       Nokia
 oracle.com      Oracle
+proxmox.com     Proxmox
 redhat.com      Red Hat
 siemens.com     Siemens
 sifive.com      SiFive
-- 
2.17.1
