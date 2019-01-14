Received: from eggs.gnu.org ([209.51.188.92]:53359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oP-0001R7-7y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oM-0002ZG-64
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:05 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4oL-0002Ux-2i
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:01 -0500
Received: by mail-wr1-x436.google.com with SMTP id t27so23515973wra.6
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:09:59 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 16:09:52 +0000
Message-Id: <20190114160956.7513-2-alex.bennee@linaro.org>
In-Reply-To: <20190114160956.7513-1-alex.bennee@linaro.org>
References: <20190114160956.7513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/5] contrib/gitdm: add Nokia and Proxmox to the
 domain-map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

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
