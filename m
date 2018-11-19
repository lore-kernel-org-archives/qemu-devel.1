Received: from eggs.gnu.org ([2001:4830:134:3::10]:35954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOhbj-0005bd-1m
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOhbi-0008P9-Ax
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:20:47 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOhbi-0008LP-4v
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:20:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so20849816otl.0
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 03:20:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181116163350.40fcd163.cohuck@redhat.com>
References: <20181026105711.29605-1-cohuck@redhat.com>
	<20181115172032.53945f5e.cohuck@redhat.com>
	<1c020087-acd7-302a-d5be-dcdbf7b7084d@redhat.com>
	<20181116161400.1e3c2669.cohuck@redhat.com>
	<20654e1b-38a0-7f70-df97-7ccd5bf17197@redhat.com>
	<20181116163350.40fcd163.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 11:20:24 +0000
Message-ID: <CAFEAcA-s66nJ8DV9oF_+DK1MKXUnLP=GLT5Gia32G0Ju3TRoCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC] MAINTAINERS: clarify some of the tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 November 2018 at 15:33, Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, 16 Nov 2018 09:23:27 -0600
> Eric Blake <eblake@redhat.com> wrote:
>
>> On 11/16/18 9:14 AM, Cornelia Huck wrote:
>
>> >>>> +++ b/MAINTAINERS
>> >>>> @@ -12,9 +12,14 @@ consult qemu-devel and not any specific individual privately.
>> >>>>    Descriptions of section entries:
>> >>>>
>> >>>>          M: Mail patches to: FullName <address@domain>
>> >>>> +           Maintainers are looking after a certain area and must be CCed on
>> >>>> +           patches. They are considered the main contact point.

>> >> At any rate, I like the idea of adding the additional descriptions for
>> >> the categories, even if we still bike-shed on the wording or even the
>> >> set of categories to use.
>> >
>> > What about going with this as a starting point?
>>
>> Yes, works for me. We can always add more patches later if desired.
>
> OK, great!
>
> Peter, would you consider picking up this one for 3.1? At the very
> least, it has a R-b from Markus already :)

Applied to master, thanks
-- PMM
