Received: from eggs.gnu.org ([2001:4830:134:3::10]:35498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aishwaryakadlag@gmail.com>) id 1evRir-0007bQ-2o
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aishwaryakadlag@gmail.com>) id 1evRip-0003At-V8
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:58:57 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:39925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aishwaryakadlag@gmail.com>)
	id 1evRip-0003AS-Q6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:58:55 -0400
Received: by mail-ot0-x22d.google.com with SMTP id h8so16178481oti.6
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:58:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XSC1Tm_0AfQPA4Nz5sOZd3HLNDZD7jdBzmEzB5pEyzQ@mail.gmail.com>
References: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
	<6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
	<20180312070545.ktvvgp2kn2uxjpzk@sirius.home.kraxel.org>
	<CAFEAcA8XSC1Tm_0AfQPA4Nz5sOZd3HLNDZD7jdBzmEzB5pEyzQ@mail.gmail.com>
From: Aishwarya Kadlag <aishwaryakadlag@gmail.com>
Date: Mon, 12 Mar 2018 23:28:54 +0530
Message-ID: <CAFPFVbdTdDhvf-vymmVv5SXnp4UD=7adkS8r89YR3O809B787w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V1]sm501: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Really glad to get a feedback so soon on my first attempt.

Yes Thomas sir, I will apply these changes in my next patch. Now that this
patch is already been implemented by Gerd sir in 2014 and it was not
applied, should I consider finding some other task or should I improve this
patch to get it merged or applied? Also as this was my first attempt, I
selected the task mentioned in the wiki page
https://wiki.qemu.org/BiteSizedTasks#Dead_code_removal
As Paolo sir said, if this is too easy then can someone please suggest me
any other task to work on so that I can create something useful to qemu??


Thanks,
Aishwarya



On Mon, Mar 12, 2018 at 6:33 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 12 March 2018 at 07:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > Might be it actually is that easy.
>
> In fact looking through the list archives I see you actually
> sent a patchset to do this for the sm501 device back in March
> last year:
> http://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01172.html
>
> I think it didn't get applied mostly because it was on list
> at the same time as a significant revamp of the sm501 device
> code. So it probably won't apply cleanly to the current code,
> but it looks like a good starting point for identifying what
> the changes needed here are.
>
> thanks
> -- PMM
>
