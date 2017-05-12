Received: from eggs.gnu.org ([2001:4830:134:3::10]:44398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9Bi3-0005Kg-8X
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9Bi0-0005IR-75
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d9Bi0-0005HY-1L
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:38:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 12 May 2017 10:38:11 -0400
Message-Id: <20170512143812.31067-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c526949:

  maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -0400)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 5651743c908d8c3b1ff0192ce9543a502ec7a206:

  trace: add sanity check (2017-05-12 10:37:40 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Anthony Xu (1):
  trace: add sanity check

 qom/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.9.3
