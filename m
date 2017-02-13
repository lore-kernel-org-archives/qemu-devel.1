Received: from eggs.gnu.org ([2001:4830:134:3::10]:55208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdDgE-0006DG-0R
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdDgD-0000Z7-0S
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:16:22 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdDgC-0000Yt-PA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:16:20 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v186so154019219wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 02:16:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170210214127.22071.16525.stgit@gimli.home>
References: <20170210214127.22071.16525.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Feb 2017 10:15:59 +0000
Message-ID: <CAFEAcA-Fe3JggJdgzV=FGky45mzv81JakSkLYs+Yvn1j-j4S6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] VFIO updates 2017-02-10
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

On 10 February 2017 at 21:42, Alex Williamson
<alex.williamson@redhat.com> wrote:
> The following changes since commit 98b2faeaee96ab084d0b1669918688d8895c155f:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into
> staging (2017-02-10 18:07:02 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170210.0
>
> for you to fetch changes up to e197de50c6cfad69d2c26c22693b57678ae99d14:
>
>   hw/vfio: Add CONFIG switches for calxeda-xgmac and amd-xgbe (2017-02-10
> 13:12:03 -0700)
>
> ----------------------------------------------------------------
> VFIO updates 2017-02-10
>
>  - Fix GTT wrap-around for Skylake IGD assignment (Alex Williamson)
>  - Tag vfio-pci-igd-lpc-bridge as bridge device category (Thomas Huth)
>  - Don't build calxeda-xgmac or amd-xgbe except on ARM (Thomas Huth)
>
> ----------------------------------------------------------------
> Alex Williamson (1):
>       vfio-pci: Fix GTT wrap-around for Skylake+ IGD
>
> Thomas Huth (2):
>       hw/vfio/pci-quirks: Set category of the "vfio-pci-igd-lpc-bridge" device
>       hw/vfio: Add CONFIG switches for calxeda-xgmac and amd-xgbe

Applied, thanks.

-- PMM
