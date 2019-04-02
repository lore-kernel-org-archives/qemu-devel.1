Received: from eggs.gnu.org ([209.51.188.92]:49921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBF0C-0002wR-FE
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBErA-0000LM-Kj
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:33:21 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:34519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBErA-0000Kp-Dx
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:33:20 -0400
Received: by mail-oi1-x22b.google.com with SMTP id v10so9775303oib.1
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 01:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190402064639.27108-1-kraxel@redhat.com>
In-Reply-To: <20190402064639.27108-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 08:33:07 +0000
Message-ID: <CAFEAcA8oVLGaYX546FpTrrUdhwyrkdgrGUJr2eF6tRhsEvFz-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Fixes 20190402 patches
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

On Tue, 2 Apr 2019 at 14:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 230ce19814ecc6bff8edac3b5b86e7c82f422c6c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190325' into staging (2019-03-29 19:29:00 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20190402-pull-request
>
> for you to fetch changes up to be1092afa07794e5247eb504095fb5f2ae421ec6:
>
>   audio: fix audio timer rate conversion bug (2019-04-02 07:50:49 +0200)
>
> ----------------------------------------------------------------
> fixes for 4.0 (audio, usb),
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
