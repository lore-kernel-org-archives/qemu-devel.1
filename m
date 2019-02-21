Received: from eggs.gnu.org ([209.51.188.92]:35186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwmEP-0004Gv-FV
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwmEL-00085Y-In
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:09:33 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gwmEJ-000811-Pn
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:09:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id n2so17347070wrw.8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 03:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-3-philmd@redhat.com>
	<CAMxuvawBXN3CwFhWwyUathUy-+SbURFAy_g8scf54UQx-j+84A@mail.gmail.com>
	<d9b63b89-091d-3a7b-fa74-5f91ce6890ff@redhat.com>
	<nycvar.YSQ.7.76.1902211633210.4028@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1902211633210.4028@xnncv>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Feb 2019 12:09:12 +0100
Message-ID: <CAJ+F1CL6pK-CSqHDu92daB_sAGsfWm1ukya_1YM-evx5CzgmKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/9] ccid-card-passthru: Replace never
 trigger if statement by an assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Arash Tohidi Chafi <tohidi.arash@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Thu, Feb 21, 2019 at 12:06 PM P J P <ppandit@redhat.com> wrote:
>
> +-- On Mon, 18 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote --+
> | On 2/15/19 11:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> | Arash or Prasad can you help us here? Do you have a reproducer?
>
> No, we don't have a reproducer handy I'm afraid.

Without a reproducer or convincing arguments, do we have a CVE?


--=20
Marc-Andr=C3=A9 Lureau
