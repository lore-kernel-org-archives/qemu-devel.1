Received: from eggs.gnu.org ([2001:4830:134:3::10]:34784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIAI4-00078q-BK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIAI3-0005iV-Lk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:56:40 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIAI3-0005hi-F7
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:56:39 -0400
Received: by mail-wm0-x231.google.com with SMTP id x70so32135834wme.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 01:56:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170605165233.4135-1-rth@twiddle.net>
References: <20170605165233.4135-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 09:56:17 +0100
Message-ID: <CAFEAcA_qJgi2-Q30N5f=4TbBL9q8L9KOYAbTK-Vgd1L-v4imMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 June 2017 at 17:52, Richard Henderson <rth@twiddle.net> wrote:
> This contains several patches to fix compilation on ilp32 abis on
> 64-bit hosts, such as sparcv8plus and x32.  It also contains the
> goto_ptr feature proposed by Emilio Cota.
>
>
> r~
>
>
> The following changes since commit 199e19ee538eb61fd08b1c1ee5aa838ebdcc968e:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-06-05 15:28:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170605
>
> for you to fetch changes up to 2d826cdc8a43ba1817a44f481f8dc8f08668b0a6:
>
>   target/alpha: Use goto_tb for fallthru between TBs (2017-06-05 09:25:42 -0700)


Applied, thanks.

-- PMM
