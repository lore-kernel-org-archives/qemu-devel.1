Received: from eggs.gnu.org ([2001:4830:134:3::10]:38101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqH7h-0004MP-Ci
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqH7g-00061V-O5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:11:29 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqH7g-000610-HH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:11:28 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so7533901oib.10
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:11:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:11:06 +0100
Message-ID: <CAFEAcA_t0TuJTtGU=xqTEi2AmOOW2JxF-s5uSKUtbsnDi+wFDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/11] target/arm: sve linux-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 04:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I posted a few of these before, and I thought Peter had applied them
> to his target-arm.for-3-1 branch, but I don't see them there now.

I did indeed have patches 1-4 in my for-3.1 branch and they're now
in master. I must have forgotten to push out my local branch to
git.linaro.org after applying them.

> I've taken the opportunity to tag all of these for backport into the
> next stable release.  I'm intending to do so for all of the correctness
> patches affecting sve linux-user so that 3.0.1 will be usable long-term.

Applied 5..11 to target-arm.next.

thanks
-- PMM
