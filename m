Received: from eggs.gnu.org ([2001:4830:134:3::10]:48692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD5mK-00055i-BX
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD5mJ-0003Sa-J8
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:11:28 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:35911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD5mJ-0003SK-E3
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:11:27 -0400
Received: by mail-oi0-x22a.google.com with SMTP id v2-v6so6956055oif.3
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 03:11:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <367ce2f5-a3b0-9e83-6c33-7924ae7aeb23@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<367ce2f5-a3b0-9e83-6c33-7924ae7aeb23@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 11:11:06 +0100
Message-ID: <CAFEAcA9-N2JekReO=HAHKgUcqtnUqnYUE=F5nmtBRhR=8e5gmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 30 April 2018 at 11:06, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 27/04/2018 18:42, Thomas Huth wrote:
>> On 27.04.2018 18:24, Peter Maydell wrote:
>>> (In the utopian far future I'd like us to have just one QEMU
>>> executable that could handle all architectures at once :-))
>>
>> Yes, that would be great ... but that's really distant future, I guess.
>
> Not _that_ impossible though.  Peter Crosthwaite had some initial
> patches for multi-arch support.

People have been making noises at me about wanting at least the
initial "both an A profile and an M profile Arm core in one board"
support, so it's possible that might float up to the top of my
todo list at some point. (No promises!)

thanks
-- PMM
