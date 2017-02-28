Received: from eggs.gnu.org ([2001:4830:134:3::10]:55147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1circR-0000SL-2i
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1circQ-0003sN-CW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:55:47 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:34700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1circQ-0003sI-8T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:55:46 -0500
Received: by mail-ot0-x231.google.com with SMTP id x10so19042104otb.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:55:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228213324.23510-1-rth@twiddle.net>
References: <20170228213324.23510-1-rth@twiddle.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 28 Feb 2017 18:55:15 -0500
Message-ID: <CAJhHMCBFzNw2hoOHVfJnOd7LO_7eKxXZvvXJ9ynQD+LJALV2ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] TCG queued patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Feb 28, 2017 at 4:33 PM, Richard Henderson <rth@twiddle.net> wrote:
> Only one this week.  Pranith didn't mention which compiler version,
> but I can imagine gcc7 or clang warning of such a thing.
>

I apologize for missing this information in the patch. The warning was
from clang master.

Thanks,
--
Pranith
