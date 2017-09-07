Received: from eggs.gnu.org ([2001:4830:134:3::10]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpxki-0005nO-Md
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpxke-0001PK-3a
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:25:56 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpxkd-0001Oe-SA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:25:52 -0400
Received: by mail-wr0-x22c.google.com with SMTP id k20so10955303wre.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 07:25:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 15:25:30 +0100
Message-ID: <CAFEAcA8H1J9d-VUGA051Xv=6DvriUgd=ytKF8jGL-cxieFUFuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/32] tcg generic translate loop
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

On 6 September 2017 at 17:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This is v15 of the patch set, reviewed mostly by Emilio and Alex.
> I have converions for additional targets, but this is large enough.
>
>
> r~
>
>
> The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:
>
>   Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tgt-20170906
>
> for you to fetch changes up to d0264d86b026e9d948de577b05ff86d708658576:
>
>   target/arm: Perform per-insn cross-page check only for Thumb (2017-09-06 08:06:48 -0700)
>
> ----------------------------------------------------------------
> tcg generic translate loop v15
>

Applied, thanks.

-- PMM
