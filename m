Received: from eggs.gnu.org ([2001:4830:134:3::10]:33698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH4hL-0005VB-RK
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH4hF-0002mc-U9
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:23:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH4hB-0002X5-2b
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:22:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id 14so7015155oth.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 03:22:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 10:22:29 +0000
Message-ID: <CAFEAcA_eLyuYydQAwCrcm_MPsHXR_K79GvfDCthdnfAwQOLZ_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2018 at 15:15, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 808ebd66e467f77c0d1f8c6346235f81e9c99cf2:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-sf0' into staging (2018-10-25 17:41:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/testing-pull-request
>
> for you to fetch changes up to 63a24c5e2354833a84f18bdf0e857fad8812f65b:
>
>   tests/vm: Do not abuse parallelism when HOST != TARGET architecture (2018-10-26 22:03:21 +0800)
>
> ----------------------------------------------------------------
> Testing patches
>
> One fix for mingw build and some improvements in VM based testing, many thanks
> to Paolo and Phil.

Applied, thanks.

-- PMM
