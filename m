Received: from eggs.gnu.org ([2001:4830:134:3::10]:55604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3KMS-0000De-Kn
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3KMR-0001Us-Oq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:39:52 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3KMR-0001To-Hh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:39:51 -0400
Received: by mail-wr0-x236.google.com with SMTP id z52so81808998wrc.2
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 03:39:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1704251134220.2875@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704251134220.2875@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 11:39:29 +0100
Message-ID: <CAFEAcA86yt0gf_NWuoMbF_kWJ8FhcPFO3=wEzjADq0Pu+KULuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/21] Please pull xen-20170421-v2-tag for
 2.10
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

On 25 April 2017 at 19:34, Stefano Stabellini <sstabellini@kernel.org> wrote:
> Added a fix for the clang build, see
> alpine.DEB.2.10.1704251014320.2875@sstabellini-ThinkPad-X260
>
>
> The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:
>
>   Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)
>
> are available in the git repository at:
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170421-v2-tag
>
> for you to fetch changes up to 28b99f473bda682385da944b0404aedbe11ea0dc:
>
>   move xen-mapcache.c to hw/i386/xen/ (2017-04-25 11:04:34 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/04/21 + fix
>

Applied, thanks.

-- PMM
