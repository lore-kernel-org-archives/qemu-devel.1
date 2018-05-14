Received: from eggs.gnu.org ([2001:4830:134:3::10]:51958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEb0-0006ZS-Ty
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEax-0002dg-0D
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:37:02 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:39570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEaw-0002dV-SU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:36:58 -0400
Received: by mail-ot0-x235.google.com with SMTP id l12-v6so14525504oth.6
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:36:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-20-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:36:37 +0100
Message-ID: <CAFEAcA_c_FAj5txSdTL9nL1dKfLTgAcddFgHnQUiAV2kFGfeUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 19/27] target/mips: Remove
 floatX_maybe_silence_nan from conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
> This is now handled properly by the generic softfloat code.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
