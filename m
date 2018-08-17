Received: from eggs.gnu.org ([2001:4830:134:3::10]:40288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1fqief-0006Dp-Ua
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1fqieY-00063i-J0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:35:19 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1fqieY-00062q-9a
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:35:14 -0400
Received: by mail-oi0-x242.google.com with SMTP id b15-v6so15266345oib.10
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:35:11 -0700 (PDT)
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
	<1512683181-8420-2-git-send-email-minyard@acm.org>
	<3d8659d1-57ba-3043-7098-5b74c28c34bb@redhat.com>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <a77d2165-bc5f-7e89-e83f-a6057acbdeaf@mvista.com>
Date: Fri, 17 Aug 2018 12:33:02 -0500
MIME-Version: 1.0
In-Reply-To: <3d8659d1-57ba-3043-7098-5b74c28c34bb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 01/14] i2c:pm_smbus: Clean up some style
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, minyard@acm.org, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

On 08/17/2018 12:24 PM, Paolo Bonzini wrote:
> On 07/12/2017 22:46, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Fix some spacing issues, remove extraneous comments, add some
>> defines instead of hard-coding numbers.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   hw/i2c/pm_smbus.c | 58 ++++++++++++++++++++++++++++++++++++-------------------
>>   1 file changed, 38 insertions(+), 20 deletions(-)
> Hi Corey, I just found this patch and the rest of the series.  If it
> still applies, could you please resend it?
>
> Thanks,
>
> Paolo

I've been meaning to resend this and some other thing, but I've been
distracted with a lot of other things.  I'll resend as soon as I can.  
Is this
pressing for another reason?  I can increase the priority if so.

-corey
