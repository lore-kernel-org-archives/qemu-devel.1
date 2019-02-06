Received: from eggs.gnu.org ([209.51.188.92]:47015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1grQMh-0005wG-PL
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1grQMg-0007RN-1j
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:47:59 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1grQMd-0007Iw-SR
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:47:57 -0500
Received: by mail-pf1-x442.google.com with SMTP id 64so3318157pfr.9
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 08:47:47 -0800 (PST)
Date: Wed, 06 Feb 2019 08:47:45 -0800 (PST)
In-Reply-To: <CAFEAcA9JXK5O5tSvBD17CM3Eb132EWuub9VvOJWaAKUOu8KA5A@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-7f0a2867-f9c8-4a43-a410-b60f25df4cc1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: thuth@redhat.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Mon, 04 Feb 2019 01:59:48 PST (-0800), Peter Maydell wrote:
> On Mon, 4 Feb 2019 at 09:05, Thomas Huth <thuth@redhat.com> wrote:
>> On 2019-02-02 09:41, Palmer Dabbelt wrote:
>> >> My mail filter finds these RFC pullrequests, yes. I'm then
>> >> relying on my manual brain to not actually apply them.
>> >> (If it's a slow day I might do a test merge on them, but
>> >> usually my queue is full enough that I don't get to them
>> >> before the real PR appears.)
>> >
>> > Ah, OK -- do you want me to do something else?
>>
>> At least I got a little bit confused by "PR RFC" ... I think some other
>> maintainers rather send out patch series marked with "PATCH" first, and
>> add some non-pull-request cover letter with a text like "I'm intending
>> to send a pull request for this soon, please review one more time...".
>> Then after a day or two, once Patchew checked the series and nobody else
>> complained, they send a real "PULL" request.
>
> Yeah, generally nobody else sends RFC pull requests, they just
> send the actual pulls. I don't object if Palmer finds them
> useful, though.

If nobody else does it then I might stop -- they were more useful for me when I 
was new at this, as I was pretty worried about making mistakes and wanted to 
make sure I didn't screw anything up.  Things have gone pretty smoothly, so it 
might just have been paranoia.

Unless anyone likes these I think I'll stop sending them.

>
> For what it's worth, my filter for finding pull requests is emails
> containing "for you to fetch changes up to" but not either of
> "not for master" or "PULL SUBSYSTEM". So if you want to specifically
> keep out of the filters you can add "not for master" in the cover
> letter. But as I say it's not a big deal for me to sort things out
> manually -- the filter has the odd false positive anyway.

OK, makes sense.
