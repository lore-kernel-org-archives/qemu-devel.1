Received: from eggs.gnu.org ([2001:4830:134:3::10]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0mFK-0008Kv-1C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0mFJ-0002f6-Df
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:54:30 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0mFJ-0002eh-8Q
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:54:29 -0400
Received: by mail-ot0-x244.google.com with SMTP id v64-v6so2869168otb.13
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 03:54:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326144730.6351-1-richard.henderson@linaro.org>
References: <20180326144730.6351-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 11:54:08 +0100
Message-ID: <CAFEAcA9JdVDdko9jwLNvgCTqgVR89HqzCVoAVZCF3EC75XEwGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] decodetree: fix 16-bit insns
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

On 26 March 2018 at 15:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
> It's a bug, so logically 2.12 material.
> But no sense requiring risc-v to hold an extra local patch.
>
>
> r~
>
>
> The following changes since commit 2ffd221d07a671f72354a063d3080f244ec80b20:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-03-26 11:02:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-dt-20180326
>
> for you to fetch changes up to 83d7c40c92cdfb1cd2d5d31f4539b22dc17fbcce:
>
>   scripts/decodetree: Fix insnmask not marked as global in main() (2018-03-26 22:34:07 +0800)
>
> ----------------------------------------------------------------
> Fix a decodetree problem with 16-bit insns
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
