Received: from eggs.gnu.org ([209.51.188.92]:35143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxCHQ-0000cY-Td
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxCCE-0002Ur-5Z
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:53:03 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:38826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxCCD-0001kf-QT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:53:02 -0500
Received: by mail-oi1-x232.google.com with SMTP id q81so1895939oic.5
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20190221190426.22810-1-richard.henderson@linaro.org>
In-Reply-To: <20190221190426.22810-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 14:52:14 +0000
Message-ID: <CAFEAcA-sON=gEAo2ZKwBvWD6gzRyXDiX2d_fL98Aaz3J95O-1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 21 Feb 2019 at 19:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190221
>
> for you to fetch changes up to 368bec88d1916f65050be305f88c10a46075a51c:
>
>   hw/hppa/dino: mask out lower 2 bits of PCI config addr (2019-02-21 10:16:19 -0800)
>
> ----------------------------------------------------------------
> Fix dino pci config access.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
