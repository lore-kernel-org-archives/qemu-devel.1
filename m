Received: from eggs.gnu.org ([209.51.188.92]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMamt-0006eq-QR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMams-0005Oy-Pd
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMams-0005OH-IR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so8526211wrs.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:11:50 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502143409.59600-1-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 17:11:48 +0100
Message-ID: <87ef5f4iwr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 00/12] Add RX archtecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Hello.
> This patch series is added Renesas RX target emulation.

I think the series is almost there - it's mostly just nits and clean
build fixes to sort out now. If you run the branch through CI you will
see where things fail to build.

However once that is all sorted it should be good for merging. I guess
Richard would merge it until we can get your key signed so you can
submit your own PRs:

  https://wiki.qemu.org/KeySigningParty

--
Alex Benn=C3=A9e
