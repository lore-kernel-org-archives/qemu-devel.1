Received: from eggs.gnu.org ([209.51.188.92]:36280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTbt-0003Au-1G
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTNo-0000RU-JW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:00:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmTNn-0000CO-MW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:00:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Jan 2019 02:00:22 +0100
Message-Id: <20190124010023.24397-2-philmd@redhat.com>
In-Reply-To: <20190124010023.24397-1-philmd@redhat.com>
References: <20190124010023.24397-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] MAINTAINERS: Add an entry for
 scripts/archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The scripts/archive-source.sh is used by the VM tests, it makes
sense to add it in the "Build and test automation" section.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af339b86db..f7c38848ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2479,6 +2479,7 @@ F: scripts/travis/
 F: .shippable.yml
 F: tests/docker/
 F: tests/vm/
+F: scripts/archive-source.sh
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
--=20
2.20.1
