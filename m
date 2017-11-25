Received: from eggs.gnu.org ([2001:4830:134:3::10]:46467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIep2-00088M-QD
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 13:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIep1-0008Nk-Jf
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 13:05:00 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:38456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIep1-0008NN-Df
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 13:04:59 -0500
Received: by mail-oi0-x22e.google.com with SMTP id g139so6954135oic.5
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 10:04:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
	<CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Nov 2017 18:04:37 +0000
Message-ID: <CAFEAcA9_+wZJa7Ht6EHCCZYm+hrfdbjd9gUmVJPGgZ0yvbZOPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bzt bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On 25 November 2017 at 16:43, bzt bzt <bztemail@gmail.com> wrote:
> Dear Andrew,
>
> A month passed, and the maintainers didn't gave a damn about raspi3 support
> in qemu. Any ideas?

Sorry this patch fell through the cracks, but it looked to me
to be in the state "patch got code review comments, waiting for
submitter to resend a new version" (from about the point Konrad
said "split this up, it's too big", which I agree with.)
QEMU gets a lot of patches every day, so our code process relies
on the submitter to prod things if what they're interested in
seems to have been accidentally ignored:
https://wiki.qemu.org/Contribute/SubmitAPatch#If_your_patch_seems_to_have_been_ignored

FWIW, as far as I'm concerned Andrew pretty much is the maintainer
as far as the raspi boards are concerned, so as far as those
bits of code goes I'm happy to take his opinion on it.

PS: if you send a new patch, send it as a new top level
thread -- if you send it as a reply/followup to the
first patch it's liable to not be noticed.

thanks
-- PMM
