Received: from eggs.gnu.org ([2001:4830:134:3::10]:57518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Qff-00083n-PE
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Qff-0007JB-1U
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:40:47 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4Qfe-0007IL-I5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:40:46 -0400
Received: by mail-ot0-x243.google.com with SMTP id m22-v6so998737otf.10
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 05:40:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152295356408.13263.6740252773525355794.stgit@w520.home>
References: <152295356408.13263.6740252773525355794.stgit@w520.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 13:40:25 +0100
Message-ID: <CAFEAcA-M0aTHpbFV2iVraEboOJfwvVZBbZmzA8DrSg-iqOSGjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/1] vfio fix
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

On 5 April 2018 at 19:41, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:
>
>   Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20180405.0
>
> for you to fetch changes up to 5c08600547c059e3fd072995f9f367cdaf3c7d9d:
>
>   vfio: Use a trace point when a RAM section cannot be DMA mapped (2018-04-05 10:48:52 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2018-04-05
>
>  - Convert over zealous error_report to trace point and make more
>    meaningful (Eric Auger)
>
> ----------------------------------------------------------------
> Eric Auger (1):
>       vfio: Use a trace point when a RAM section cannot be DMA mapped
>
>  hw/vfio/common.c     | 11 +++++------
>  hw/vfio/trace-events |  1 +
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
