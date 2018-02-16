Received: from eggs.gnu.org ([2001:4830:134:3::10]:56838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emhum-00044T-Vu
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emhum-0006iB-2q
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:27:08 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emhul-0006hg-Sr
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:27:08 -0500
Received: by mail-oi0-x244.google.com with SMTP id 23so2511648oip.12
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:27:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216151318.GH3181@redhat.com>
References: <20180216121810.56ed961e.cohuck@redhat.com>
	<CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
	<8b721785-5581-8936-2517-1fa00db3dabd@redhat.com>
	<CAFEAcA82O0HpZCa_sHJmwn7sH4HYE4NUAg0ni_Z2n_+d4JMAWQ@mail.gmail.com>
	<20180216151318.GH3181@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 15:26:46 +0000
Message-ID: <CAFEAcA_PcFAVOB=ZnmOw=Uf6WiKEUH7kX6i7oagZkB5mKpmS6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Process] QEMU submaintainers and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 15:13, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> On Fri, Feb 16, 2018 at 03:03:07PM +0000, Peter Maydell wrote:
>> On 16 February 2018 at 14:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > On 16/02/2018 12:25, Peter Maydell wrote:
>> >> On 16 February 2018 at 11:18, Cornelia Huck <cohuck@redhat.com> wrote=
:
>> >> The block folks are already doing this, so we should just
>> >> formalize what they're doing at the moment I guess. From my point
>> >> of view as long as there's something I can easily filter
>> >> in/out in the email body or subject so I don't get confused
>> >> (and which doesn't require me to update my filters every time
>> >> a new subsystem switches to using submaintainer pulls!)
>> >> I don't mind about the rest of it. Maybe a subject line with
>> >> 'PULL SUBSYSTEM s390x' (ditto block, etc etc) ?
>> >
>> > What about just requiring you to be in the "To" or "Cc" fields?  That
>> > works pretty well for Linux.
>>
>> It would require existing submaintainers to change their process,
>> though -- currently not all pull requests are to/cc me.
>
> All this time I thought it was /already/ required to cc Peter on
> pull requests !

The only thing I currently require is that the body text
contains the appropriate magic words and that it goes to
qemu-devel in to or cc.

thanks
-- PMM
