Received: from eggs.gnu.org ([2001:4830:134:3::10]:44955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTt5f-0005zh-Kx
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTt5e-0002o5-V3
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:28:03 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:36539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cTt5e-0002nm-Qu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:28:02 -0500
Received: by mail-oi0-x231.google.com with SMTP id u143so9606963oif.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 08:28:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Ag8u0d9h7mEMT6mo8nb3MAbh_yQ=2PhwnTGD-oM=zwQ@mail.gmail.com>
References: <20170118150235.23850-1-bobby.prani@gmail.com>
	<CAFEAcA8Ag8u0d9h7mEMT6mo8nb3MAbh_yQ=2PhwnTGD-oM=zwQ@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 18 Jan 2017 11:27:31 -0500
Message-ID: <CAJhHMCAVTdZd7fA+=UMkzV7pf9BpShW9mq+YuSEJvKC0w4cdsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: fix settime old value
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Wed, Jan 18, 2017 at 11:20 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:

>
> I reviewed this when Marc sent it back in November,
> but this resend doesn't seem to have addressed any
> of that.
>

Sorry about that. I seem to have missed the reviews last time.

I'll update and resend them.

Thanks,
-- 
Pranith
