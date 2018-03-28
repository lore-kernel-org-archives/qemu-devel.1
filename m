Received: from eggs.gnu.org ([2001:4830:134:3::10]:57612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f1D8L-0006Uj-3u
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f1D8K-0000hu-5q
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:37:05 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:43693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f1D8K-0000hV-0F
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:37:04 -0400
Received: by mail-ot0-x231.google.com with SMTP id m22-v6so3096161otf.10
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 08:37:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180328045140.16462-1-richard.henderson@linaro.org>
References: <20180328045140.16462-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Mar 2018 16:36:42 +0100
Message-ID: <CAFEAcA_dv48QodNL_sER-S3yKi3xAoVMg1gYp-9vU1r6+dw1OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/1] tcg mul[us]h fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 28 March 2018 at 05:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This is material for stable as well.
>
>
> r~
>
>
> The following changes since commit fa3704d87720d7049d483ff669b9e2ff991e7658:
>
>   Update version for v2.12.0-rc1 release (2018-03-27 22:04:23 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20180328
>
> for you to fetch changes up to f2f1dde75160cac6ede330f3db50dc817d01a2d6:
>
>   tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops (2018-03-28 12:45:16 +0800)
>
> ----------------------------------------------------------------
> Fix muluh_i64 and mulsh_i64 flags
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops

Applied, thanks.

-- PMM
