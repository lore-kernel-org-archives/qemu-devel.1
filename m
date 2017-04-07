Received: from eggs.gnu.org ([2001:4830:134:3::10]:45733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwQvy-0006YT-IT
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwQvx-00049d-JG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:16:02 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cwQvx-00048g-CL
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:16:01 -0400
Received: by mail-wr0-x232.google.com with SMTP id c55so26945497wrc.3
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 03:16:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170406220934.6155.13106.stgit@gimli.home>
References: <20170406220934.6155.13106.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Apr 2017 11:15:39 +0100
Message-ID: <CAFEAcA-+_VL49nyT-hzPkoW_PTVmYaCN3Es-VAhgRzCNrwj1kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] VFIO fixes 2017-04-06
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

On 6 April 2017 at 23:11, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 54d689988c847271d87b3eb113712147129fb811:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into
> staging (2017-04-06 09:27:49 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170406.0
>
> for you to fetch changes up to 8f419c5b43b988df4ef11315aeb8524e50c99687:
>
>   vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk (2017-04-06
> 16:03:26 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2017-04-06
>
>  - Extra test for NVIDIA BAR5 quirk to avoid segfault (Alex Williamson)
>
> ----------------------------------------------------------------
> Alex Williamson (1):
>       vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk
>
>  hw/vfio/pci-quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- PMM
