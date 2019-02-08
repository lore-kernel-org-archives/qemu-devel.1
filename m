Received: from eggs.gnu.org ([209.51.188.92]:49825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9nZ-000864-0g
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9nY-0007Qa-Gz
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:18:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gs9nY-0007Pc-9P
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:18:44 -0500
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
	<21d093b7-d414-f049-6dbc-e15af138ca8f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80f10fa7-d283-d97d-7f08-2372beb9ed7b@redhat.com>
Date: Fri, 8 Feb 2019 18:18:26 +0100
MIME-Version: 1.0
In-Reply-To: <21d093b7-d414-f049-6dbc-e15af138ca8f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 08/02/19 17:07, Philippe Mathieu-Daud=C3=A9 wrote:
> And yet this isn't a pull request but a simple patch, so the Message-Id
> might not be very relevant there.

Yes, I agree that Message-Id is not that relevant if you're taking a
patch from someone else and then reposting it.  But it's a relatively
rare case when >1 people are collaborating on revisions of a series.

Paolo
