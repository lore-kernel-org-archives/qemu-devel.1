Received: from eggs.gnu.org ([2001:4830:134:3::10]:47562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7nI-00049s-HF
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7mr-00076B-2m
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:46:28 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:35451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX7mq-00075o-Sn
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:46:00 -0500
Received: by mail-ua0-x233.google.com with SMTP id y9so207627007uae.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:46:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vat08tem.fsf@linaro.org>
References: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
	<1484247815-15279-3-git-send-email-peter.maydell@linaro.org>
	<87vat08tem.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:45:39 +0000
Message-ID: <CAFEAcA-6=KkgArFz-8MC7LO2eT=xngrwreFX2b8-n_WiSyYuyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/misc: New "unimplemented" sysbus
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <bonzini@gnu.org>

On 27 January 2017 at 14:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Is there any millage at being able to define areas on the command line
> or would we expect every usage of this to be from a board file in the
> source?

Command line syntax is for life, not just for Christmas, so
I'd rather we didn't add any until somebody comes up with a
genuine use case for it.

thanks
-- PMM
