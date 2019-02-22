Received: from eggs.gnu.org ([209.51.188.92]:57841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxBGP-0002xk-Tw
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxBGO-00017x-NW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:53:17 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxBGL-0000q4-By
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:53:16 -0500
Received: by mail-oi1-x244.google.com with SMTP id g16so1761107oib.1
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20190221190229.22599-1-richard.henderson@linaro.org>
In-Reply-To: <20190221190229.22599-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 13:53:00 +0000
Message-ID: <CAFEAcA_9+wQA+Ud4ZizCsVmO58gnjda1gUqLj+mMusUhdw9joQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] tcg patch queue
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

On Thu, 21 Feb 2019 at 19:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190221
>
> for you to fetch changes up to 8c6edfdd90522caa4fc429144d393aba5b99f584:
>
>   include/exec/helper-head.h: support "const void *" in helper calls (2019-02-21 10:22:24 -0800)
>
> ----------------------------------------------------------------
> Allow const void * as argument to helpers.
> Remove obsolete TODO file.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
