Received: from eggs.gnu.org ([2001:4830:134:3::10]:46971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLuSL-0001ve-Ep
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 11:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLuSK-0005wP-Md
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 11:18:29 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:35413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cLuSK-0005wJ-EJ
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 11:18:28 -0500
Received: by mail-vk0-x22a.google.com with SMTP id y197so62856991vky.2
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 08:18:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161224034637.12207-1-rth@twiddle.net>
References: <20161224034637.12207-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 16:18:07 +0000
Message-ID: <CAFEAcA8xRsHgb=A9aWL6xz4xePnS_aRgpTm=0UmpAzmuK7hAyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg/s390 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 December 2016 at 03:46, Richard Henderson <rth@twiddle.net> wrote:
> One bug fix, one cleanup.
>
>
> r~
>
>
>
> The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20161223
>
> for you to fetch changes up to e45d4ef6e345831c8d67a5bffe0d057efc20f4ff:
>
>   tcg/s390: Remove 'R' constraint (2016-12-23 19:38:27 -0800)
>
> ----------------------------------------------------------------
> queued s390 host fixes
>
> ----------------------------------------------------------------
> Richard Henderson (2):
>       tcg/s390: Fix setcond expansion
>       tcg/s390: Remove 'R' constraint
>
>  tcg/s390/tcg-target.inc.c | 75 +++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 35 deletions(-)

Applied, thanks.

-- PMM
