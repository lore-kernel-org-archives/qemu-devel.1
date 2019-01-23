Received: from eggs.gnu.org ([209.51.188.92]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmQPq-0004VD-7g
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmQPn-0005er-8e
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:50:34 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:37760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmQPn-0005Os-0P
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:50:31 -0500
Received: by mail-oi1-x229.google.com with SMTP id y23so3156554oia.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20190121141152.948-1-kraxel@redhat.com>
In-Reply-To: <20190121141152.948-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jan 2019 21:50:08 +0000
Message-ID: <CAFEAcA9O=pDeT+cC=61NNGUXpWO0G52_HQ8ej4QNt8wxEqR4cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Ui 20190121 patches
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

On Mon, 21 Jan 2019 at 14:15, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190121-pull-request
>
> for you to fetch changes up to fbd57c754f32804a63295f70f271d1ef128ee590:
>
>   egl-helpers.h: do not depend on X11 Window type, use EGLNativeWindowType (2019-01-21 09:44:32 +0100)
>
> ----------------------------------------------------------------
> ui: highres logo for sdl and gtk, bugfixes for vnc and egl.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
