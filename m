Received: from eggs.gnu.org ([2001:4830:134:3::10]:35111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciqGv-0007tU-2A
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciqGu-0001s1-4V
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:29:29 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:32997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciqGt-0001ri-T2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:29:28 -0500
Received: by mail-wm0-x231.google.com with SMTP id i17so5314476wmf.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:29:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4a4764c2-1af5-394a-08d2-6a08a690374a@redhat.com>
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
	<658a0501-0696-b9d9-2cfd-169277a85c1a@redhat.com>
	<1488306274.26614.41.camel@redhat.com>
	<4a4764c2-1af5-394a-08d2-6a08a690374a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 22:29:06 +0000
Message-ID: <CAFEAcA9vcwqM-oe1F0Ez9ene-6rFa1dZg39s8Vw9-ShW3UgeQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 28 February 2017 at 21:34, John Snow <jsnow@redhat.com> wrote:
>
>
> On 02/28/2017 01:24 PM, Gerd Hoffmann wrote:
>> On Di, 2017-02-28 at 11:48 -0500, John Snow wrote:
>>>
>>> On 02/28/2017 04:06 AM, Gerd Hoffmann wrote:
>>>>   Hi,
>>>>
>>>> Here comes the seabios update for qemu 2.9,
>>>> the just tagged 1.10.2 release.
>>>>
>>>> Our seabios.git mirror @ qemu.org seems to not sync properly.  The
>>>> commit isn't there even though it was pushed a few days ago already
>>>> (only the tag was pushed today).  John, can you have a look please?
>>>> master branch, *-stable branches and all tags should be mirrored.
>>>>
>>>
>>> http://git.qemu-project.org/?p=seabios.git;a=log
>>>
>>> Looks like the patch I wanted to be there is in there. Are you
>>> referencing Ladi's commit? It looks like it's there just fine.
>>
>> Commits from February are missing.  And this one ...
>>
>> http://git.qemu-project.org/?p=seabios.git;a=shortlog;h=refs/heads/1.10-stable
>>
>> ... is outdated too.
>>
>> cheers,
>>   Gerd
>>
>
> Oh, uhm... Who maintains the mirror? Jeff Cody is on vacation.
>
> CCing Peter.

Stefan and Paolo are covering while Jeff's away.

thanks
-- PMM
