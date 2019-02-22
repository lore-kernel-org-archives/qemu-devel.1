Received: from eggs.gnu.org ([209.51.188.92]:46063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxEge-0005gA-BU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxEgd-00023Q-E9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:32:36 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxEgc-00014S-5j
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:32:35 -0500
Received: by mail-ot1-x32e.google.com with SMTP id n71so2495181ota.10
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 09:31:52 -0800 (PST)
MIME-Version: 1.0
References: <155081340903.23160.4034617687275790161.stgit@gimli.home>
In-Reply-To: <155081340903.23160.4034617687275790161.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 17:31:40 +0000
Message-ID: <CAFEAcA_UZOU7=ozOFrraEMuNrNLhnH17oz+MH30x0uaQ=3eKkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] vfio updates 2019-02-21
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

On Fri, 22 Feb 2019 at 05:35, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20190221.0
>
> for you to fetch changes up to 2b6326c0bf2c686ae83d6904899cb80e9ad7a6fb:
>
>   hw/vfio/common: Refactor container initialization (2019-02-21 21:07:03 -0700)
>
> ----------------------------------------------------------------
> VFIO updates 2019-02-21
>
>  - Workaround kernel overflow bug in vfio type1 DMA unmap
>    (Alex Williamson)
>
>  - Refactor vfio container initialization (Eric Auger)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
