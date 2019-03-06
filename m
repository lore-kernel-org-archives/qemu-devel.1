Received: from eggs.gnu.org ([209.51.188.92]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1UGJ-0000PY-Lc
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1UGI-00036g-NQ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1UGI-00035n-Dm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:58:58 -0500
References: <cover.1550842915.git.berto@igalia.com>
	<w511s3lco9c.fsf@maestria.local.igalia.com>
	<CAMxuvaypw9B_Tdd0NmBscAoZozP87cO0m-nkoOX2=zdf6Rf5Jg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <196ce91d-50a5-1c36-c977-972d5dbe5a1c@redhat.com>
Date: Wed, 6 Mar 2019 11:58:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvaypw9B_Tdd0NmBscAoZozP87cO0m-nkoOX2=zdf6Rf5Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 05/03/19 16:55, Marc-Andr=C3=A9 Lureau wrote:
>> ping
> I can queue this in the next chardev PR. This can probably wait until
> the softfreeze though. I think Paolo had some plans to look at chardev
> issues.
>=20

Yes, I still do.  This week I'm a bit busy with Linux and babysitting...

Paolo
