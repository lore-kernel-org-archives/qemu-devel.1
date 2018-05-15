Received: from eggs.gnu.org ([2001:4830:134:3::10]:41913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXh6-0007Ys-Ny
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXh5-0006fP-Sc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:00:36 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:42564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIXh5-0006fA-N1
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:00:35 -0400
Received: by mail-oi0-x22f.google.com with SMTP id t27-v6so13541029oij.9
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 04:00:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514222714.7982-1-richard.henderson@linaro.org>
References: <20180514222714.7982-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 12:00:14 +0100
Message-ID: <CAFEAcA8KCL913zEopUVn0Vu5phuvkOiAX0ucnyDCw_oVrKMyRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/13] target/openrisc: Covert to
 decodetree.py
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

On 14 May 2018 at 23:27, Richard Henderson <richard.henderson@linaro.org> wrote:
> Rebased on master to resolve conflicts with Emilio Cota's
> TranslatorOps patch set.
>
>
> r~
>
>
> The following changes since commit bbd87423ea0c436c55bbc3f9c23d4f811d1f3f29:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-05-14 11:08:16 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/tgt-openrisc-pull-request
>
> for you to fetch changes up to c7b6f54bf8d6d0e847230998d09495c73eeac9aa:
>
>   target/openrisc: Merge disas_openrisc_insn (2018-05-14 14:58:08 -0700)
>
> ----------------------------------------------------------------
> Convert openrisc to decodetree.py
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
