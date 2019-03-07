Received: from eggs.gnu.org ([209.51.188.92]:32973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1uqF-0007vO-98
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1uqE-0002Tn-Fe
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:21:51 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:40621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1uqE-0002Sz-98
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:21:50 -0500
Received: by mail-oi1-x233.google.com with SMTP id x187so13168831oia.7
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20190307095441.31921-1-kraxel@redhat.com>
In-Reply-To: <20190307095441.31921-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 15:21:37 +0000
Message-ID: <CAFEAcA8dP8PnpnQDwcX3Bkms87TvjZvchSY9pgzq8DaEkTjMUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Usb 20190307 patches
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

On Thu, 7 Mar 2019 at 09:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190307-pull-request
>
> for you to fetch changes up to ba4c735b4fc74e309ce4b2551d258e442ef513a5:
>
>   Introduce new "no_guest_reset" parameter for usb-host device (2019-03-07 10:03:54 +0100)
>
> ----------------------------------------------------------------
> usb: mtp fixes, guest-reset switch for usb-host.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
