Received: from eggs.gnu.org ([209.51.188.92]:36454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTbu-0003Gj-VA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTNo-0000RR-L5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmTNn-00008r-MX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:00:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Jan 2019 02:00:21 +0100
Message-Id: <20190124010023.24397-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] archive-source.sh: Clone the submodules
 locally and add to MAINTAINERS
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

A minor change to speed up VM testing: clone submodules locally
(like we do with the QEMU repository).
Also add the script to MAINTAINERS.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  MAINTAINERS: Add an entry for scripts/archive-source.sh
  archive-source.sh: Clone the submodules locally

 MAINTAINERS               | 1 +
 scripts/archive-source.sh | 9 ++++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

--=20
2.20.1
