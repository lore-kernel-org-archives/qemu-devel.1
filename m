Received: from eggs.gnu.org ([2001:4830:134:3::10]:50061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cen1t-0007Cf-J2
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cen1q-0001XK-Ey
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:13:13 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bcbf9b48-1f40-25dd-3fdc-b7ed9821ee60@redhat.com>
Date: Fri, 17 Feb 2017 13:13:09 -0500
MIME-Version: 1.0
In-Reply-To: <6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Chad Joan <chadjoan@gmail.com>



On 02/17/2017 10:34 AM, Eric Blake wrote:
> On 02/17/2017 03:28 AM, Peter Maydell wrote:
>> On 17 February 2017 at 06:43, Fam Zheng <famz@redhat.com> wrote:
>>> But your point is taken, we should make the first (or a one-shot)
>>> contribution as easy as possible.
>>
>> Yes; we could do with providing a "This page seems very long..."
>> introduction section. The absolute bare minimum requirements
>> for a submitter I think are:
>>  * Provide a Signed-off-by: line (this is a hard requirement
>>    because it's how you say "I'm legally OK to contribute this
>>    and am happy for it to go into QEMU")
>>  * send patch by email
>>  * read replies and act on them if you want your patch to go in
>>
>> The larger your contribution is, the more important the other
>> requirements detailed on the page are; but personally I'm
>> happy to manually fix up patches from a first-time submitter,
>> and I think most other maintainers are too.
> 
> I've updated the wiki to put in that nice bullet list, prior to the
> table of contents.
> 

Is there a way we can make the quickstart exist in a pop-box?

Also, any way to wrap the text on the rest of the introductory article?
If you fullscreen this on a widescreen monitor you have to chase the
letters to the far corners of the earth.

Formatting the article more nicely might help its readability. It's also
worth noting that just /reading the outline/ gives you enough advice,
reading the details are actually not strictly necessary.

--js
