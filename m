Received: from eggs.gnu.org ([209.51.188.92]:35729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1tM5-000211-6c
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1tM4-00048O-DD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:46:37 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:34248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1tM4-00046B-3g
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:46:36 -0500
Received: by mail-ot1-x329.google.com with SMTP id 98so14132348oty.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 05:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
	<20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
	<CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
	<20190307121417.fztvzzb6lyrpnjyx@dhcp-17-118.bos.redhat.com>
	<CAFEAcA_rSdxsJLVyg-E1=1viw0f-p2G60VLvVZ-k8ERr6P_=gw@mail.gmail.com>
	<20190307131804.te3thn7hzi6xo3ed@dhcp-17-118.bos.redhat.com>
	<CAFEAcA976P1zp8CnyxzK48E_55cz23Y1XfELAo+v1tj_kuqiaw@mail.gmail.com>
	<20190307134142.spkpqngtknbk47g5@dhcp-17-118.bos.redhat.com>
In-Reply-To: <20190307134142.spkpqngtknbk47g5@dhcp-17-118.bos.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 13:46:22 +0000
Message-ID: <CAFEAcA_ZZC24UrQeXTh5gVc8KCLqUmgJNvV+vTf5BVQhAxSJ6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 08/12] docs: Provide separate conf.py
 for each manual we want
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 7 Mar 2019 at 13:41, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Thu, Mar 07, 2019 at 01:30:39PM +0000, Peter Maydell wrote:
> > Well, I'm also a bit biased here, in that this is v3 of this
> > patchset that's been on the list using this approach for
> > a month, and I was planning to apply it to master today
> > so that it could be in before the softfreeze on Tuesday
> > next week. So late-breaking suggestions for significant
> > restructurings are essentially saying "we should postpone
> > this to 4.1" :-(
> >
>
> I apologize for not looking at this before... honestly speaking, my
> bandwidth and efficiency doesn't allow me look at most patches :).  It
> was only a CC on this v3 that caught my attention.
>
> Anyway, I don't want to disrupt progress, and I do believe in
> incremental betterment.  I have plans to add Python API docs once the
> "python" directory structure gets in, so I might as well suggest
> improvements in the form of patches later on.

OK, thanks. If the end result in document structure is the
same then we can make the change as an incremental improvement later.

thanks
-- PMM
