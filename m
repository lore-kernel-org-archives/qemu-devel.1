Received: from eggs.gnu.org ([2001:4830:134:3::10]:35945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db9V0-00057g-K2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db9Uz-0008A8-NU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:56:30 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db9Uz-00089h-Gq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:56:29 -0400
Received: by mail-wm0-x22e.google.com with SMTP id m85so28196282wma.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:56:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501247265-22367-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501247265-22367-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 18:56:07 +0100
Message-ID: <CAFEAcA92dPp9LFEU3PS_W61XV4=YBOagMMfz93F5WtC3js4+ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 July 2017 at 14:07, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> The following changes since commit 871a0f7ad2b9560c5f7d640125c5be95ca23ca7f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170728' into staging (2017-07-28 10:35:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170728
>
> for you to fetch changes up to 665df9010aa40d1e028d6ad5d3bdb4d9b0a3294c:
>
>   Revert "elf-loader: warn about invalid endianness" (2017-07-28 13:32:32 +0100)
>
> ----------------------------------------------------------------
> MIPS patches 2017-07-28
>
> Changes:
> * Improve ths MIPS board kernel load error reporting
> * Revert unnecessary warning messages
>
> ----------------------------------------------------------------
>
> Alexey Kardashevskiy (1):
>   Revert "elf-loader: warn about invalid endianness"
>
> Aurelien Jarno (1):
>   hw/mips: load_elf_strerror to report kernel loading failure
>

Applied, thanks.

-- PMM
