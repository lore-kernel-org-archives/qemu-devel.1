Received: from eggs.gnu.org ([2001:4830:134:3::10]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqHuP-00084N-7h
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqHuO-0007f5-Fd
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:57:17 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqHuO-0007eR-82
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:57:16 -0400
Received: by mail-wr0-x22c.google.com with SMTP id a43so4301496wrc.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 04:57:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 12:56:54 +0100
Message-ID: <CAFEAcA9fOn95b1GKt9r0nAMVa-pUJN8U3mD40_73yp3T4EM0JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/23] tcg constant pools and
 USE_DIRECT_JUMP cleanup
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

On 7 September 2017 at 23:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Lots of cleanup for aarch32 and s390x.  Minor improvements for
> aarch64, ppc, sparc, x86_64.  But we'll need this more when we
> start generating host vector insns.
>
>
> r~
>
>
> The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:
>
>   tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170907
>
> for you to fetch changes up to 53c89efd02cef626040165cc8f06b5cf2c15355d:
>
>   tcg/ppc: Use constant pool for movi (2017-09-07 11:57:35 -0700)
>
> ----------------------------------------------------------------
> TCG constant pools
>

Applied, thanks.

-- PMM
