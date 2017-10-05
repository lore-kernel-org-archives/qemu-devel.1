Received: from eggs.gnu.org ([2001:4830:134:3::10]:49597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e06Qv-0005IE-PQ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e06Qu-0002TZ-VA
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:43:25 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e06Qu-0002TF-OO
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:43:24 -0400
Received: by mail-wr0-x22f.google.com with SMTP id y44so3176813wry.10
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 06:43:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171003221012.17156.23559.stgit@gimli.home>
References: <20171003221012.17156.23559.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 14:43:03 +0100
Message-ID: <CAFEAcA9Xxpv_t29Udd8NPxJQa5NCv7FDMeFJ6xH6XYreNikFmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] VFIO updates 2017-10-03
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

On 3 October 2017 at 23:12, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20171003.0
>
> for you to fetch changes up to dfbee78db8fdf7bc8c151c3d29504bb47438480b:
>
>   vfio/pci: Add NVIDIA GPUDirect Cliques support (2017-10-03 12:57:36 -0600)
>
> ----------------------------------------------------------------
> VFIO updates 2017-10-03
>
>  - NVIDIA GPUDirect Cliques experimental support (Alex Williamson)
>
> ----------------------------------------------------------------
> Alex Williamson (3):
>       vfio/pci: Do not unwind on error
>       vfio/pci: Add virtual capabilities quirk infrastructure
>       vfio/pci: Add NVIDIA GPUDirect Cliques support
>

Applied, thanks.

-- PMM
