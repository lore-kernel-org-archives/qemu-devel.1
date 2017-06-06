Received: from eggs.gnu.org ([2001:4830:134:3::10]:42664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIG05-0007Tz-6F
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFzv-00052N-TW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:02:29 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIFzv-00052C-NP
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:02:19 -0400
Received: by mail-wm0-x22f.google.com with SMTP id x70so39194102wme.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 08:02:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGKXQycwBnuFGKeOVYa0fbQ7zRbFsFKKSYUaOQmUUDtk+5uZQQ@mail.gmail.com>
References: <CAGKXQycwBnuFGKeOVYa0fbQ7zRbFsFKKSYUaOQmUUDtk+5uZQQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 16:01:57 +0100
Message-ID: <CAFEAcA-ezUa7dZYb6O1OWvOV8j4SK5v6Br7fPNuH6VYoYF+-3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MemoryRegion and RamBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2017 at 15:55, ali saeedi <ali.saeedi56@gmail.com> wrote:
> Hello all
> what does these concepts 'MemoryRegion' and 'RamBlock' mean?

http://blog.vmsplice.net/2016/01/qemu-internals-how-guest-physical-ram.html
may be helpful (second google hit for 'memoryregion ramblock').

thanks
-- PMM
