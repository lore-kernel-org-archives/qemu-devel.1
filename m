Received: from eggs.gnu.org ([2001:4830:134:3::10]:48255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e800I-0005K6-F9
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e800H-00010O-K7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:28:34 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:48900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e800H-0000yP-D4
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:28:33 -0400
Received: by mail-wm0-x22a.google.com with SMTP id p75so1967063wmg.3
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 01:28:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171026100031.19042-1-richard.henderson@linaro.org>
References: <20171026100031.19042-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2017 09:28:11 +0100
Message-ID: <CAFEAcA_zsBfy=VcMJ0kLOCqL=yTbm6yQWrMbS+0e1DR4mnBERQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/11] Disassembler patches
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

On 26 October 2017 at 11:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Support for Capstone, plus an arm32 fix.
>
> Changes since v1:
>   * Fixed mingw32 build in patch 11/11.
>     (Not re-sending patches 01-10.)
>
> r~
>
>
> The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-dis-20171026
>
> for you to fetch changes up to e219c499e9f5d4fa0e25dc07682f75531ee84d86:
>
>   disas: Add capstone as submodule (2017-10-26 11:56:20 +0200)
>
> ----------------------------------------------------------------
> Capstone disassembler
>

Applied, thanks.

-- PMM
