Received: from eggs.gnu.org ([2001:4830:134:3::10]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gB0Ec-0004GC-Da
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gB0Eb-0006QQ-LN
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:24:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:32898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gB0Ea-0006OQ-I2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:24:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id a203-v6so10316362oib.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 09:24:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181012132135.12313-1-kraxel@redhat.com>
References: <20181012132135.12313-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 17:23:55 +0100
Message-ID: <CAFEAcA8uyabYPENmK0AWKcwxr_B1mR9Uid26PkZDG3sFDUL+Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20181012 patches
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

On 12 October 2018 at 14:21, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a5b:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10' into staging (2018-10-11 10:43:37 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20181012-pull-request
>
> for you to fetch changes up to 1d454c3fee00d9d1e46e1ec6788d49da5a0bfdb0:
>
>   gtk: fix uninitialized variable (2018-10-12 14:49:03 +0200)
>
> ----------------------------------------------------------------
> ui: gtk fixes, support more formats in sdl2.
>
> ----------------------------------------------------------------
>
> Kevin Wolf (1):
>   gtk: Don't vte_terminal_set_encoding() on new VTE versions
>
> Max Reitz (1):
>   sdl2: Support all virtio-gpu formats
>
> Paolo Bonzini (1):
>   gtk: fix uninitialized variable
>
>  ui/gtk.c     |  8 +++++---
>  ui/sdl2-2d.c | 15 +++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> --
> 2.9.3

Applied, thanks.

-- PMM
