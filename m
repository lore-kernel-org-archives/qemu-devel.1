Received: from eggs.gnu.org ([2001:4830:134:3::10]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4QK-0003nx-4I
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4QJ-0002Xk-6d
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:54:48 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez4QJ-0002XY-1V
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:54:47 -0400
Received: by mail-ot0-x243.google.com with SMTP id 108-v6so10413948otv.3
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 10:54:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180321144107.22770-1-kwolf@redhat.com>
References: <20180321144107.22770-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 17:54:25 +0000
Message-ID: <CAFEAcA9mCHnUCA93E4cgZazm5k4BbZbixhTTA5B9cPhjKwRjgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Multiboot patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2018 at 14:41, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f135:
>
>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to e2679395d598bd40770c22a793c0152576ac211f:
>
>   tests/multiboot: Add .gitignore (2018-03-21 15:13:40 +0100)
>
> ----------------------------------------------------------------
> Multiboot patches
>
> ----------------------------------------------------------------
> Kevin Wolf (5):
>       multiboot: Reject kernels exceeding the address space
>       multiboot: Check validity of mh_header_addr
>       tests/multiboot: Test exit code for every qemu run
>       tests/multiboot: Add tests for the a.out kludge
>       tests/multiboot: Add .gitignore

Applied, thanks.

-- PMM
