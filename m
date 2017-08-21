Received: from eggs.gnu.org ([2001:4830:134:3::10]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djiWq-0008KL-KX
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djiWn-0003yb-Iz
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:57:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1djiWn-0003yS-CZ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:57:45 -0400
Date: Mon, 21 Aug 2017 10:57:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170821105740.7cf39941@nial.brq.redhat.com>
In-Reply-To: <d311ba1a-b494-d1bd-da4f-89ed52ede072@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817043102.6322-3-f4bug@amsat.org>
	<20170817163830.1a6f32ed@nial.brq.redhat.com>
	<df43cc8b-70d1-5ae5-371c-8ca6318231df@amsat.org>
	<d311ba1a-b494-d1bd-da4f-89ed52ede072@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] mips: introduce internal.h and cleanup
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 18 Aug 2017 17:03:03 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Igor,
>=20
> On 08/17/2017 12:06 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> no logical change, only code movement (and fix a comment typo). =20
> >  =20
> >> while at that fix checkpatch errors or
> >> first fix checkpatch noted issues in cpu.h and then move it in next=20
> >> patch to internal.h =20
>=20
> After asking confirmation on IRC these 3 checkpatch issues are false=20
> positives, and I'm not fluent in Perl to fix it, so I'll add a comment=20
> about it in the next series cover.
fine by me

>=20
> Regards,
>=20
> Phil.
