Received: from eggs.gnu.org ([2001:4830:134:3::10]:33375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dn9zA-0004Iw-QZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dn9z7-0002Cp-Pc
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:53:16 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:31789)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dn9z7-0002CP-Jy
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:53:13 -0400
Date: Wed, 30 Aug 2017 21:53:11 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170830205311.GC979@jhogan-linux.le.imgtec.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817172249.31cf5e3d@nial.brq.redhat.com>
	<e3552801-588d-a192-1da4-0cefee5aa483@amsat.org>
	<20170830155008.1babd407@nial.brq.redhat.com>
	<bef4e017-02f3-62c4-1621-ec118709717c@amsat.org>
	<20170830181906.GB979@jhogan-linux.le.imgtec.org>
	<5e3c61b4-8564-7f10-d345-5bcf68203d94@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5e3c61b4-8564-7f10-d345-5bcf68203d94@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, Aug 30, 2017 at 04:52:04PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi James,
>=20
> On 08/30/2017 03:19 PM, James Hogan wrote:
> [...]
> >>     git://github.com/philmd/qemu.git tags/mips-qomify-20170830
> >=20
> > A sanity check of your branch doesn't reveal any obvious regressions
> > when booting a Malta KVM guest kernel with KVM.
>=20
> Thank you for your time to test this!
>=20
> Does that mean I can add your Tested-by: to the series?

Sure,

Cheers
James
