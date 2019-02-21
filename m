Received: from eggs.gnu.org ([209.51.188.92]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwoB3-0007FV-Hp
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwo73-00011b-5j
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:10:06 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:34899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwo72-0000rS-VL
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:10:05 -0500
Received: by mail-ot1-x32e.google.com with SMTP id z19so44888187otm.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 05:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20190220111346.13669-1-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 13:09:22 +0000
Message-ID: <CAFEAcA_5YXDKRPS7nDoxW-fO9BNz1aw5hgbxi+m4_RdMghjE-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Usb 20190220 patches
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

On Wed, 20 Feb 2019 at 11:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e261b:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging (2019-02-18 16:20:13 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190220-pull-request
>
> for you to fetch changes up to 7011baece29d0e197c54c4e57326ba88e67a4949:
>
>   usb: remove unnecessary NULL device check from usb_ep_get() (2019-02-20 09:41:23 +0100)
>
> ----------------------------------------------------------------
> usb: usb_ep_get() fixes
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
