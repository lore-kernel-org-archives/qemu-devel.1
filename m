Received: from eggs.gnu.org ([2001:4830:134:3::10]:56680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekxN-0004zj-SW
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekxN-0006m1-7w
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:04:57 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eekxN-0006lp-33
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:04:57 -0500
Received: by mail-oi0-x229.google.com with SMTP id t78so5702337oih.4
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:04:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fb01dcd4-f288-88f2-63df-a7aada267044@ilande.co.uk>
References: <20180124195843.dk7efcmdwoba2jtw@kentang.home>
	<CAFEAcA-T4P6pQTmQG2OuwA0XrHcvjvrzoiE4o=TYDfUv77OWsQ@mail.gmail.com>
	<fb01dcd4-f288-88f2-63df-a7aada267044@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 17:04:36 +0000
Message-ID: <CAFEAcA9vKoa05R_8JULrfODyU8d5dP3JMoVAbL2vxtUTkLSFMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 January 2018 at 13:48, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Sorry yes, those format strings were taken from some very old code so I
> should have paid a bit more attention.
>
> I've fixed up these events and re-pushed the qemu-sparc-signed tag to github
> which should resolve the issue.

Thanks, applied the updated version.

-- PMM
