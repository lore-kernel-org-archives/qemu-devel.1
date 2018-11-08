Received: from eggs.gnu.org ([2001:4830:134:3::10]:57231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKgpj-0002FB-KO
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKgpZ-00013D-47
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:42:32 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKgpV-00010B-L0
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:42:25 -0500
Received: by mail-oi1-x243.google.com with SMTP id x204-v6so927320oia.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:42:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108093208.GC17083@stefanha-x1.localdomain>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181108093208.GC17083@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 09:42:03 +0000
Message-ID: <CAFEAcA-xkbne9faGg4qqKPWbOm5U1cVBF3Y1t2CuxozRDAa1Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/13] arm: nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 8 November 2018 at 09:32, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Nov 02, 2018 at 01:07:17PM -0400, Steffen G=C3=B6rtz wrote:
>
> Thank you, Steffen!  I have posted my Reviewed-by on all patches.
>
> Joel: Will you send pull requests for the microbit machine types or do
> you want Peter to merge this?

I had some code review comments (mostly minor, but there's
a definite bug in the timer code) that need addressing
before this series can be merged. It's pretty close, though.

thanks
-- PMM
