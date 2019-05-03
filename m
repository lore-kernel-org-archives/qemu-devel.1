Received: from eggs.gnu.org ([209.51.188.92]:49711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMVRD-00022c-65
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMVRC-0003U9-Cn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:29:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMVRC-0003T3-2o
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:29:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id l1so4056464oib.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 03:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190425133503.30847-1-stefanha@redhat.com>
	<20190503101921.GC17905@redhat.com>
In-Reply-To: <20190503101921.GC17905@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 11:28:53 +0100
Message-ID: <CAFEAcA_CkUBHe1fWg9wy-+HLw8WBZrp3M_oBksCN1GQc1qp4hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
 developer docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Otubo <otubo@redhat.com>

On Fri, 3 May 2019 at 11:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> Everything above here is useful to QEMU devs, app devs & end users and
> should be made part of the main QEMU doc - convert it to texi and @includ=
e
> it from qemu-doc.texi, as we do for other stuff under docs/

If we convert it to texi we'll have to convert it back again
as/when we migrate properly from texi to sphinx... (I would
like to make further moves in that direction during this
release cycle -- just need to find the time to work on it.)

thanks
-- PMM
