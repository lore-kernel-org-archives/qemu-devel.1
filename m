Received: from eggs.gnu.org ([2001:4830:134:3::10]:37469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhbcz-00082X-HV
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhbcy-0003Wf-Mc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:15:57 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhbcy-0003VR-F8
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:15:56 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so1343244oie.13
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 07:15:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723125624.18863-1-laurent@vivier.eu>
References: <20180723125624.18863-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 15:15:35 +0100
Message-ID: <CAFEAcA85qfU9QdQCbysrWkqNgeLjjZbTZSpzrbUvsEeS4KoQig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Linux user for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 23 July 2018 at 13:56, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 5b3ecd3d941a0ae8a8cfbba5ab8139b2bf104822:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180719' into staging (2018-07-20 11:08:33 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request
>
> for you to fetch changes up to fa97e38eed3bbdbc322d94092ca49450e724fff1:
>
>   linux-user/ppc: Implement swapcontext syscall (2018-07-22 21:33:45 +0200)
>
> ----------------------------------------------------------------
> Some ppc/ppc64 fixes:
> - we can run now most of the targets on a ppc64 host with 64kB pages
> - add swapcontext syscall to run tests/test-coroutine in
>   debian-powerpc-user-cross
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
