Received: from eggs.gnu.org ([2001:4830:134:3::10]:60075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLWmR-0006fa-FR
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLWmQ-0002qJ-PP
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:33:55 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:32964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLWmQ-0002q0-HN
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:33:54 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so24588974wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 08:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170613202659.1920-1-rth@twiddle.net>
References: <20170613202659.1920-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 16:33:32 +0100
Message-ID: <CAFEAcA8f4zicyThvnEeZkqLDzwFMGPNmQvYNDGffSS3WGNEwwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Queued s390x tcg patches
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

On 13 June 2017 at 21:26, Richard Henderson <rth@twiddle.net> wrote:
> Cleanups and fixes from David Hildenbrand.
>
>
> r~
>
>
>
> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-s390-20170613
>
> for you to fetch changes up to 076d4d39b65f50ca1bba3d3c8a8f1cf977c1c3f0:
>
>   s390x/cpumodel: wire up cpu type + id for TCG (2017-06-13 11:09:39 -0700)
>
> ----------------------------------------------------------------
> Queued s390 patches
>
> ----------------------------------------------------------------
> David Hildenbrand (3):
>       target/s390x: correctly indicate PER nullification
>       target/s390x: rework PGM interrupt psw.addr handling
>       s390x/cpumodel: wire up cpu type + id for TCG

Applied, thanks.

-- PMM
