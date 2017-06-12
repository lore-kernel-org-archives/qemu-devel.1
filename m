Received: from eggs.gnu.org ([2001:4830:134:3::10]:40938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKNra-0005GQ-49
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKNrZ-00017N-FK
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:50:30 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKNrZ-000173-7d
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:50:29 -0400
Received: by mail-wr0-x229.google.com with SMTP id g76so93300541wrd.1
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 04:50:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2049897596.33250900.1497264741149.JavaMail.zimbra@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
	<CAFEAcA83HnSBD+c+pyUot+v-yBfhFvHU1J_zAb9ZqY3f9f-Sfg@mail.gmail.com>
	<2049897596.33250900.1497264741149.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 12:50:07 +0100
Message-ID: <CAFEAcA8Tb7Ma4jjh9JL7juCRL26gUuMdp0Rk3-ORt4SxvMeFTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] QAPI patches for 2017-06-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 June 2017 at 11:52, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om> wrote:
>> On 9 June 2017 at 14:46, Markus Armbruster <armbru@redhat.com> wrote:
>> Can you fix and resend the pullreq, please?
>
> Markus made me switch from g_assert_not_reached() to assert(0) in v3.
>
> He is on PTO this week, if you don't mind (as you wanted this
> series applied quickly), you could fix it by adding dummy return?

I can't fix up signed pullrequests on my end, I'm afraid.

thanks
-- PMM
