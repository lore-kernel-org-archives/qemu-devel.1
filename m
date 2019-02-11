Received: from eggs.gnu.org ([209.51.188.92]:48359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gt6ql-0003jq-I2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gt6qi-0005k2-GQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:21:57 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:43606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gt6qi-0005ho-3u
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:21:56 -0500
Date: Mon, 11 Feb 2019 09:21:50 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190211082150.GA10540@t470p.stackframe.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/19] target/hppa: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de

Hi Richard,

On Thu, Feb 07, 2019 at 11:53:41AM +0000, Richard Henderson wrote:

> Helge or Sven, if you have a chance to do a bit more testing in
> the next week, I would appreciate it.  Otherwise we can fix any
> other minor problems on mainline.

I tested this during the weekend with my HP-UX branch and found no
problems. Feel free to add

Tested-by: Sven Schnelle <svens@stackframe.org>

Regards
Sven
