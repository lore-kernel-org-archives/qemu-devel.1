Received: from eggs.gnu.org ([2001:4830:134:3::10]:51871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1emhdG-0001FG-AY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1emhdD-0001kL-FK
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:09:02 -0500
References: <20180216121810.56ed961e.cohuck@redhat.com>
	<CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
	<8b721785-5581-8936-2517-1fa00db3dabd@redhat.com>
	<CAFEAcA82O0HpZCa_sHJmwn7sH4HYE4NUAg0ni_Z2n_+d4JMAWQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a71adf2-f617-74c2-cf7e-34517ac6aade@redhat.com>
Date: Fri, 16 Feb 2018 16:08:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82O0HpZCa_sHJmwn7sH4HYE4NUAg0ni_Z2n_+d4JMAWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Process] QEMU submaintainers and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16/02/2018 16:03, Peter Maydell wrote:
> On 16 February 2018 at 14:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 16/02/2018 12:25, Peter Maydell wrote:
>>> On 16 February 2018 at 11:18, Cornelia Huck <cohuck@redhat.com> wrote:
>>> The block folks are already doing this, so we should just
>>> formalize what they're doing at the moment I guess. From my point
>>> of view as long as there's something I can easily filter
>>> in/out in the email body or subject so I don't get confused
>>> (and which doesn't require me to update my filters every time
>>> a new subsystem switches to using submaintainer pulls!)
>>> I don't mind about the rest of it. Maybe a subject line with
>>> 'PULL SUBSYSTEM s390x' (ditto block, etc etc) ?
>>
>> What about just requiring you to be in the "To" or "Cc" fields?  That
>> works pretty well for Linux.
> 
> It would require existing submaintainers to change their process,
> though -- currently not all pull requests are to/cc me.

Yeah, but that would not be too hard.  There are only about 40
maintainers, and if anybody misses the news they would notice fairly
quickly. :)

BTW, Fam and I are also planning to improve Patchew so that it is better
at detecting pull requests and especially merged pull requests.

Thanks,

Paolo
