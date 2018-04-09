Received: from eggs.gnu.org ([2001:4830:134:3::10]:34485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5S0q-0008Kh-On
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5S0p-0004ed-UV
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:18:52 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:42888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1f5S0p-0004dy-Pf
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:18:51 -0400
Received: by mail-io0-x241.google.com with SMTP id d5so8605102iob.9
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 01:18:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
	<20180309172622.4277-11-peter.maydell@linaro.org>
	<CAFEAcA-aVoyMGegYLrzZAaQgs2nebRZ1+wCBEXw2iHE7FSeZRg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <38f315b7-ba98-f6b4-3b50-7d12e1f11bc9@twiddle.net>
Date: Mon, 9 Apr 2018 18:18:45 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-aVoyMGegYLrzZAaQgs2nebRZ1+wCBEXw2iHE7FSeZRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 10/25] aarch64-linux-user: Add support for
 SVE signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henwood <richard.henwood@arm.com>

On 04/07/2018 04:12 AM, Peter Maydell wrote:
> Richard (Henderson): I'll have a closer look at this on Monday if you don't
> get to it first...

I should have an env to reproduce shortly.


r~
