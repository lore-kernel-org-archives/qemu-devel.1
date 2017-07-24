Received: from eggs.gnu.org ([2001:4830:134:3::10]:44835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZaRM-0005pd-Fh
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZaRL-0004Eu-FV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:18:16 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZaRL-0004Ed-81
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:18:15 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m85so13195281wma.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 03:18:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1707211740220.22381@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1707211740220.22381@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 11:17:53 +0100
Message-ID: <CAFEAcA8BdaJwtLbs+wWBbaicr=7fSD6K1ZFVNpV++_JyEEKe-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/2] please pull xen-20170721-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 22 July 2017 at 01:45, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit 91939262ffcd3c85ea6a4793d3029326eea1d649:
>
>   configure: Drop ancient Solaris 9 and earlier support (2017-07-21 15:04:05 +0100)
>
> are available in the git repository at:
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170721-tag
>
> for you to fetch changes up to 7fb394ad8a7c4609cefa2136dec16cf65d028f40:
>
>   xen-mapcache: Fix the bug when overlapping emulated DMA operations may cause inconsistency in guest memory mappings (2017-07-21 17:37:06 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/07/21
>
> ----------------------------------------------------------------
> Alexey G (1):
>       xen-mapcache: Fix the bug when overlapping emulated DMA operations may cause inconsistency in guest memory mappings
>
> Igor Druzhinin (1):
>       xen: fix compilation on 32-bit hosts
>
>  hw/i386/xen/xen-mapcache.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
