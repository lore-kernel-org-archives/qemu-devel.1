Received: from eggs.gnu.org ([2001:4830:134:3::10]:38643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3mBs-0004WN-Oo
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3mBr-0007Ow-LX
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:55:04 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:50383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e3mBr-0007NO-EY
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:55:03 -0400
Received: by mail-wm0-x233.google.com with SMTP id u138so29488644wmu.5
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 09:55:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-11-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-11-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Oct 2017 17:54:41 +0100
Message-ID: <CAFEAcA9vcZa-v1gxLD0kjGO5zxwmZnNioLy6daEc0MtJJOY5VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 10/30] softfloat: improve comments on
 ARM NaN propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 13 October 2017 at 17:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Mention the pseudo-code fragment from which this is based and correct
> the spelling of signalling.

We are following the IEEE spec here, which spells it "signaling"
with one 'l', being American. (The ARM ARM also uses the one-l
spelling.)

thanks
-- PMM
