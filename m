Received: from eggs.gnu.org ([209.51.188.92]:53380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oR-0001Rb-5k
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oO-0002b2-KG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:07 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4oO-0002Xz-B0
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id d15so110854wmb.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:10:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 16:09:56 +0000
Message-Id: <20190114160956.7513-6-alex.bennee@linaro.org>
In-Reply-To: <20190114160956.7513-1-alex.bennee@linaro.org>
References: <20190114160956.7513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/5] MAINTAINERS: add myself as a route for
 gitdm updates
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

Seeing as I'll get pegged by get_maintainers.pl anyway I might as well
make the support status of the data mining config official.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 87f90721b9..f3002e1872 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2494,6 +2494,12 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/build-system.txt
 
+GIT Data Mining Config
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
+F: gitdm.config
+F: contrib/gitdm/*
+
 Incompatible changes
 R: libvir-list@redhat.com
 F: qemu-deprecated.texi
-- 
2.17.1
