Received: from eggs.gnu.org ([2001:4830:134:3::10]:49607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek5H2-0004N3-In
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek5H1-0007YD-Qy
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:47:16 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ek5H1-0007Xb-KY
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:47:15 -0500
Received: by mail-oi0-x242.google.com with SMTP id b3so5687532oib.11
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 01:47:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208164909.8639-1-richard.henderson@linaro.org>
References: <20180208164909.8639-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2018 09:46:54 +0000
Message-ID: <CAFEAcA867Aq8py+hcYvhqpALdPQPO46VwduwHMET1Au_6tL=Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/20] tcg generic vectors
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

On 8 February 2018 at 16:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes since last:
>   * Fix the constant pool patch for ppc64 and sparc64 hosts.
>     That's a bit of a brown-bag moment.  I failed to test those
>     because "clearly" they weren't affected the patches.
>
>
> r~
>
>
> The following changes since commit b256b89c63c12e902645dd55e7b5362f60574742:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-02-08 10:16:59 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20180208
>
> for you to fetch changes up to 14e4c1e2355473ccb2939afc69ac8f25de103b92:
>
>   tcg/aarch64: Add vector operations (2018-02-08 15:54:08 +0000)
>
> ----------------------------------------------------------------
> tcg generic vectors
>

Applied, thanks.

-- PMM
