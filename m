Received: from eggs.gnu.org ([209.51.188.92]:48668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8rk-0001BH-Sn
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8rj-0003qM-Ty
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:52 -0400
Received: from mail-it1-x136.google.com ([2607:f8b0:4864:20::136]:40012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hL8rj-0003pL-Md
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:51 -0400
Received: by mail-it1-x136.google.com with SMTP id k64so9777174itb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:10:51 -0700 (PDT)
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 29 Apr 2019 12:10:45 -0400
Message-Id: <20190429161046.10527-1-stefanha@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

The following changes since commit e0fb2c3d89aa77057ac4aa073e01f4ca484449b0:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190426' into staging (2019-04-28 11:43:10 +0100)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to b1939fcd438b7140cb8f2685dee026bb112819d7:

  trace: fix runstate tracing (2019-04-29 11:57:19 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Yury Kotov (1):
  trace: fix runstate tracing

 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1
