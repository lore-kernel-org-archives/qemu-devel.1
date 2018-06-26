Received: from eggs.gnu.org ([2001:4830:134:3::10]:47254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqyi-0007WW-Gk
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqyh-0004gO-RO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:38:04 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:43237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXqyh-0004fx-MZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:38:03 -0400
Received: by mail-oi0-x231.google.com with SMTP id x18-v6so7216952oie.10
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:38:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180626135625.7078-1-kraxel@redhat.com>
References: <20180626135625.7078-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:37:42 +0100
Message-ID: <CAFEAcA8RXgejiDm5iZ8p4cRhO02zcZa6SZ2+XkdbTsNBHKkvJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20180626 patches
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

On 26 June 2018 at 14:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 595123df1d54ed8fbab9e1a73d5a58c5bb71058f:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2018-06-26 09:45:14 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180626-pull-request
>
> for you to fetch changes up to 49213b721f4620364aa09142b5f4d559fed26b53:
>
>   sdl2: add checking for NULL (2018-06-26 13:48:49 +0200)
>
> ----------------------------------------------------------------
> ui: sdl2 fixes, gles support.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   Add gles support to egl-helpers, wire up in egl-headless and gtk.
>
> Pavel Dovgalyuk (2):
>   sdl2: fix copypaste issues
>   sdl2: add checking for NULL
>
Applied, thanks.

-- PMM
