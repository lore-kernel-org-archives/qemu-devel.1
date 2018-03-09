Received: from eggs.gnu.org ([2001:4830:134:3::10]:45369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwS-00017e-LQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwR-0007Uk-J1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  9 Mar 2018 13:19:44 +0000
Message-Id: <20180309131949.18640-3-stefanha@redhat.com>
In-Reply-To: <20180309131949.18640-1-stefanha@redhat.com>
References: <20180309131949.18640-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] README: Fix typo 'git-publish'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Fam Zheng <famz@redhat.com>

Reported-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180306024328.19195-1-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 7833b97365..49a9fd09cd 100644
--- a/README
+++ b/README
@@ -73,7 +73,7 @@ The QEMU website is also maintained under source contro=
l.
   git clone git://git.qemu.org/qemu-web.git
   https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
=20
-A 'git-profile' utility was created to make above process less
+A 'git-publish' utility was created to make above process less
 cumbersome, and is highly recommended for making regular contributions,
 or even just for sending consecutive patch series revisions. It also
 requires a working 'git send-email' setup, and by default doesn't
--=20
2.14.3
