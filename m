Received: from eggs.gnu.org ([2001:4830:134:3::10]:46182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dlDUj-00079u-Uf
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dlDUg-0007hW-MB
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dlDUg-0007h5-FQ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:13:46 -0400
References: <150360081780.16351.6836234147404830593@loki>
	<1a05478e-b75d-c149-eaf3-b00b4cf4a4e2@redhat.com>
	<CAFEAcA_HBmo5U8uWW5eEbmusMfTuL-5TLm18daZOBqR0cioPag@mail.gmail.com>
	<610551e8-9098-614e-c0c4-1e306cda67c3@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f93cf725-d5bc-174e-8f84-3935f19e6efd@redhat.com>
Date: Fri, 25 Aug 2017 14:13:42 +0200
MIME-Version: 1.0
In-Reply-To: <610551e8-9098-614e-c0c4-1e306cda67c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.de>

On 08/25/17 11:15, Paolo Bonzini wrote:
> On 25/08/2017 11:13, Peter Maydell wrote:
>> On 24 August 2017 at 20:06, Laszlo Ersek <lersek@redhat.com> wrote:
>>> Has it not been the intent to include the following patch in 2.10:
>>>
>>>   [PATCH] scsi-bus: correct responses for INQUIRY and REQUEST SENSE
>>>   http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03351.html
>>>   Message-Id: <1503049022-14749-1-git-send-email-hare@suse.de>
>>>
>>> Paolo CC'd it to stable.
>>>
>>> Apologies if I misunderstood.
>>
>> Nobody flagged it up on the wiki planning page or replied to my
>> "are there any other RC things we should fix for 2.10" emails
>> about it. If it has to go into an RC then it needs to get my
>> attention as a release-critical bug (which is a stronger
>> criterion than just should-go-into-next-stable release).

Sorry, my recent workload has totally prevented me from even skimming
the subjects on qemu-devel :(

I vaguely remember that I had edited a similar wiki page for an earlier
release, about an issue I had perceived release critical. But, this
memory has failed to surface in my consciousness soon enough. Something
something workload something.

> No problem, it was nice-to-have indeed, but since Laszlo has fixed it in
> OVMF it is not a tragedy.

Right!

Laszlo
