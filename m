Received: from eggs.gnu.org ([209.51.188.92]:33988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJgCQ-0001Mm-Pr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfyq-0000pV-RU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:08:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfyq-0000mH-JS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:08:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id w15so747290wmc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:08:08 -0700 (PDT)
References: <20190425132636.31636-1-arilou@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190425132636.31636-1-arilou@gmail.com>
Date: Thu, 25 Apr 2019 16:08:05 +0100
Message-ID: <87o94uunqi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/21] gdbstub: Refactor command packets
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jon Doron <arilou@gmail.com>


Jon Doron <arilou@gmail.com> writes:

> This patch series refactors the old gdbstub command packets handler
> with a new infrastructure which should ease extending and adding new
> and missing gdb command packets.
>
> version 4-6 changes:
> - mostly feedback from Richard Henderson

I admire your keen but I think my comments on v3 still apply so I'll
wait until the next iteration.

--
Alex Benn=C3=A9e
