Received: from eggs.gnu.org ([2001:4830:134:3::10]:34450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eED74-0000qV-FA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eED73-0004pz-OM
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:41:14 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:50629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eED73-0004pU-Hk
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:41:13 -0500
Received: by mail-wr0-x233.google.com with SMTP id p96so14124029wrb.7
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 03:41:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109075243.4794-1-richard.henderson@linaro.org>
References: <20171109075243.4794-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 11:40:51 +0000
Message-ID: <CAFEAcA9GkTMvvpzYDhPTZH_PS+fsXUZpmrDqFmQRNpJfMrV+Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/2] Capstone updates
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

On 9 November 2017 at 07:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> One build fix for mingw cross-compiling, one feature regression fix.
>
>
> r~
>
>
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-cap-20171109
>
> for you to fetch changes up to 9f81aeb5dadab588920b157a4610e890995ef4b9:
>
>   Makefile: Capstone: Add support for cross compile ranlib (2017-11-09 08:47:14 +0100)
>
> ----------------------------------------------------------------
> Capstone fixes for 2.11
>
> ----------------------------------------------------------------
> Alistair Francis (1):
>       Makefile: Capstone: Add support for cross compile ranlib
>
> Richard Henderson (1):
>       disas: Dump insn bytes along with capstone disassembly
>

Applied, thanks.

-- PMM
