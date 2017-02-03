Received: from eggs.gnu.org ([2001:4830:134:3::10]:45758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdeM-0004nA-RA
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdeL-0001fB-P8
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:11:38 -0500
Received: from mail-wj0-x229.google.com ([2a00:1450:400c:c01::229]:34121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZdeL-0001eO-Gs
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:11:37 -0500
Received: by mail-wj0-x229.google.com with SMTP id uo9so849392wjc.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 05:11:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 13:11:15 +0000
Message-ID: <CAFEAcA9Bd28scVOuNWZkjEX6RuptA2_hYeR2otmwCQ+UnnoeEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] xen-20170202
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

On 2 February 2017 at 18:35, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit 3aca12f841fcd6f3a7477076dad0d564360500de:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170127' into staging (2017-01-27 16:59:17 +0000)
>
> are available in the git repository at:
>
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170202
>
> for you to fetch changes up to e9dcbc86d614018923e26e31319b0a54c9e5abac:
>
>   xen: use qdev_unplug() instead of g_free() in xen_pv_find_xendev() (2017-02-02 10:23:53 -0800)
>
> ----------------------------------------------------------------
> Xen 2017/02/02
>
> ----------------------------------------------------------------
> Anthony PERARD (1):
>       MAINTAINERS: Update xen-devel mailing list address
>
> Juergen Gross (1):
>       xen: use qdev_unplug() instead of g_free() in xen_pv_find_xendev()
>
> Paul Durrant (3):
>       xen-platform: re-structure unplug_disks
>       xen-platform: add support for unplugging NVMe disks...
>       xen-platform: add missing disk unplug option

Applied, thanks.

-- PMM
