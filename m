Received: from eggs.gnu.org ([209.51.188.92]:58446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfri-00024A-UM
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfrd-0002Sg-TG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:00:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfrd-0002RF-Kx
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:00:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id c1so9673922wml.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:00:41 -0700 (PDT)
References: <20190424142714.28460-1-arilou@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190424142714.28460-1-arilou@gmail.com>
Date: Thu, 25 Apr 2019 16:00:38 +0100
Message-ID: <87r29quo2x.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/20] gdbstub: Add infrastructure to
 parse cmd packets
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


arilou@gmail.com writes:

> From: Jon Doron <arilou@gmail.com>
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

Multi-patch series should have a cover letter:

  https://wiki.qemu.org/index.php/Contribute/SubmitAPatch#Include_a_meaning=
ful_cover_letter

Overall this looks like a nice improvement to the parsing code. Please
CC me on the next revision.

I'm still curious as to what additional commands you plan to implement
once this is merged?

--
Alex Benn=C3=A9e
