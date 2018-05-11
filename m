Received: from eggs.gnu.org ([2001:4830:134:3::10]:60873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH9Es-0005R0-18
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH9Er-0007H4-4b
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:42 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH9Eq-0007Gr-Uw
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:41 -0400
Received: by mail-oi0-x243.google.com with SMTP id a6-v6so4917499oia.2
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 07:41:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509154849.27979-1-richard.henderson@linaro.org>
References: <20180509154849.27979-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 15:41:19 +0100
Message-ID: <CAFEAcA-UPx=C1eiBaH-5oHMD2DBmpCjQDz9V8Cne+CQO-uB=Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] tcg-next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 9 May 2018 at 16:48, Richard Henderson <richard.henderson@linaro.org> wrote:
> The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/tcg-next-pull-request
>
> for you to fetch changes up to abebf92597186be2bc48d487235da28b1127860f:
>
>   tcg: Limit the number of ops in a TB (2018-05-09 08:30:57 -0700)
>
> ----------------------------------------------------------------
> Queued TCG patches
>
> ----------------------------------------------------------------
>
> Peter Maydell (1):
>   tcg/i386: Fix dup_vec in non-AVX2 codepath
>
> Richard Henderson (1):
>   tcg: Limit the number of ops in a TB
>
>  tcg/tcg.h                 | 8 +++++++-
>  tcg/i386/tcg-target.inc.c | 6 +++---
>  tcg/tcg.c                 | 3 +++
>  3 files changed, 13 insertions(+), 4 deletions(-)
>

Applied, thanks.

-- PMM
