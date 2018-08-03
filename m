Received: from eggs.gnu.org ([2001:4830:134:3::10]:59185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flaB5-0004lB-S2
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flaB5-0007dH-6Y
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:31:35 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1flaB5-0007cw-0Y
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:31:35 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so9741803oie.13
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 06:31:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180801123111.3595-1-richard.henderson@linaro.org>
References: <20180801123111.3595-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Aug 2018 14:31:13 +0100
Message-ID: <CAFEAcA8nYGquX_AT6i8ZMKfYnP=TuSGfhA6q6btgbPkUUW9NDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm sve fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>

On 1 August 2018 at 13:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> These four patches are minor, reported by Laurent this week.
>
> If there happens to be an -rc4 release, it would be nice if
> they were included.  But if not, no biggie.  I suspect that
> other minor issues will be found past these four, so I would
> hope everyone who cares about sve is just as happy working
> from a branch anyway.

Applied to target-arm.for-3.1, thanks.

(I currently expect there will be an -rc4, but I only
want to put in fixes for regressions from 2.12.)

-- PMM
