Received: from eggs.gnu.org ([208.118.235.92]:56114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egewG-0003DG-Ot
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egevC-0002XV-M9
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:03:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egevC-0002VU-AD
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:02:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48D976B254
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 23:02:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <1516958370-3955-1-git-send-email-thuth@redhat.com>
	<7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
	<64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
	<b5fdc573-d44a-ca23-6e51-0cdeb0087771@redhat.com>
Message-ID: <af88a958-1de3-c1d9-c448-86129d223dc5@redhat.com>
Date: Tue, 30 Jan 2018 18:02:28 -0500
MIME-Version: 1.0
In-Reply-To: <b5fdc573-d44a-ca23-6e51-0cdeb0087771@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add "Understanding QEMU devices"
 blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 29/01/2018 12:27, Thomas Huth wrote:
> On 26.01.2018 15:46, Eric Blake wrote:
>> On 01/26/2018 06:40 AM, Paolo Bonzini wrote:
>>> On 26/01/2018 10:19, Thomas Huth wrote:
>>>> Last July, Eric Blake wrote a nice summary for newcomers about what
>>>> QEMU has to do to emulate devices for the guests. So far, we missed
>>>> to integrate this somewhere into the QEM web site or wiki, so let's
>>>> publish this now as a nice blog post for the users.
>>>
>>> It's very nice!  Some proofreading and corrections follow.
>>
>> Thanks for digging up my original email, and enhancing it (I guess the
>> fact that I don't blog very often, and stick to email, means that I rely
>> on others helping to polish my gems for the masses).
> 
> Sure ... Would you like to give it a try this time and continue with the
> patch, or shall I continue and send a v2?
> 
>>>> +++ b/_posts/2018-01-26-understanding-qemu-devices.md
>>>> @@ -0,0 +1,139 @@
>>>> +---
>>>> +layout: post
>>>> +title:  "Understanding QEMU devices"
>>>> +date:   2018-01-26 10:00:00 +0100
>>
>> That's when you're posting it online, but should it also mention when I
>> first started these thoughts in email form?
> 
> At least in the header we should have the current date, or the blog post
> will not show up at the top of the blog. Not sure whether there is an
> alternate field for the original date ... maybe we could rather add an
> "originally written in 2017 ..." sentence at the bottom of the post instead?

I don't think it's relevant, as long as it's brought up to date when we
post it to the web.

Paolo
