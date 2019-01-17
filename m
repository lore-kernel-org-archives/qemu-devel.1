Received: from eggs.gnu.org ([209.51.188.92]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk2xL-00020u-9O
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk2xK-0006FZ-K7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:23:19 -0500
References: <20190117075327.22194-1-clg@kaod.org>
	<20190117075327.22194-5-clg@kaod.org>
	<20190117092054.355ff46e@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb422368-b2ea-9239-121b-1dbe78130d1f@redhat.com>
Date: Thu, 17 Jan 2019 09:23:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190117092054.355ff46e@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: remove the interrupt presenters
 from under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2019-01-17 09:20, Greg Kurz wrote:
> On Thu, 17 Jan 2019 08:53:27 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>=20
> The patch looks good, but I think it would be even better to apply this=
 before
> Thomas's -std=3Dc99 patchset. This would allow to get rid of the contro=
versial
> "ppc: Fix duplicated typedefs to be able to compile  with Clang in gnu9=
9 mode"
> patch :)

Ok, I haven't started to send v3 of my PULL request yet, so I can try to
use these patches here instead...

 Thomas
