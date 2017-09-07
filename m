Received: from eggs.gnu.org ([2001:4830:134:3::10]:57170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dprv0-0007MO-3l
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpruw-00055h-2S
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpruv-00055B-SY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:12:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:11:56 +0800
Message-Id: <20170907081158.4063-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] docker: Update ubuntu and test-full for
 more coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>



Fam Zheng (2):
  docker: Update ubuntu image
  docker: Enable features explicitly in test-full

 tests/docker/dockerfiles/ubuntu.docker | 11 +++--
 tests/docker/test-full                 | 80 +++++++++++++++++++++++++++++++---
 2 files changed, 83 insertions(+), 8 deletions(-)

-- 
2.13.5
