Received: from eggs.gnu.org ([2001:4830:134:3::10]:59614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deihw-0006Iw-Si
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deihv-0007KG-2e
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:08:36 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deihu-0007K4-U3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:08:34 -0400
Received: by mail-io0-x244.google.com with SMTP id j32so466584iod.3
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 07:08:34 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170807073345.GG14780@lemon>
References: <150181165680.60.17068931498958654477@93e45bedd699>
	<d13bf86c-036d-4178-9d1d-52443ba226b6@redhat.com>
	<20170804121031.GA1913@lemon>
	<20170807064330.GF14780@lemon> <20170807073345.GG14780@lemon>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 7 Aug 2017 11:08:33 -0300
Message-ID: <CAAdtpL5oZ39fhsO-qB9+AJ599k+EmSPrAn+nvZnm+CZoiuf=iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/22] Clean up around qmp() and hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Aug 7, 2017 at 4:33 AM, Fam Zheng <famz@redhat.com> wrote:
> On Mon, 08/07 14:43, Fam Zheng wrote:
>> On Fri, 08/04 20:10, Fam Zheng wrote:
>> > On Fri, 08/04 06:50, Eric Blake wrote:
>> > > On 08/03/2017 08:54 PM, no-reply@patchew.org wrote:
>> > > > Hi,
>> > > >
>> > > > This series failed automatic build test. Please find the testing commands and
>> > > > their output below. If you have docker installed, you can probably reproduce it
>> > > > locally.
>> > >
>> > > When will patchew have a syntax for stating dependencies? (Of course, I
>> > > should actually mention those dependencies in my cover letter, not after
>> > > the fact).
>> >
>> > I can give it a try this weekend, if it works, it will be announced on this
>> > list.
>>
>> Hijack! As an experiment of the newly pushed "base" tag handling on the server:
>>
>> Based-on: 20170802201900.11890-1-eblake@redhat.com

:)

>
> It worked. Now, restarted the tests with the "rebased" branch:
>
> https://github.com/patchew-project/qemu/commits/patchew/20170804012551.2714-1-eblake%40redhat.com
>
> Fam
>
