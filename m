Received: from eggs.gnu.org ([2001:4830:134:3::10]:44338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fI9Fw-0000zV-Sq
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fI9Fv-0005Yb-UF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:54:56 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:39208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fI9Fv-0005Xy-P8
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:54:55 -0400
Received: by mail-ot0-x22c.google.com with SMTP id l12-v6so13370812oth.6
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 01:54:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511042324.5070-1-richard.henderson@linaro.org>
References: <20180511042324.5070-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 09:54:34 +0100
Message-ID: <CAFEAcA9qU=BWiSvd697gy6MyFbWnE6j=iQbB_zfgyLGPXujFXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] openrisc: Covert to decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

On 11 May 2018 at 05:23, Richard Henderson <richard.henderson@linaro.org> wrote:
> Stafford Horne has acked and asked that I send the pull-request.
>
>
> r~
>
>
> The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/tgt-openrisc-pull-request
>
> for you to fetch changes up to cf88ad60531a5b06834f6bf373a5f7fa91f2c3a8:
>
>   target/openrisc: Merge disas_openrisc_insn (2018-05-10 21:19:13 -0700)
>
> ----------------------------------------------------------------
> Convert OpenRISC to decodetree.py

Hi -- I get a bunch of merge conflicts in target/openrisc/translate.c
trying to apply this. Can you rebase and resend, please?

thanks
-- PMM
