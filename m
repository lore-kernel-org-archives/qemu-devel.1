Received: from eggs.gnu.org ([2001:4830:134:3::10]:45485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drxx9-0005V4-Rk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 23:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drxx8-000143-Sd
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 23:03:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1drxx8-00013h-N0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 23:03:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 13 Sep 2017 11:01:17 +0800
Message-Id: <20170913030119.3957-12-famz@redhat.com>
In-Reply-To: <20170913030119.3957-1-famz@redhat.com>
References: <20170913030119.3957-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 11/13] MAINTAINERS: Add tests/vm entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eeb42d19..42f5454311 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1891,6 +1891,7 @@ S: Maintained
 F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
+F: tests/vm/
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
-- 
2.13.5
