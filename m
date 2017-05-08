Received: from eggs.gnu.org ([2001:4830:134:3::10]:37275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7amD-000566-TR
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7amC-00089j-Jg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:00:05 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7amC-00089c-Fo
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:00:04 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so8244886qtb.1
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 22:00:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:57:14 -0300
Message-Id: <20170508045715.21770-23-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/23] MAINTAINERS: add Shippable automation
 platform URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1d2b3a4d3..9251f575d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1833,6 +1833,7 @@ F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
 W: https://travis-ci.org/qemu/qemu
+W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
 
 Documentation
-- 
2.11.0
