Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE64-0005tu-PG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE60-0000eK-0d
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:20:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqE5z-0000dN-RF
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:20:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-7-git-send-email-armbru@redhat.com>
	<1870195462.9856771.1490016728266.JavaMail.zimbra@redhat.com>
	<CAFEAcA-tsr2n-M-EmuNDnfbFwR8E9iA3MoVC+aCBGTzK3m9vjQ@mail.gmail.com>
Date: Tue, 21 Mar 2017 08:20:39 +0100
In-Reply-To: <CAFEAcA-tsr2n-M-EmuNDnfbFwR8E9iA3MoVC+aCBGTzK3m9vjQ@mail.gmail.com>
	(Peter Maydell's message of "Mon, 20 Mar 2017 13:37:58 +0000")
Message-ID: <87k27jt7so.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 6/6] qapi2texi: Fix translation of
 *strong* and _emphasized_
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 March 2017 at 13:32, Marc-Andr=C3=A9 Lureau <mlureau@redhat.com> wr=
ote:
>>
>>
>> ----- Original Message -----
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> weird this disparity went so far unnoticed
>
> You think people read the documentation? :-)

It's exactly the kind of stupid pasto that gets caught only when you
write systematic tests and carefully check their output against your
expectations.
