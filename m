Received: from eggs.gnu.org ([2001:4830:134:3::10]:49210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjNny-0007jf-I3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjNnx-0002h1-EO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:17:50 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjNnx-0002gf-8p
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:17:49 -0500
Received: by mail-wr0-x235.google.com with SMTP id l37so48504775wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 02:17:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228213324.23510-1-rth@twiddle.net>
References: <20170228213324.23510-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 10:17:27 +0000
Message-ID: <CAFEAcA-DgTmxMaReEyTd06pZv1oadUToAT-j6_DbwTosa_j8KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] TCG queued patch
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

On 28 February 2017 at 21:33, Richard Henderson <rth@twiddle.net> wrote:
> Only one this week.  Pranith didn't mention which compiler version,
> but I can imagine gcc7 or clang warning of such a thing.
>
>
> r~
>
>
> The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:
>
>   vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170301
>
> for you to fetch changes up to dc1eccd661ada3b746ca4438e444993c36a0f04f:
>
>   aarch64: Change ext type to TCGType to fix warnings (2017-03-01 08:28:06 +1100)
>
> ----------------------------------------------------------------
> Queued TCG patch
>
> ----------------------------------------------------------------
> Pranith Kumar (1):
>       aarch64: Change ext type to TCGType to fix warnings
>
>  tcg/aarch64/tcg-target.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
