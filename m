Received: from eggs.gnu.org ([2001:4830:134:3::10]:47730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKhSi-0001q1-0F
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKhSg-0007QQ-47
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:50:39 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:38057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fKhSf-0007Py-V8
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:50:38 -0400
Received: by mail-oi0-x22f.google.com with SMTP id k17-v6so12478663oih.5
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 02:50:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 10:50:16 +0100
Message-ID: <CAFEAcA_vNgR36OKur2Fu2dCFVm+uNX2bLVx3bxoqygRkV=BFZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Honor CPU_DUMP_FPU
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

On 18 May 2018 at 22:57, Richard Henderson <richard.henderson@linaro.org> wrote:
> With Peter's new patch for "-d fpu", it makes sense to honor
> this setting in as many targets as currently dump the fpu.
>
>
> r~
>
>
> The following changes since commit 5bcf917ee37a5efbef99f091a96db54a5276becb:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180518' into staging (2018-05-18 18:25:29 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-fpu-20180518
>
> for you to fetch changes up to f29c0b170fa9e0568f2d02e764e18b00cad3a27f:
>
>   target/xtensa: Honor CPU_DUMP_FPU (2018-05-18 14:52:38 -0700)
>
> ----------------------------------------------------------------
> Honor CPU_DUMP_FPU

Applied, thanks.

-- PMM
