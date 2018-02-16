Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emhXu-0005nH-DJ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emhXt-0005q4-AU
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:03:30 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emhXt-0005pk-5n
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:03:29 -0500
Received: by mail-ot0-x244.google.com with SMTP id e64so2940853ote.4
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:03:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8b721785-5581-8936-2517-1fa00db3dabd@redhat.com>
References: <20180216121810.56ed961e.cohuck@redhat.com>
	<CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
	<8b721785-5581-8936-2517-1fa00db3dabd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 15:03:07 +0000
Message-ID: <CAFEAcA82O0HpZCa_sHJmwn7sH4HYE4NUAg0ni_Z2n_+d4JMAWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Process] QEMU submaintainers and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 14:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 16/02/2018 12:25, Peter Maydell wrote:
>> On 16 February 2018 at 11:18, Cornelia Huck <cohuck@redhat.com> wrote:
>> The block folks are already doing this, so we should just
>> formalize what they're doing at the moment I guess. From my point
>> of view as long as there's something I can easily filter
>> in/out in the email body or subject so I don't get confused
>> (and which doesn't require me to update my filters every time
>> a new subsystem switches to using submaintainer pulls!)
>> I don't mind about the rest of it. Maybe a subject line with
>> 'PULL SUBSYSTEM s390x' (ditto block, etc etc) ?
>
> What about just requiring you to be in the "To" or "Cc" fields?  That
> works pretty well for Linux.

It would require existing submaintainers to change their process,
though -- currently not all pull requests are to/cc me.

thanks
-- PMM
