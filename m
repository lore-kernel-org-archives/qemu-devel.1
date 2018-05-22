Received: from eggs.gnu.org ([2001:4830:134:3::10]:50634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLAJ8-0001jj-FE
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLAJ7-0002i5-NN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:38:42 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLAJ7-0002hl-JN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:38:41 -0400
Received: by mail-oi0-x243.google.com with SMTP id b130-v6so16797624oif.12
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:38:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANCZdfq0_-t+HZhYmGOt0uCLd2p1VNUythUKrCMJffTtrWhz9Q@mail.gmail.com>
References: <CAFEAcA9a-xrtibHYb4+-xu3QVmW3tJ1v9X0s_X_PMhQGFSJgdg@mail.gmail.com>
	<CANCZdfpNMR_buj3L4xvqhh_T4QZOvV5JsXHK2Rzk-zs5iHvGrg@mail.gmail.com>
	<CAFEAcA-xqG+9SZ2_K5XFooJuKYyuRoL51K1JuwQ-SWGcCYcX=A@mail.gmail.com>
	<CANCZdfq0_-t+HZhYmGOt0uCLd2p1VNUythUKrCMJffTtrWhz9Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 17:38:20 +0100
Message-ID: <CAFEAcA8TPL8hJtdWtf1fAFSb1T2iXLxX23vcbVYkLW4rT7oWkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU 3.0 proposed release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 22 May 2018 at 17:34, Warner Losh <imp@bsdimp.com> wrote:
> On Tue, May 22, 2018 at 9:50 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>> The usual recommendation is to submit early and often.
>
>
> Should I do a RFC or preview submission then of the first dozen patches
> maybe as I work out integrating back the bug/compile fixes into the early
> series? I'd love to get feedback, but don't want to waste people's time on
> something that I've not compile tested every change on (just the final
> results, which stands today at ~125 changes, but last week was at 200).

I would suggest a preview submission, yes, though if it did
at least compile that would be nice...

-- PMM
