Received: from eggs.gnu.org ([2001:4830:134:3::10]:44906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVfr-00012J-GV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVfn-0006LX-Lq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:27:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duVfn-0006K9-FG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:27:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 20 Sep 2017 11:25:53 +0800
Message-Id: <20170920032555.18911-12-famz@redhat.com>
In-Reply-To: <20170920032555.18911-1-famz@redhat.com>
References: <20170920032555.18911-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 11/13] MAINTAINERS: Add tests/vm entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d735979ef..0f8f1db332 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1901,6 +1901,7 @@ S: Maintained
 F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
+F: tests/vm/
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
-- 
2.13.5
