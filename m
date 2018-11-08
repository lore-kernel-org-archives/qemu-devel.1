Received: from eggs.gnu.org ([2001:4830:134:3::10]:39616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gKhQs-0004BB-5H
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gKhQd-0004qy-Lp
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:20:49 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:33136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>) id 1gKhQd-0004El-7U
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:20:47 -0500
Received: by mail-qk1-x742.google.com with SMTP id o89so25578030qko.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 02:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181108093208.GC17083@stefanha-x1.localdomain>
	<CAFEAcA-xkbne9faGg4qqKPWbOm5U1cVBF3Y1t2CuxozRDAa1Tw@mail.gmail.com>
In-Reply-To: <CAFEAcA-xkbne9faGg4qqKPWbOm5U1cVBF3Y1t2CuxozRDAa1Tw@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 8 Nov 2018 20:50:23 +1030
Message-ID: <CACPK8XcoDhwkcpjtjxYr2kGBs8kj4FgyJW7hTkaq9NzB6NgoEg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On Thu, 8 Nov 2018 at 20:12, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On 8 November 2018 at 09:32, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Fri, Nov 02, 2018 at 01:07:17PM -0400, Steffen G=C3=B6rtz wrote:
> >
> > Thank you, Steffen!  I have posted my Reviewed-by on all patches.
> >
> > Joel: Will you send pull requests for the microbit machine types or do
> > you want Peter to merge this?
>
> I had some code review comments (mostly minor, but there's
> a definite bug in the timer code) that need addressing
> before this series can be merged. It's pretty close, though.

I'm not fussed if I send the request or Peter does. For the aspeed
work I've done in the past Peter has rolled the patches into his ARM
pull requests.

Peter, once the patches are good to go, what would you prefer?

Cheers,

Joel
