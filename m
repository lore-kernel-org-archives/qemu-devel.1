Received: from eggs.gnu.org ([209.51.188.92]:52796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBts-0005nK-Qo
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBtr-0008Qx-PU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:44:52 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:45203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBtr-0008DV-GE
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:44:51 -0500
Received: by mail-ot1-x336.google.com with SMTP id 32so15522181ota.12
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20190128155907.20607-1-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:44:19 +0000
Message-ID: <CAFEAcA9x4GOMzojb=3au6UyLWWhN_1Em8A0KsxQ7w6WHV=oG4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/23] tcg queued patches
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

On Mon, 28 Jan 2019 at 15:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit ad7a21e81231ae64540310384fb0f87ac8758b02:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-01-25 17:22:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190128
>
> for you to fetch changes up to e77c89fb086a9bf09dd11f72e4cb2093b426f32b:
>
>   cputlb: Remove static tlb sizing (2019-01-28 07:04:35 -0800)
>
> ----------------------------------------------------------------
> Backend vector enhancements
> Dynamic tlb resizing
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
