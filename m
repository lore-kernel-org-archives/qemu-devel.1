Received: from eggs.gnu.org ([2001:4830:134:3::10]:47384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da1ao-0006aR-Ox
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da1ao-0000r3-0o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:17:50 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <87eft4eeye.fsf@linaro.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-36-f4bug@amsat.org>
	<87lgncehbq.fsf@linaro.org>
	<5effed07-96c1-ae79-32a5-46b75516bf21@amsat.org>
	<87eft4eeye.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 25 Jul 2017 12:17:48 -0300
Message-ID: <CAAdtpL7qoN=Nn-ubFgmotB=O_BNMQ4nq4crKThuyBaORYbDi-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 35/35] script to run docker
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On Tue, Jul 25, 2017 at 12:03 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>> This isn't appropriate for 2.10 now we are feature frozen. That said I
>>
>> Surely. From the cover:
>>
>> "... provided at the end of this series as RFC for people wanted
>> to give a try (also include 'dockershell' script and a fix in
>> ./configure). These RFC patches (33-35) are not expected to enter
>> 2.10."
>
> My mistake - I hadn't gone over the cover letter. I would usually expect
> a series with [PATCH for 2.10] just to contain stuff being considered
> for the immediate future.

Ah I see, I used --subject-prefix=3D'PATCH for 2.10' thinking "I'v to
remember to mark the 3 last patches as "RFC" and when I prefixed with
"RFC" I forgot to remove the "for 2.10" suffix. My bad!
