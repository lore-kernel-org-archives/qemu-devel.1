Received: from eggs.gnu.org ([209.51.188.92]:60142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1h1zdK-0003Cg-Mc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1h1zdK-0004fR-0a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:28:50 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1h1zdJ-0004ea-IT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:28:49 -0500
Received: by mail-wr1-x42a.google.com with SMTP id i16so18975980wrs.13
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 12:28:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
Date: Thu, 7 Mar 2019 22:28:45 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FF93371-F286-4ABB-98D7-C5439656580F@livius.net>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
	<CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>



> On 7 Mar 2019, at 20:18, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Thu, 7 Mar 2019 at 18:17, Marc-Andr=C3=A9 Lureau
>> ... deprecate ... in-srcdir
>=20
> Do we need to bother to deprecate it? It doesn't affect end-users,
> only those who build QEMU, and the change is easy...

no problems for the GNU MCU Eclipse QEMU distribution, only =
out-of-srcdir builds used.


regards,

Liviu
