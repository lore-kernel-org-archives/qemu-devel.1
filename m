Received: from eggs.gnu.org ([209.51.188.92]:51798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpESM-00060T-Np
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpESL-0000UN-QO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:40:46 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:40059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpESL-0000RT-IG
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:40:45 -0500
Received: by mail-oi1-x236.google.com with SMTP id t204so3066946oie.7
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 07:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20190130073426.11525-1-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 15:40:21 +0000
Message-ID: <CAFEAcA_LRtD4=-sJiLARPeBQg8Y2m21bshZOdEXTy8QkOe0kjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Usb 20190130 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 30 Jan 2019 at 07:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit b4fbe1f65a4769c09e6bf2d79fc84360f840f40e:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190129' into staging (2019-01-29 12:00:19 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190130-pull-request
>
> for you to fetch changes up to 49f9e8d660d41cbe325d554e742d7100d59a7abf:
>
>   usb-mtp: replace the homebrew write with qemu_write_full (2019-01-30 06:47:52 +0100)
>
> ----------------------------------------------------------------
> usb: xhci: fix iso transfers.
> usb: mtp: break up writes, bugfixes.
> usb: fix lgpl info in headers.
> usb: hid: unique serials.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
