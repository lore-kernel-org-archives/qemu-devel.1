Received: from eggs.gnu.org ([209.51.188.92]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2zK9-0003wN-I4
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2zK8-0005ax-RX
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:21:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2zK8-0005aA-Js
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:21:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
	<20190307113309.GN32268@redhat.com>
Date: Sun, 10 Mar 2019 15:21:02 +0100
In-Reply-To: <20190307113309.GN32268@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Thu, 7 Mar 2019 11:33:09 +0000")
Message-ID: <87ef7ex12p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]
> As long term contributors we've built enough enough knowledge to
> QEMU to consider our build system attractive or even "simple",

The words that come to my mind aren't "attractive" or "simple", but
"impressively clever", "brittle", and "uh, can I hack on something else
today?"

I've obviously failed to develop enough of a Stockholm Syndrome in 8+
years.

> which skews our view of the benefits of alternatives to people
> without this tribal knowledge.
