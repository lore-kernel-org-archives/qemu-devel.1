Received: from eggs.gnu.org ([2001:4830:134:3::10]:60536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXVlw-0008Gf-KR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXVlv-0004fI-PC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:54:56 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXVlv-0004f2-Ia
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:54:55 -0400
Received: by mail-wr0-x22a.google.com with SMTP id w4so36664524wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 09:54:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717203658.15922.21967.stgit@gimli.home>
References: <20170717203658.15922.21967.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 17:54:33 +0100
Message-ID: <CAFEAcA9e6efAotHsiFuHED5c1NApLNSy2gYr1OAaMbT05Sxmmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] VFIO fixes 2017-07-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 21:39, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request'
> into staging (2017-07-17 17:54:17 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170717.0
>
> for you to fetch changes up to 8c37faa475f35d158622422788fe8e5aef3118e1:
>
>   vfio-pci, ppc64/spapr: Reorder group-to-container attaching (2017-07-17
> 12:39:09 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2017-07-17
>
>  - Init re-order to better support hot-add on SPAR (Alexey Kardashevskiy)
>
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       vfio-pci, ppc64/spapr: Reorder group-to-container attaching
>
>  hw/vfio/common.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Applied, thanks.

-- PMM
