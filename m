Received: from eggs.gnu.org ([2001:4830:134:3::10]:50796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e07jI-0004ST-5Y
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e07jC-0006Fo-3N
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:06:28 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:56967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e07jB-0006F0-SD
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:06:22 -0400
Received: by mail-wm0-x22f.google.com with SMTP id l68so2807814wmd.5
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:06:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005090443.26889-1-kraxel@redhat.com>
References: <20171005090443.26889-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 16:06:00 +0100
Message-ID: <CAFEAcA9OnGWK7OC1JhA7zgNBT+bMo-sq5_bquwiVK0-b=mJvNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Usb 20171005 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2017 at 10:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20171005-pull-request
>
> for you to fetch changes up to eea6ae20379dca837631d603c3bed03e5128189f:
>
>   usb: fix host-stub.c build race (2017-10-05 11:03:25 +0200)
>
> ----------------------------------------------------------------
> usb bugfixes.
>
> ----------------------------------------------------------------
>
> Fam Zheng (1):
>   usb: Use angle brackets for cacard include directive
>
> Gerd Hoffmann (2):
>   usb: fix libusb config variable name.
>   usb: fix host-stub.c build race
>
> Thomas Huth (1):
>   hw/usb/bus: Remove bad object_unparent() from usb_try_create_simple()
>
>  hw/usb/bus.c                | 4 +---
>  hw/usb/ccid-card-passthru.c | 2 +-
>  hw/usb/Makefile.objs        | 3 ++-
>  3 files changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

-- PMM
