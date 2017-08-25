Received: from eggs.gnu.org ([2001:4830:134:3::10]:38908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlAgp-0000m6-GW
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlAgo-0007Yk-D4
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:14:07 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlAgo-0007YF-5w
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:14:06 -0400
Received: by mail-wm0-x22f.google.com with SMTP id b189so7803674wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 02:14:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1a05478e-b75d-c149-eaf3-b00b4cf4a4e2@redhat.com>
References: <150360081780.16351.6836234147404830593@loki>
	<1a05478e-b75d-c149-eaf3-b00b4cf4a4e2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 10:13:44 +0100
Message-ID: <CAFEAcA_HBmo5U8uWW5eEbmusMfTuL-5TLm18daZOBqR0cioPag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.de>

On 24 August 2017 at 20:06, Laszlo Ersek <lersek@redhat.com> wrote:
> Has it not been the intent to include the following patch in 2.10:
>
>   [PATCH] scsi-bus: correct responses for INQUIRY and REQUEST SENSE
>   http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03351.html
>   Message-Id: <1503049022-14749-1-git-send-email-hare@suse.de>
>
> Paolo CC'd it to stable.
>
> Apologies if I misunderstood.

Nobody flagged it up on the wiki planning page or replied to my
"are there any other RC things we should fix for 2.10" emails
about it. If it has to go into an RC then it needs to get my
attention as a release-critical bug (which is a stronger
criterion than just should-go-into-next-stable release).

thanks
-- PMM
