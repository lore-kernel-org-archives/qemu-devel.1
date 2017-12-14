Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePUOo-0005pX-PQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePUOo-0001F2-1x
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:22:10 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:37394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePUOn-0001EY-RZ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:22:09 -0500
Received: by mail-ot0-x230.google.com with SMTP id s4so5041626ote.4
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 06:22:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171213180541.10386.38737.stgit@gimli.home>
References: <20171213180541.10386.38737.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2017 14:21:48 +0000
Message-ID: <CAFEAcA-Pt7NqzXr4YsavAwvSdvA-nYFKterbKWRXsz+yMaCUHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] VFIO updates for v2.12
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

On 13 December 2017 at 18:08, Alex Williamson
<alex.williamson@redhat.com> wrote:
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
>
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20171213.0
>
> for you to fetch changes up to 2fb9636ebf24e695617bf407bf0a345aa223d1ac:
>
>   vfio-pci: Remove unused fields from VFIOMSIXInfo (2017-12-13 10:19:34 -0700)
>
> ----------------------------------------------------------------
> VFIO updates for v2.12
>
>  - Fix bug failing to register all but the first group attached to
>    a container with kvm-vfio device (Alex Williamson)
>
>  - Explicit QLIST init (Yi Lui)
>
>  - SPAPR IOMMU v1 fallback (Alexey Kardashevskiy)
>
>  - Remove unused structure fields (Alexey Kardashevskiy)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
