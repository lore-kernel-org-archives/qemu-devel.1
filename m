Received: from eggs.gnu.org ([2001:4830:134:3::10]:35015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZyKQ-0006YS-BA
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZyKP-0000Rs-FM
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:53:14 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZyKP-0000RO-99
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:53:13 -0400
Received: by mail-oi0-x232.google.com with SMTP id v8-v6so16135444oie.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 05:53:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 13:52:51 +0100
Message-ID: <CAFEAcA9YE0N4ELyN4Er05RLREGCV4BUyWimJSUQEXLODiXCPYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 00/22] ARM SVE support for RISU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 22 June 2018 at 15:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Hi Peter,
>
> Not much different from v3 apart from the last SVE register dump patch
> is now fatter with stuff that was from the handle variable VQ series.
> The binary format has stayed the same and we have a current test set
> for SVE at:
>
>   http://people.linaro.org/~alex.bennee/testcases/arm64.risu/sve-all-shor=
t-v83+sve.tar.xz
>
> Unless you have any comments I reckon these are ready to be merged.

Applied to risu master, thanks.

-- PMM
