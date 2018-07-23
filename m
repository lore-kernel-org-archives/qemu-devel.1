Received: from eggs.gnu.org ([2001:4830:134:3::10]:60683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1fhZdd-0006YY-SZ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1fhZdc-0002qG-WE
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:08:29 -0400
MIME-Version: 1.0
References: <20180723012941.16920-1-richard.henderson@linaro.org>
In-Reply-To: <20180723012941.16920-1-richard.henderson@linaro.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 23 Jul 2018 14:08:10 +0200
Message-ID: <CAHmME9okdxsSUQkmBmVtpDFDiM8gAcUu_u+Mv4zYR32QD+A=CA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] tcg/i386: Mark xmm registers
 call-clobbered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable@nongnu.org

Hi Richard,

I can confirm this fixes the issue.
https://www.wireguard.com/build-status/ is now all green again.

Thanks,
Jason
